// dalUpdates.js
// Table: cap-update

// NOTE: Uses the existing mysql db wrapper. Do not modify dalDB.js.
// Import path assumes ../shared/db.js exports { dbo } with a mysql connection.
import db from '../shared/db.js';

const dalUpdates = {
  // -----------------------------------------------------
  // INSERT
  // -----------------------------------------------------
  insertUpdate: (data, callback) => {
    const params =
      `("${data.idEntity}","${data.idProperty}","${data.propertyName}",` +
      `"${data.updateDate}","${data.revisedSaleDate}","${data.revisedIrrPct}",` +
      `"${data.revisedEquityMultiple}","${data.distributionGuidance}","${data.notes}")`;

    try {
      db.dbo.query('CALL insertUpdate' + params, (err, result) => {
        if (err) {
          console.error('Error inserting update:', err);
          callback(err, 'Error inserting update');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error inserting update:', err);
      callback(err, 'Error inserting update');
    }
  },

  // -----------------------------------------------------
  // SELECT (by idEntity)
  // -----------------------------------------------------
  selectUpdate: (data, callback) => {
    const params = `("${data.idEntity}")`;

    try {
      db.dbo.query('CALL selectUpdate' + params, (err, result) => {
        if (err) {
          console.error('Error selecting update:', err);
          callback(err, 'Error selecting update');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting update:', err);
      callback(err, 'Error selecting update');
    }
  },

  // -----------------------------------------------------
  // SELECT timeline by property (newest first)
  // -----------------------------------------------------
  selectUpdatesByProperty: (data, callback) => {
    const params = `("${data.idProperty}")`;

    try {
      db.dbo.query('CALL selectUpdatesByProperty' + params, (err, result) => {
        if (err) {
          console.error('Error selecting updates by property:', err);
          callback(err, 'Error selecting updates by property');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting updates by property:', err);
      callback(err, 'Error selecting updates by property');
    }
  },

  // -----------------------------------------------------
  // SELECT by date range for a property
  // -----------------------------------------------------
  selectUpdatesByDateRange: (data, callback) => {
    const params = `("${data.idProperty}","${data.startDate}","${data.endDate}")`;

    try {
      db.dbo.query('CALL selectUpdatesByDateRange' + params, (err, result) => {
        if (err) {
          console.error('Error selecting updates by date range:', err);
          callback(err, 'Error selecting updates by date range');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting updates by date range:', err);
      callback(err, 'Error selecting updates by date range');
    }
  },

  // -----------------------------------------------------
  // UPDATE (by idEntity)
  // -----------------------------------------------------
  updateUpdate: (data, callback) => {
    const params =
      `("${data.idEntity}","${data.idProperty}","${data.propertyName}",` +
      `"${data.updateDate}","${data.revisedSaleDate}","${data.revisedIrrPct}",` +
      `"${data.revisedEquityMultiple}","${data.distributionGuidance}","${data.notes}")`;

    try {
      db.dbo.query('CALL updateUpdate' + params, (err, result) => {
        if (err) {
          console.error('Error updating update:', err);
          callback(err, 'Error updating update');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error updating update:', err);
      callback(err, 'Error updating update');
    }
  },

  // -----------------------------------------------------
  // DELETE (by idEntity)
  // -----------------------------------------------------
  deleteUpdate: (data, callback) => {
    const params = `("${data.idEntity}")`;

    try {
      db.dbo.query('CALL deleteUpdate' + params, (err, result) => {
        if (err) {
          console.error('Error deleting update:', err);
          callback(err, 'Error deleting update');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error deleting update:', err);
      callback(err, 'Error deleting update');
    }
  }
};

export default dalUpdates;
