// routes/positions.js
import express from 'express';
import parseReq from '../shared/parseReq.js';
import bplPropertiesAndPositions from '../bpl/bplPropertiesAndPositions.js';

const router = express.Router();

/**
 * GET /positions/list
 * Optional query support:
 *   ?lpEntity=<uuid>                -> bpl.loadPropertyPositionsByLpEntity
 *   ?propertyName=<string>          -> bpl.loadPropertyPositionsByPropertyName
 *
 * Note:
 *   Your cdo currently calls list() with no params. Since the BPL has no "list all"
 *   method, this route will return 400 unless a filter is provided.
 *   (If you add a BPL list-all later, just call it from here.)
 */

router.get('/test', (req, res) => {
    console.log("Test")
    res.send("Success");
    return;
});


router.post('/list', (req, res) => {
    parseReq.parseJSONfromBody(req, (data) => { 
        bplPropertiesAndPositions.loadPositionsForClient(data, (err, result) => {
        if (err) res.status(500).json({ error: err });
        else res.send(result);
        });
    });
    return;
});

/**
 * PUT /positions/load
 * expects body: { idEntity }
 * returns: ONE merged row
 */
router.post('/load', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplPropertiesAndPositions.loadPropertyPosition(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * post /positions/add
 * expects minimally:
 *   {
 *     propertyName, propertyNotes?,
 *     // other Property-Position fields required by DAL insert
 *     // optional: entityType (defaults in BPL to ENTITY_TYPE_PAP)
 *   }
 * returns: created row (as DAL returns it)
 */
router.post('/add', (req, res) => {
  console.log('Web service call received for: positions - add');
  parseReq.parseJSONfromBody(req, (data) => {
    bplPropertiesAndPositions.insertPropertyPosition(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * post /positions/update
 * expects body:
 *   {
 *     idEntity,
 *     propertyName, propertyNotes?,
 *     ... other Property-Position fields for update
 *   }
 * returns: { response: 'Success' } or { error }
 */
router.post('/update', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplPropertiesAndPositions.updatePropertyPosition(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * post /positions/delete
 * expects body: { idEntity }
 * returns: { response: 'Success' } or { error }
 */
router.post('/delete', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplPropertiesAndPositions.deletePropertyPosition(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

export default router;
