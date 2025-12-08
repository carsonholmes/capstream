// routes/updates.js
import express from 'express';
import parseReq from '../shared/parseReq.js';
import bplUpdates from '../bpl/bplUpdates.js';

const router = express.Router();

/**
 * GET /updates/test
 * Test endpoint
 */
router.get('/test', (req, res) => {
  console.log("Test");
  res.send("Success");
  return;
});

/**
 * POST /updates/list
 * List updates for a specific property
 * expects body: { propertyId }
 * returns: array of updates
 */
router.post('/list', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplUpdates.loadUpdatesForProperty(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
  return;
});

/**
 * POST /updates/load
 * Load a single update by ID
 * expects body: { idUpdate }
 * returns: one update row
 */
router.post('/load', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplUpdates.loadUpdate(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /updates/add
 * Create a new update
 * expects minimally:
 *   {
 *     propertyId,
 *     updateDate,
 *     // optional: revisedSaleDate, revisedIrrPct, revisedEquityMultiple, distributionGuidance, notes
 *   }
 * returns: created row
 */
router.post('/add', (req, res) => {
  console.log('Web service call received for: updates - add');
  parseReq.parseJSONfromBody(req, (data) => {
    bplUpdates.insertUpdate(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /updates/update
 * Update an existing update record
 * expects body:
 *   {
 *     idUpdate,
 *     // optional fields to update: updateDate, revisedSaleDate, revisedIrrPct, revisedEquityMultiple, distributionGuidance, notes
 *   }
 * returns: { response: 'Success' } or { error }
 */
router.post('/update', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplUpdates.updateUpdate(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /updates/delete
 * Delete an update record
 * expects body: { idUpdate }
 * returns: { response: 'Success' } or { error }
 */
router.post('/delete', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplUpdates.deleteUpdate(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

export default router;
