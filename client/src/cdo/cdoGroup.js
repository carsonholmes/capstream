// cdoGroup.js
import util from '../shared/util.js';
import config from '../config.js';

var servicesURL = `${config.server.url}:${config.server.webServicesPort}/`
if (config.server.url === "https://data.capstream.io") {
  servicesURL = "https://data.capstream.io/"
    }
servicesURL += "group/"

// Hard-coded semantics for Group
const ENTITY_TYPE_GROUP = 3; //entity type 3 = Group
export const CLIENT_GROUP_TYPE = 1; //Group Type 1 = Client Org
const GROUP_TYPE_DEFAULT = 1;

class cdoGroup {
  /**
   * Load a single merged group row (group + entity fields)
   * @param {{ idEntity: string }} data
   * @param {(status: number, payload: any) => void} callback
   */
  loadData = (data, callback) => {
    // expects: { idEntity }
    util.putJSON(servicesURL + 'load', data, callback);
  };

  /**
   * Get a list of groups by entityType (server expects { entityType })
   * @param {{ entityType?: number }} data  // optional; defaults to 3
   * @param {(status: number, payload: any) => void} callback
   */
  list = (callback) => {
    util.getJSON(servicesURL + 'list', callback);
  };

  /**
   * Insert a new group
   * @param {{
   *   entityTitle: string,
   *   entityDesc?: string,
   *   groupType?: number // ignored; will be forced to 1
   * }} data
   * @param {(status: number, payload: any) => void} callback
   */
  addGroup = (data, callback) => {
    util.putJSON(servicesURL + 'add', data, callback);
  };

  /**
   * Update an existing group
   * @param {{
   *   idEntity: string,
   *   entityTitle?: string,
   *   entityDesc?: string,
   *   groupType?: number // ignored; will be forced to 1
   * }} data
   * @param {(status: number, payload: any) => void} callback
   */
  updateGroup = (data, callback) => {
    const payload = {
      groupType: GROUP_TYPE_DEFAULT, // enforce 1 on update per requirement
      ...data,
      groupType: GROUP_TYPE_DEFAULT,
    };
    util.putJSON(servicesURL + 'update', payload, callback);
  };

  /**
   * Delete a group by idEntity
   * @param {{ idEntity: string }} data
   * @param {(status: number, payload: any) => void} callback
   */
  deleteGroup = (data, callback) => {
    util.putJSON(servicesURL + 'delete', data, callback);
  };

  /**
   * Create a client-side empty row matching merged (entity + group) shape.
   * Server sets dtCreated/dtLastEdited; leave null on client.
   */
  getEmptyRow = () => {
    return {
      // entity table fields
      idEntity: null,          // BINARY(16) on server; client can hold null or a UUID string until server assigns
      entityTitle: '',         // VARCHAR(255) NULL
      entityDesc: '',          // TEXT NULL
      entityType: ENTITY_TYPE_GROUP, // INT NOT NULL (hard-coded 3 for group)
      idMedia: null,           // BIGINT UNSIGNED NULL
      dtCreated: null,         // DATETIME NOT NULL (server will set)
      dtLastEdited: null,      // DATETIME NULL
      backgroundColor: '#E3F2FD',
      // group table fields
      groupType: 1, // INT NOT NULL (hard-coded 1)
    };
  };

  /**
   * Primary key accessor used by generic UI code
   */
  getId = () => 'idEntity';
}

const cdo = new cdoGroup();
export default cdo;
