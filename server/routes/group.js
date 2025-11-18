// routesGroup.js
import express from 'express';
import parseReq from '../shared/parseReq.js';
import bplGroup from '../bpl/bplGroup.js';

const router = express.Router();

/**
 * POST /group/load
 * expects: { idEntity }
 * returns: merged single group row (group + entity fields)
 */
router.post('/load', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplGroup.loadGroup(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /group/list
 * expects: { entityType }
 * returns: [{ idEntity, groupTitle }]
 */
router.get('/list', (req, res) => {
  console.log("List groups")
    bplGroup.loadGroupList((err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
});

/**
 * POST /group/add
 * expects: { entityType, entityTitle, entityDesc?, groupType }
 * returns: merged group row after insert
 */
router.post('/add', (req, res) => {
  console.log('Web service call received for: group - add');
  parseReq.parseJSONfromBody(req, (data) => {
    console.log(JSON.stringify(data,null,2))
    bplGroup.insertGroup(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /group/update
 * expects: { idEntity, groupType, entityTitle?, entityDesc? }
 * returns: { response: 'Success' } or { error }
 */
router.post('/update', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplGroup.updateGroup(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /group/delete
 * expects: { idEntity }
 * returns: { response: 'Success' } or { error }
 */
router.post('/delete', (req, res) => {
  console.log("delete group")
  parseReq.parseJSONfromBody(req, (data) => {
    bplGroup.deleteGroup(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

export default router;
