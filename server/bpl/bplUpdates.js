// bplUpdates.js
// Business Process Layer for Update entities
//
// Notes:
// - Updates are tied to properties via idProperty
// - Each update represents a revision to projections for a property
// - Load flow: fetch update row from dal
// - List flow: get all updates for a property (timeline), sorted newest first
// - Insert flow: create new update record
// - Update flow: modify existing update record
// - Delete flow: remove update record
//
// idProperty references the Property entity (idEntity from Property-Position)

import dalUpdates from '../dal/dalUpdates.js';
import dalEntity from '../dal/dalEntity.js';
import dalDB from '../dal/dalDB.js';

const ENTITY_TYPE_UPDATE = 5;

const bplUpdates = {

  // ---------------------------------------------------------------------------
  // LOAD (by idEntity) -> returns ONE update row
  // ---------------------------------------------------------------------------
  loadUpdate: function (data, callback) {
    // expects: { idEntity }
    dalUpdates.selectUpdate(data, (err, result) => {
      if (!err && result && result[0] && result[0][0]) {
        callback(false, result[0][0]); // return ONE row
      }
      else callback(false, { error: err });
    });
  },

  // ---------------------------------------------------------------------------
  // LOAD timeline for a property -> returns ARRAY of updates (newest first)
  // ---------------------------------------------------------------------------
  loadUpdatesForProperty: function (data, callback) {
    // expects: { idProperty }
    dalUpdates.selectUpdatesByProperty(data, (err, result) => {
      if (!err && result && result[0]) {
        callback(false, result[0]); // return array of rows
      }
      else callback(false, { error: err });
    });
  },

  // ---------------------------------------------------------------------------
  // LOAD updates by date range for a property
  // ---------------------------------------------------------------------------
  loadUpdatesForPropertyByDateRange: function (data, callback) {
    // expects: { idProperty, startDate, endDate }
    dalUpdates.selectUpdatesByDateRange(data, (err, result) => {
      if (!err && result && result[0]) {
        callback(false, result[0]); // return array of rows
      }
      else callback(false, { error: err });
    });
  },

  // ---------------------------------------------------------------------------
  // INSERT
  // 1) create Entity first (generates idEntity on server)
  // 2) insert update record with generated idEntity
  // 3) commit
  // returns created update row (as DAL returns it)
  // ---------------------------------------------------------------------------
  insertUpdate: function (data, callback) {
    // expects minimally:
    // {
    //   idProperty,
    //   propertyName,
    //   updateDate,
    //   // optional: revisedSaleDate, revisedIrrPct, revisedEquityMultiple, distributionGuidance, notes
    // }
    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        const entityData = {
          entityTitle: data.propertyName || 'Update',
          entityType: ENTITY_TYPE_UPDATE,
          entityDesc: ''
        };

        dalEntity.insertEntity(entityData, (errEntity, resultEntity) => {
          if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0] && resultEntity[0][0].idEntity) {
            const idEntity = resultEntity[0][0].idEntity;
            let insData = { ...data, idEntity };
            // normalize date fields to avoid formatting issues
            insData = dalDB.normalizeDates(insData, ['updateDate','revisedSaleDate']);

            dalUpdates.insertUpdate(insData, (err, result) => {
              if (!err && result && result[0] && result[0][0]) {
                dalDB.commitTransaction((errCommit) => {
                  if (!errCommit) callback(false, result[0][0]);
                  else dalDB.rollbackTransaction(() => { callback(false, { error: errCommit }); });
                });
              }
              else {
                dalDB.rollbackTransaction(() => { callback(false, { error: err }); });
              }
            });
          }
          else {
            dalDB.rollbackTransaction(() => { callback(false, { error: errEntity }); });
          }
        });
      }
      else callback(false, { error: errBegin });
    });
  },

  // ---------------------------------------------------------------------------
  // UPDATE
  // 1) update update record with new values
  // returns: { response: 'Success' } on success
  // ---------------------------------------------------------------------------
  updateUpdate: function (data, callback) {
    // expects:
    // {
    //   idEntity,
    //   idProperty,
    //   propertyName,
    //   updateDate,
    //   // optional fields to update: revisedSaleDate, revisedIrrPct, revisedEquityMultiple, distributionGuidance, notes
    // }
    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        const upd = dalDB.normalizeDates(data, ['updateDate','revisedSaleDate'])
        dalUpdates.updateUpdate(upd, (err) => {
          if (!err) {
            dalDB.commitTransaction((errCommit) => {
              if (!errCommit) callback(false, { response: 'Success' });
              else dalDB.rollbackTransaction(() => { callback(false, { error: errCommit }); });
            });
          }
          else {
            dalDB.rollbackTransaction(() => { callback(false, { error: err }); });
          }
        });
      }
      else callback(false, { error: errBegin });
    });
  },

  // ---------------------------------------------------------------------------
  // DELETE
  // 1) delete update record
  // returns: { response: 'Success' } on success
  // ---------------------------------------------------------------------------
  deleteUpdate: function (data, callback) {
    // expects: { idEntity }
    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        dalUpdates.deleteUpdate(data, (err) => {
          if (!err) {
            dalDB.commitTransaction((errCommit) => {
              if (!errCommit) callback(false, { response: 'Success' });
              else dalDB.rollbackTransaction(() => { callback(false, { error: errCommit }); });
            });
          }
          else {
            dalDB.rollbackTransaction(() => { callback(false, { error: err }); });
          }
        });
      }
      else callback(false, { error: errBegin });
    });
  }

};

export default bplUpdates;
