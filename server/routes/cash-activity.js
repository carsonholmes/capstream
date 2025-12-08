// routes/cash-activity.js
import express from 'express';
import parseReq from '../shared/parseReq.js';
import bplCashActivity from '../bpl/bplCashActivity.js';

const router = express.Router();

/**
 * GET /cash-activity/test
 * Test endpoint
 */
router.get('/test', (req, res) => {
  console.log("Test");
  res.send("Success");
  return;
});

/**
 * POST /cash-activity/list
 * List cash activities for a specific property
 * expects body: { idProperty }
 * returns: array of cash activities
 */
router.post('/list', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplCashActivity.loadCashActivitiesForProperty(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
  return;
});

/**
 * POST /cash-activity/load
 * Load a single cash activity by ID
 * expects body: { idEntity }
 * returns: one cash activity row
 */
router.post('/load', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplCashActivity.loadCashActivity(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /cash-activity/add
 * Create a new cash activity
 * expects minimally:
 *   {
 *     idEntity,
 *     idProperty,
 *     activityDate,
 *     activityType,  -- e.g., Contribution/Distribution/Expense/Income
 *     amount,
 *     // optional: notes
 *   }
 * returns: created row
 */
router.post('/add', (req, res) => {
  console.log('Web service call received for: cash-activity - add');
  parseReq.parseJSONfromBody(req, (data) => {
    bplCashActivity.insertCashActivity(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /cash-activity/update
 * Update an existing cash activity record
 * expects body:
 *   {
 *     idEntity,
 *     idProperty,
 *     activityDate,
 *     activityType,
 *     amount,
 *     // optional: notes
 *   }
 * returns: { response: 'Success' } or { error }
 */
router.post('/update', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplCashActivity.updateCashActivity(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /cash-activity/delete
 * Delete a cash activity record
 * expects body: { idEntity }
 * returns: { response: 'Success' } or { error }
 */
router.post('/delete', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplCashActivity.deleteCashActivity(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

/**
 * POST /cash-activity/by-date-range
 * Get cash activities for a property within a date range
 * expects body: { idProperty, startDate, endDate }
 * returns: array of cash activities
 */
router.post('/by-date-range', (req, res) => {
  parseReq.parseJSONfromBody(req, (data) => {
    bplCashActivity.loadCashActivitiesForPropertyByDateRange(data, (err, result) => {
      if (err) res.status(500).json({ error: err });
      else res.send(result);
    });
  });
});

export default router;
