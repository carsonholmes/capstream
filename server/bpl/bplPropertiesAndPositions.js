// bplPropertiesAndPositions.js
// Business Process Layer for Property-Position entities
//
// Notes:
// - Insert flow: create Entity first -> reuse idEntity -> create Property-Position
// - Load flow: join/merge Property-Position row with Entity fields (title/desc/type)
// - Update flow: update Property-Position, then Entity
// - Delete flow: delete Property-Position, then Entity (transactional)
//
// Entity Type:
// - dalEntity currently exports ENTITY_USER, ENTITY_SpecificEntity, ENTITY_SESSION, ENTITY_APP.
// - If you add a master-type row for Property-Position, pass its numeric id via data.entityType.
// - Fallback: if data.entityType is not provided, we’ll set entityType = 0 (you can adjust as needed).

import dalPropertyPosition from '../dal/dalPropertyPosition.js';
import dalEntity from '../dal/dalEntity.js';
import dalDB from '../dal/dalDB.js';
import dalEntityRelate from '../DAL/dalEntityRelate.js';

const ENTITY_TYPE_PAP = 4
const RELATE_OWNED = 2

const bplPropertiesAndPositions = {


  // ---------------------------------------------------------------------------
  // LOAD (by idEntity) -> returns ONE merged row (entity fields copied in)
  // ---------------------------------------------------------------------------
  loadPropertyPosition: function (data, callback) {
    // expects: { idEntity }
    dalPropertyPosition.selectPropertyPosition(data, (errProp, resultProp) => {
      if (!errProp && resultProp && resultProp[0] && resultProp[0][0]) {
        dalEntity.selectEntity(data, (errEntity, resultEntity) => {
          if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0]) {
            // merge entity fields into property-position payload
            resultProp[0][0].entityTitle = resultEntity[0][0].entityTitle;
            resultProp[0][0].entityDesc  = resultEntity[0][0].entityDesc;
            resultProp[0][0].entityType  = resultEntity[0][0].entityType;
            callback(false, resultProp[0][0]); // return ONE row
          }
          else callback(false, { error: errEntity });
        });
      }
      else callback(false, { error: errProp });
    });
  },

  // ---------------------------------------------------------------------------
  // OPTIONAL: search helpers (raw pass-throughs to DAL)
  // (Keep simple: return what DAL returns. Caller can choose to re-load by id if needed.)
  // ---------------------------------------------------------------------------
  loadPositionsForClient: function (data, callback) {
    // expects: { activeClient } (idEntity)
    dalPropertyPosition.loadPositionsForClient(data, (err, result) => {
      if (!err && result && result[0]) callback(false, result[0]); // return array of rows
      else callback(false, { error: err });
    });
  },

  loadPropertyPositionsByLpEntity: function (data, callback) {
    // expects: { lpEntity }
    dalPropertyPosition.selectPropertyPositionByLpEntity(data, (err, result) => {
      if (!err && result && result[0]) callback(false, result[0]); // return array of rows
      else callback(false, { error: err });
    });
  },

  // ---------------------------------------------------------------------------
  // INSERT (transaction)
  // 1) insert entity
  // 2) insert property-position (with idEntity from step 1)
  // 3) commit
  // returns created property-position row (as DAL returns it)
  // ---------------------------------------------------------------------------
  insertPropertyPosition: function (data, callback) {
    // expects minimally:
    // {
    //   propertyName, propertyNotes,  // for entityTitle/Desc
    //   // optional: entityType (recommended master-type id for Property-Position)
    //   // plus all property-position fields required by the DAL insert
    // }
    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        const entityData = {
          entityTitle: data.propertyName,           // canonical title
          entityType:  ENTITY_TYPE_PAP,      
          entityDesc:  ''   
        };

        dalEntity.insertEntity(entityData, (errEntity, resultEntity) => {
          if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0] && resultEntity[0][0].idEntity) {
            const idEntity = resultEntity[0][0].idEntity;

            // pass through all property-position fields and attach idEntity
            let propData = { ...data, idEntity };
            // normalize date fields to avoid formatting issues
            propData = dalDB.normalizeDates(propData, ['acquisitionDate','investmentDate','projectedSaleDate'])

            dalPropertyPosition.insertPropertyPosition(propData, (errProp, resultProp) => {
              if (!errProp && resultProp && resultProp[0] && resultProp[0][0]) {
                const relateData = { idEntity: data.activeClient, idRelated: idEntity, relateType: RELATE_OWNED }
                dalEntityRelate.insertEntityRelate(relateData, (errRelate, resultRelate) => {
                  if (!errRelate && resultRelate) {
                    dalDB.commitTransaction((errCommit) => {
                      if (!errCommit) callback(false, resultProp[0][0]);
                      else dalDB.rollbackTransaction(() => { callback(false, { error: errCommit }); });
                    });
                  }
                  else dalDB.rollbackTransaction(() => { callback(false, { error: errRelate }); });
                 });
              }  
              else {
                dalDB.rollbackTransaction(() => { callback(false, { error: errProp }); });
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
  // 1) update property-position
  // 2) update entity (title/desc) to keep search/title in sync
  // returns: { response: 'Success' } on success
  // ---------------------------------------------------------------------------
  updatePropertyPosition: function (data, callback) {
    // expects:
    // {
    //   idEntity,
    //   propertyName, propertyNotes, // used to refresh Entity title/desc
    //   ... other property-position fields required by DAL update
    // }
    // normalize date fields before updating
    const upd = dalDB.normalizeDates(data, ['acquisitionDate','investmentDate','projectedSaleDate'])
    dalPropertyPosition.updatePropertyPosition(upd, (errProp) => {
      if (!errProp) {
        const entityPatch = {
          idEntity:     data.idEntity,
          entityTitle:  data.propertyName,
          entityDesc:   (data.propertyNotes ?? '')
        };
        dalEntity.updateEntity(entityPatch, (errEntity) => {
          if (!errEntity) callback(false, { response: 'Success' });
          else callback(false, { error: errEntity });
        });
      }
      else callback(false, { error: errProp });
    });
  },

  // ---------------------------------------------------------------------------
  // DELETE (transaction)
  // 1) delete property-position
  // 2) delete entity
  // returns: { response: 'Success' } on success
  // ---------------------------------------------------------------------------
  deletePropertyPosition: function (data, callback) {
    // expects: { idEntity }
    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        dalPropertyPosition.deletePropertyPosition(data, (errProp) => {
          if (!errProp) {
            dalEntity.deleteEntity(data, (errEntity) => {
              if (!errEntity) {
                dalDB.commitTransaction((errCommit) => {
                  if (!errCommit) callback(false, { response: 'Success' });
                  else dalDB.rollbackTransaction(() => { callback(false, { error: errCommit }); });
                });
              }
              else dalDB.rollbackTransaction(() => { callback(false, { error: errEntity }); });
            });
          }
          else dalDB.rollbackTransaction(() => { callback(false, { error: errProp }); });
        });
      }
      else dalDB.rollbackTransaction(() => { callback(false, { error: errBegin }); });
    });
  }

};

export default bplPropertiesAndPositions;
