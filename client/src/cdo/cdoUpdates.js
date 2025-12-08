// cdoUpdates.js

import util from '../shared/util.js'
import config from '../config.js'

var servicesURL = `${config.server.url}:${config.server.webServicesPort}/`
if (config.server.url === "https://data.capstream.io") {
  servicesURL = "https://data.capstream.io/"
    }
servicesURL += "updates/"

export const getEmptyRow = () => ({
  // Update
  idEntity: null,              // primary key (entity id)
  idProperty: null,            // foreign key to property-position
  propertyName: '',            // denormalized property name
  updateDate: null,            // 'YYYY-MM-DD' - when this update was created
  
  // Revisions (optional)
  revisedSaleDate: null,       // 'YYYY-MM-DD' or null
  revisedIrrPct: null,         // number (0-100) or null
  revisedEquityMultiple: null, // number or null
  distributionGuidance: 'Same as OM', // 'Same as OM' | 'Increase' | 'Decrease' | 'Suspend'
  notes: '',                   // optional notes about the update
})


const cdoUpdates = {
  /** Primary key accessor used by generic UI code */
  getId: () => 'idEntity',

  /** Empty row factory (exported above for convenience) */
  getEmptyRow,

  /**
   * List updates for a specific property (timeline).
   * @param {{ idProperty: string }} data
   * @param {(error: any, data: any[]) => void} callback
   */
  listByProperty: (data, callback) => {
    util.putJSON(servicesURL+'list', data, callback)
  },

  /**
   * Load a single update by id.
   * @param {{ idEntity: string }} data
   */
  load: (data, callback) => {
    util.putJSON(servicesURL+'load', data, callback)
  },

  /**
   * Create / Add a new update.
   * @param {ReturnType<typeof getEmptyRow>} row
   * @param {(error: any, payload: any) => void} callback
   */
  add: (data, callback) => {
    util.putJSON(servicesURL+'add', data, callback)
  },

  /**
   * Update an existing update record.
   * @param {Partial<ReturnType<typeof getEmptyRow>> & { idEntity: string }} row
   * @param {(error: any, payload: any) => void} callback
   */
  update: (data, callback) => {
    util.putJSON(servicesURL+'update', data, callback)
  },

  /**
   * Delete an update by id.
   * @param {{ idEntity: string }} data
   * @param {(error: any, payload: any) => void} callback
   */
  delete: (data, callback) => {
    util.putJSON(servicesURL+'delete', data, callback)
  },

}

export default cdoUpdates
