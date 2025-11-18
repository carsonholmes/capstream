// dalPropertyPosition.js
// Table: property-position

// NOTE: Uses the existing mysql db wrapper. Do not modify dalDB.js.
// Import path assumes ../shared/db.js exports { dbo } with a mysql connection.
import db from '../shared/db.js';

const dalPropertyPosition = {
  // -----------------------------------------------------
  // INSERT
  // -----------------------------------------------------
  insertPropertyPosition: (data, callback) => {
    const params = `("${data.idEntity}","${data.propertyName}","${data.sponsorGP}","${data.partnershipLP}",` +
                   `"${data.acquisitionDate}","${data.propertyNotes}",` +
                   `"${data.lpEntity}","${data.investedEquity}","${data.investmentDate}",` +
                   `"${data.ownershipPct}","${data.prefReturnPct}","${data.distributionCadence}",` +
                   `"${data.targetIRR}","${data.targetEquityMultiple}","${data.projectedSaleDate}")`;

    try {
      db.dbo.query('CALL insertPropertyPosition' + params, (err, result) => {
        if (err) {
          console.error('Error inserting property-position:', err);
          callback(err, 'Error inserting property-position');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error inserting property-position:', err);
      callback(err, 'Error inserting property-position');
    }
  },

  // -----------------------------------------------------
  // SELECT (by idEntity)
  // -----------------------------------------------------
  selectPropertyPosition: (data, callback) => {
    const params = `("${data.idEntity}")`;

    try {
      db.dbo.query('CALL selectPropertyPosition' + params, (err, result) => {
        if (err) {
          console.error('Error selecting property-position:', err);
          callback(err, 'Error selecting property-position');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting property-position:', err);
      callback(err, 'Error selecting property-position');
    }
  },

  // -----------------------------------------------------
  // SELECT (by idEntity)
  // -----------------------------------------------------
  loadPositionsForClient: (data, callback) => {
    const params = `("${data.activeClient}")`;

    try {
      db.dbo.query('CALL selectPropertyPositionByClient' + params, (err, result) => {
        if (err) {
          console.error('Error selecting property-position:', err);
          callback(err, 'Error selecting property-position');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting property-position:', err);
      callback(err, 'Error selecting property-position');
    }
  },

  // -----------------------------------------------------
  // SELECT by propertyName (exact match per SP)
  // -----------------------------------------------------
  selectPropertyPositionByPropertyName: (data, callback) => {
    const params = `("${data.propertyName}")`;

    try {
      db.dbo.query('CALL selectPropertyPositionByPropertyName' + params, (err, result) => {
        if (err) {
          console.error('Error selecting property-position by propertyName:', err);
          callback(err, 'Error selecting property-position by propertyName');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting property-position by propertyName:', err);
      callback(err, 'Error selecting property-position by propertyName');
    }
  },

  // -----------------------------------------------------
  // SELECT by lpEntity (exact match per SP)
  // -----------------------------------------------------
  selectPropertyPositionByLpEntity: (data, callback) => {
    const params = `("${data.lpEntity}")`;

    try {
      db.dbo.query('CALL selectPropertyPositionByLpEntity' + params, (err, result) => {
        if (err) {
          console.error('Error selecting property-position by lpEntity:', err);
          callback(err, 'Error selecting property-position by lpEntity');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting property-position by lpEntity:', err);
      callback(err, 'Error selecting property-position by lpEntity');
    }
  },

  // -----------------------------------------------------
  // UPDATE (by idEntity)
  // -----------------------------------------------------
  updatePropertyPosition: (data, callback) => {
    const params = `("${data.idEntity}","${data.propertyName}","${data.sponsorGP}","${data.partnershipLP}",` +
                   `"${data.acquisitionDate}","${data.propertyNotes}",` +
                   `"${data.lpEntity}","${data.investedEquity}","${data.investmentDate}",` +
                   `"${data.ownershipPct}","${data.prefReturnPct}","${data.distributionCadence}",` +
                   `"${data.targetIRR}","${data.targetEquityMultiple}","${data.projectedSaleDate}")`;

    try {
      db.dbo.query('CALL updatePropertyPosition' + params, (err, result) => {
        if (err) {
          console.error('Error updating property-position:', err);
          callback(err, 'Error updating property-position');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error updating property-position:', err);
      callback(err, 'Error updating property-position');
    }
  },

  // -----------------------------------------------------
  // DELETE (by idEntity)
  // -----------------------------------------------------
  deletePropertyPosition: (data, callback) => {
    const params = `("${data.idEntity}")`;

    try {
      db.dbo.query('CALL deletePropertyPosition' + params, (err, result) => {
        if (err) {
          console.error('Error deleting property-position:', err);
          callback(err, 'Error deleting property-position');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error deleting property-position:', err);
      callback(err, 'Error deleting property-position');
    }
  }
};

export default dalPropertyPosition;
