// --- add this near the top of routes/attachments.js ---
import express from 'express'
import fs from 'fs';
import path from 'path';
import mime from 'mime-types';
import bplAttachments from '../bpl/bplAttachments.js';

const router = express.Router();

function toEtag(stat) {
  return `W/"${stat.size.toString(16)}-${stat.mtimeMs.toString(16)}"`;
}

function setDownloadHeaders(res, { mimeType, originalName, inline }) {
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('Content-Type', mimeType || 'application/octet-stream');

  const disp = inline ? 'inline' : 'attachment';
  const safeName = (originalName || 'download').replace(/"/g, '\\"');
  res.setHeader(
    'Content-Disposition',
    `${disp}; filename="${safeName}"; filename*=UTF-8''${encodeURIComponent(originalName || 'download')}`
  );

  // allow resume in clients
  res.setHeader('Accept-Ranges', 'bytes');
}

// GET /attachments/download?idAttachment=... [&inline=1]
router.get('/download', async (req, res, next) => {
  try {
    const idAttachment = req.query.idAttachment || req.query.id;
    if (!idAttachment) return res.status(400).json({ error: 'idAttachment is required' });

    const inline = req.query.inline === '1';

    // You implement this to do authZ + lookup + return a trusted absolute path:
    // { absolutePath, originalName?, mimeType? }
    const info = await bplAttachments.getDownloadInfo(idAttachment);
    if (!info || !info.absolutePath) return res.sendStatus(404);

    const filePath = path.resolve(info.absolutePath);
    let stat;
    try {
      stat = fs.statSync(filePath);
    } catch {
      return res.sendStatus(410); // was referenced but missing
    }

    const originalName = info.originalName || path.basename(filePath);
    const mimeType = info.mimeType || mime.lookup(filePath) || 'application/octet-stream';
    const etag = toEtag(stat);

    // 304 short-circuit
    if (req.headers['if-none-match'] === etag) return res.sendStatus(304);
    const ims = req.headers['if-modified-since'];
    if (ims && new Date(ims) >= stat.mtime) return res.sendStatus(304);

    setDownloadHeaders(res, { mimeType, originalName, inline });
    res.setHeader('Content-Length', String(stat.size));
    res.setHeader('Last-Modified', stat.mtime.toUTCString());
    res.setHeader('ETag', etag);

    // Minimal If-Range handling: if present and doesn't match, ignore Range
    const ifRange = req.headers['if-range'];
    const ifRangeMatches =
      !ifRange || ifRange === etag || (Date.parse(ifRange) && new Date(ifRange) >= stat.mtime);

    // Single-range support
    const range = req.headers.range;
    if (range && ifRangeMatches) {
      const m = /^bytes=(\d*)-(\d*)$/.exec(range);
      if (m) {
        let start = m[1] ? parseInt(m[1], 10) : 0;
        let end = m[2] ? parseInt(m[2], 10) : stat.size - 1;

        if (Number.isNaN(start) || Number.isNaN(end) || start > end || end >= stat.size) {
          res.setHeader('Content-Range', `bytes */${stat.size}`);
          return res.sendStatus(416);
        }

        res.status(206);
        res.setHeader('Content-Range', `bytes ${start}-${end}/${stat.size}`);
        res.setHeader('Content-Length', String(end - start + 1));

        const rs = fs.createReadStream(filePath, { start, end });
        rs.on('error', next);
        return rs.pipe(res);
      }
    }

    // Full stream
    const rs = fs.createReadStream(filePath);
    rs.on('error', next);
    rs.pipe(res);
  } catch (err) {
    next(err);
  }
});


/**
 * POST /entity-attachments/list
 * Body: { idEntity }
 * Returns: Array of rows (newest first) or { error }
 */
router.post('/list', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplEntityAttachments.loadAttachmentsByEntity(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /entity-attachments/load
 * Body: { idAttachment }
 * Returns: Single attachment row or { error }
 */
router.post('/load', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplEntityAttachments.loadAttachment(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /entity-attachments/add
 * Body:
 *  {
 *    idAttachment,  idEntity,
 *    name, fileName, fileSize, fileExt,
 *    dtAdded?       // optional
 *  }
 * Returns: Inserted + reloaded row or { error }
 */
router.post('/add', (req, res) => {
  console.log('Web service call received for: entity-attachments - add');
  parseReq.parseJSONfromBody(req, (data) => {
    bplEntityAttachments.insertAttachment(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /entity-attachments/update
 * Body (min):
 *  {
 *    idAttachment, idEntity,
 *    // fields to update: name, fileName, fileSize, fileExt, dtAdded?
 *  }
 * Returns: { response: 'Success' } or { error }
 */
router.post('/update', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplEntityAttachments.updateAttachment(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /entity-attachments/delete
 * Body: { idAttachment }
 * Returns: { response: 'Success' } or { error }
 */
router.post('/delete', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplEntityAttachments.deleteAttachment(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

export default router;
