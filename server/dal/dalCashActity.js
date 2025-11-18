// dalCashActivity.js
// Table: cash-activity (stored procedures assumed to exist)
//
// NOTE: Uses the existing mysql db wrapper. Do not modify dalDB.js.
// Import path assumes ../shared/db.js exports { dbo } with a mysql connection.

import db from '../shared/db.js';

const dalCashActivity = {
  // -----------------------------------------------------
  // INSERT
  // -----------------------------------------------------
  // Expected SP signature:
  //   insertCashActivity(
  //     p_idEntity CHAR(36),
  //     p_idProperty CHAR(36),
  //     p_activityDate DATE,
  //     p_activityType VARCHAR(32),  -- e.g., Contribution/Distribution/Expense/Income
  //     p_amount DECIMAL(18,2),
  //     p_notes TEXT
  //   )
  insertCashActivity: (data, callback) => {
    const params =
      `("${data.idEntity}","${data.idProperty}","${data.activityDate}",` +
      `"${data.activityType}","${data.amount}","${data.notes}")`;

    try {
      db.dbo.query('CALL insertCashActivity' + params, (err, result) => {
        if (err) {
          console.error('Error inserting cash-activity:', err);
          callback(err, 'Error inserting cash-activity');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error inserting cash-activity:', err);
      callback(err, 'Error inserting cash-activity');
    }
  },

  // -----------------------------------------------------
  // SELECT (by idEntity)
  // -----------------------------------------------------
  // Expected SP signature: selectCashActivity(p_idEntity CHAR(36))
  selectCashActivity: (data, callback) => {
    const params = `("${data.idEntity}")`;

    try {
      db.dbo.query('CALL selectCashActivity' + params, (err, result) => {
        if (err) {
          console.error('Error selecting cash-activity:', err);
          callback(err, 'Error selecting cash-activity');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting cash-activity:', err);
      callback(err, 'Error selecting cash-activity');
    }
  },

  // -----------------------------------------------------
  // SELECT all activities for a property (newest first)
  // -----------------------------------------------------
  // Expected SP signature: selectCashActivitiesByProperty(p_idProperty CHAR(36))
  selectCashActivitiesByProperty: (data, callback) => {
    const params = `("${data.idProperty}")`;

    try {
      db.dbo.query('CALL selectCashActivitiesByProperty' + params, (err, result) => {
        if (err) {
          console.error('Error selecting cash-activities by property:', err);
          callback(err, 'Error selecting cash-activities by property');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting cash-activities by property:', err);
      callback(err, 'Error selecting cash-activities by property');
    }
  },

  // -----------------------------------------------------
  // SELECT by date range for a property
  // -----------------------------------------------------
  // Expected SP signature:
  //   selectCashActivitiesByDateRange(p_idProperty CHAR(36), p_startDate DATE, p_endDate DATE)
  selectCashActivitiesByDateRange: (data, callback) => {
    const params = `("${data.idProperty}","${data.startDate}","${data.endDate}")`;

    try {
      db.dbo.query('CALL selectCashActivitiesByDateRange' + params, (err, result) => {
        if (err) {
          console.error('Error selecting cash-activities by date range:', err);
          callback(err, 'Error selecting cash-activities by date range');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting cash-activities by date range:', err);
      callback(err, 'Error selecting cash-activities by date range');
    }
  },

  // -----------------------------------------------------
  // UPDATE (by idEntity)
  // -----------------------------------------------------
  // Expected SP signature:
  //   updateCashActivity(
  //     p_idEntity CHAR(36),
  //     p_idProperty CHAR(36),
  //     p_activityDate DATE,
  //     p_activityType VARCHAR(32),
  //     p_amount DECIMAL(18,2),
  //     p_notes TEXT
  //   )
  updateCashActivity: (data, callback) => {
    const params =
      `("${data.idEntity}","${data.idProperty}","${data.activityDate}",` +
      `"${data.activityType}","${data.amount}","${data.notes}")`;

    try {
      db.dbo.query('CALL updateCashActivity' + params, (err, result) => {
        if (err) {
          console.error('Error updating cash-activity:', err);
          callback(err, 'Error updating cash-activity');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error updating cash-activity:', err);
      callback(err, 'Error updating cash-activity');
    }
  },

  // -----------------------------------------------------
  // DELETE (by idEntity)
  // -----------------------------------------------------
  // Expected SP signature: deleteCashActivity(p_idEntity CHAR(36))
  deleteCashActivity: (data, callback) => {
    const params = `("${data.idEntity}")`;

    try {
      db.dbo.query('CALL deleteCashActivity' + params, (err, result) => {
        if (err) {
          console.error('Error deleting cash-activity:', err);
          callback(err, 'Error deleting cash-activity');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error deleting cash-activity:', err);
      callback(err, 'Error deleting cash-activity');
    }
  }
};

export default dalCashActivity;
