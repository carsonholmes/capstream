// bplCashActivity.js
// Business Process Layer for Cash Activity entities
//
// Notes:
// - Cash activities are tied to properties via idProperty
// - Each activity represents a cash event (contribution, distribution, expense, income)
// - Load flow: fetch cash activity row from dal
// - List flow: get all cash activities for a property, sorted newest first
// - Insert flow: create new cash activity record
// - Update flow: modify existing cash activity record
// - Delete flow: remove cash activity record
//
// idProperty references the Property entity (idEntity from Property-Position)

import dalCashActivity from '../dal/dalCashActity.js';
import dalEntity from '../dal/dalEntity.js';
import dalDB from '../dal/dalDB.js';

const ENTITY_TYPE_CASH_ACTIVITY = 6;

const bplCashActivity = {

  // ---------------------------------------------------------------------------
  // LOAD (by idEntity) -> returns ONE cash activity row
  // ---------------------------------------------------------------------------
  loadCashActivity: function (data, callback) {
    // expects: { idEntity }
    dalCashActivity.selectCashActivity(data, (err, result) => {
      if (!err && result && result[0] && result[0][0]) {
        callback(false, result[0][0]); // return ONE row
      }
      else callback(false, { error: err });
    });
  },

  // ---------------------------------------------------------------------------
  // LOAD all cash activities for a property -> returns ARRAY (newest first)
  // ---------------------------------------------------------------------------
  loadCashActivitiesForProperty: function (data, callback) {
    // expects: { idProperty }
    dalCashActivity.selectCashActivitiesByProperty(data, (err, result) => {
      if (!err && result && result[0]) {
        callback(false, result[0]); // return array of rows
      }
      else callback(false, { error: err });
    });
  },

  // ---------------------------------------------------------------------------
  // LOAD cash activities by date range for a property
  // ---------------------------------------------------------------------------
  loadCashActivitiesForPropertyByDateRange: function (data, callback) {
    // expects: { idProperty, startDate, endDate }
    dalCashActivity.selectCashActivitiesByDateRange(data, (err, result) => {
      if (!err && result && result[0]) {
        callback(false, result[0]); // return array of rows
      }
      else callback(false, { error: err });
    });
  },

  // ---------------------------------------------------------------------------
  // INSERT
  // 1) create Entity first (generates idEntity on server)
  // 2) insert cash activity record with generated idEntity
  // 3) commit
  // returns created cash activity row (as DAL returns it)
  // ---------------------------------------------------------------------------
  insertCashActivity: function (data, callback) {
    // expects minimally:
    // {
    //   idProperty,
    //   propertyName,
    //   activityDate,
    //   activityType,  -- e.g., Contribution/Distribution/Expense/Income
    //   amount,
    //   // optional: notes
    // }
    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        const entityData = {
          entityTitle: data.propertyName || 'Cash Activity',
          entityType: ENTITY_TYPE_CASH_ACTIVITY,
          entityDesc: ''
        };

        dalEntity.insertEntity(entityData, (errEntity, resultEntity) => {
          if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0] && resultEntity[0][0].idEntity) {
            const idEntity = resultEntity[0][0].idEntity;
            let insData = { ...data, idEntity };
            // normalize date fields to avoid formatting issues
            insData = dalDB.normalizeDates(insData, ['activityDate','periodStart','periodEnd','startDate','endDate']);

            dalCashActivity.insertCashActivity(insData, (err, result) => {
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
  // 1) update cash activity record with new values
  // returns: { response: 'Success' } on success
  // ---------------------------------------------------------------------------
  updateCashActivity: function (data, callback) {
    // expects:
    // {
    //   idEntity,
    //   idProperty,
    //   activityDate,
    //   activityType,
    //   amount,
    //   // optional: notes
    // }
    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        const upd = dalDB.normalizeDates(data, ['activityDate','periodStart','periodEnd','startDate','endDate'])
        dalCashActivity.updateCashActivity(upd, (err) => {
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
  // 1) delete cash activity record
  // returns: { response: 'Success' } on success
  // ---------------------------------------------------------------------------
  deleteCashActivity: function (data, callback) {
    // expects: { idEntity }
    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        dalCashActivity.deleteCashActivity(data, (err) => {
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

export default bplCashActivity;
