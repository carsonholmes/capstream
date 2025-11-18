// bplGroup.js
// Business Process Layer for Group (an Entity-backed object)
//
// Flow summary:
// - Insert: create Entity -> reuse idEntity -> create Group (transactional)
// - Load: merge Group row with Entity fields (title/desc/type)
// - Update: update Group first, then keep Entity title/desc in sync
// - Delete: delete Group then Entity (transactional)
// - List: loadGroupList(entityType) => [{ idEntity, groupTitle }]
//
// Notes:
// - Expect dalEntity.insertEntity to return UUID strings (per your SP).
// - dalGroup.* accepts/returns UUID strings (SP converts with UUID_TO_BIN/BIN_TO_UUID).
// - We let callers pass the correct master-type via data.entityType for Group.

import dalGroup from '../dal/dalGroup.js';                 // CommonJS default-import works in ESM
import dalEntity from '../dal/dalEntity.js';               // provides insert/select/update/delete + selectEntityByEntityType
import dalDB from '../dal/dalDB.js';

const ENTITY_TYPE_GROUP = 3

const bplGroup = {

  // ---------------------------------------------------------------------------
  // Load ONE group by idEntity (UUID string); merge with entity fields.
  // ---------------------------------------------------------------------------
  loadGroup: function (data, callback) {
    // expects: { idEntity }
    dalGroup.selectGroup(data, (errGroup, resultGroup) => {
      if (!errGroup && resultGroup && resultGroup[0] && resultGroup[0][0]) {
        dalEntity.selectEntity(data, (errEntity, resultEntity) => {
          if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0]) {
            const row = resultGroup[0][0];
            row.entityTitle = resultEntity[0][0].entityTitle;
            row.entityDesc  = resultEntity[0][0].entityDesc;
            row.entityType  = resultEntity[0][0].entityType;
            callback(false, row); // single merged row
          }
          else callback(false, { error: errEntity });
        });
      }
      else callback(false, { error: errGroup });
    });
  },

  // ---------------------------------------------------------------------------
  // Dropdown helper: list groups by entityType.
  // Returns [{ idEntity, groupTitle }] using entityTitle as display text.
  // ---------------------------------------------------------------------------
  loadGroupList: function (callback) {
    dalGroup.selectGroupsAll((err, result) => {
      if (!err && result && result[0]) {
        const list = result[0]
          .filter(r => r && r.idEntity && r.entityTitle !== undefined)
          .map(r => ({ idEntity: r.idEntity, entityTitle: r.entityTitle, backgroundColor: r.backgroundColor }));
        callback(false, list);
      } else {
        callback(false, { error: err });
      }
    });
  },

  // ---------------------------------------------------------------------------
  // Insert Group (transaction):
  // 1) Insert Entity (title/desc/type)
  // 2) Insert Group with returned idEntity
  // 3) Commit; return merged group row
  // ---------------------------------------------------------------------------
  insertGroup: function (data, callback) {
    // expects minimally:
    // {
    //   entityType,           // master-type id for "Group"
    //   entityTitle,          // group display name
    //   entityDesc,           // optional
    //   groupType             // required by dalGroup.insertGroup
    // }
    if (typeof data.entityType === 'undefined' || data.entityType === null) {
      return callback(false, { error: 'Missing entityType for insertGroup.' });
    }
    if (typeof data.groupType === 'undefined' || data.groupType === null) {
      return callback(false, { error: 'Missing groupType for insertGroup.' });
    }

    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        const entityData = {
          entityTitle: data.entityTitle,
          entityDesc:  data.entityDesc ?? '',
          entityType:  ENTITY_TYPE_GROUP
        };

        dalEntity.insertEntity(entityData, (errEntity, resultEntity) => {
          if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0] && resultEntity[0][0].idEntity) {
            const idEntity = resultEntity[0][0].idEntity; // UUID string
            const groupData = { ...data, idEntity };

            dalGroup.insertGroup(groupData, (errGroup, resultGroup) => {
              if (!errGroup && resultGroup) {
                // Re-load merged payload to return to UI
                this.loadGroup({ idEntity }, (errLoad, merged) => {
                  if (!errLoad && merged) {
                    dalDB.commitTransaction((errCommit) => {
                      if (!errCommit) callback(false, merged);
                      else dalDB.rollbackTransaction(() => { callback(false, { error: errCommit }); });
                    });
                  } else {
                    dalDB.rollbackTransaction(() => { callback(false, { error: errLoad }); });
                  }
                });
              }
              else dalDB.rollbackTransaction(() => { callback(false, { error: errGroup }); });
            });
          }
          else dalDB.rollbackTransaction(() => { callback(false, { error: errEntity }); });
        });

      } else callback(false, { error: errBegin });
    });
  },

  // ---------------------------------------------------------------------------
  // Update Group:
  // - Update group (groupType)
  // - Keep Entity title/desc in sync (optional change from UI)
  // ---------------------------------------------------------------------------
  updateGroup: function (data, callback) {
    // expects:
    // {
    //   idEntity,
    //   groupType,
    //   entityTitle,          // optional: sync to Entity
    //   entityDesc            // optional: sync to Entity
    // }
    dalGroup.updateGroup(data, (errGroup) => {
      if (!errGroup) {
        // If UI passed title/desc, sync them; otherwise, just return success.
        if (typeof data.entityTitle === 'undefined' && typeof data.entityDesc === 'undefined') {
          return callback(false, { response: 'Success' });
        }
        const patch = {
          idEntity:    data.idEntity,
          entityTitle: data.entityTitle ?? '',
          entityDesc:  data.entityDesc ?? ''
        };
        dalEntity.updateEntity(patch, (errEntity) => {
          if (!errEntity) callback(false, { response: 'Success' });
          else callback(false, { error: errEntity });
        });
      }
      else callback(false, { error: errGroup });
    });
  },

  // ---------------------------------------------------------------------------
  // Delete Group (transaction):
  // - Delete group row
  // - Delete backing entity
  // ---------------------------------------------------------------------------
  deleteGroup: function (data, callback) {
    // expects: { idEntity }
    dalDB.beginTransaction((errBegin) => {
      if (!errBegin) {
        dalGroup.deleteGroup(data, (errGroup) => {
          if (!errGroup) {
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
          else dalDB.rollbackTransaction(() => { callback(false, { error: errGroup }); });
        });
      }
      else dalDB.rollbackTransaction(() => { callback(false, { error: errBegin }); });
    });
  }

};

export default bplGroup;
