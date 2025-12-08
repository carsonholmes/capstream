// cdoCashActivity.js

import util from '../shared/util.js'
import config from '../config.js'

var servicesURL = `${config.server.url}:${config.server.webServicesPort}/`
if (config.server.url === "https://data.capstream.io") {
  servicesURL = "https://data.capstream.io/"
    }
servicesURL += "cash-activity/"

export const getEmptyRow = () => ({
  // Cash Activity
  idEntity: null,              // primary key (entity id)
  idProperty: null,            // foreign key to property-position
  propertyName: '',            // denormalized property name
  activityDate: null,          // 'YYYY-MM-DD' - when the cash activity occurred
  
  // Activity details
  activityType: '',            // 'Contribution' | 'Distribution' | 'Expense' | 'Income'
  amount: null,                // number (decimal)
  notes: '',                   // optional notes about the activity
})


const cdoCashActivity = {
  /** Primary key accessor used by generic UI code */
  getId: () => 'idEntity',

  /** Empty row factory (exported above for convenience) */
  getEmptyRow,

  /**
   * List cash activities for a specific property.
   * @param {{ idProperty: string }} data
   * @param {(error: any, data: any[]) => void} callback
   */
  listByProperty: (data, callback) => {
    util.putJSON(servicesURL+'list', data, callback)
  },

  /**
   * Load a single cash activity by id.
   * @param {{ idEntity: string }} data
   */
  load: (data, callback) => {
    util.putJSON(servicesURL+'load', data, callback)
  },

  /**
   * Create / Add a new cash activity.
   * @param {ReturnType<typeof getEmptyRow>} row
   * @param {(error: any, payload: any) => void} callback
   */
  add: (data, callback) => {
    util.putJSON(servicesURL+'add', data, callback)
  },

  /**
   * Update an existing cash activity record.
   * @param {Partial<ReturnType<typeof getEmptyRow>> & { idEntity: string }} row
   * @param {(error: any, payload: any) => void} callback
   */
  update: (data, callback) => {
    util.putJSON(servicesURL+'update', data, callback)
  },

  /**
   * Delete a cash activity by id.
   * @param {{ idEntity: string }} data
   * @param {(error: any, payload: any) => void} callback
   */
  delete: (data, callback) => {
    util.putJSON(servicesURL+'delete', data, callback)
  },

  /**
   * Get cash activities for a property within a date range.
   * @param {{ idProperty: string, startDate: string, endDate: string }} data
   * @param {(error: any, data: any[]) => void} callback
   */
  listByPropertyAndDateRange: (data, callback) => {
    util.putJSON(servicesURL+'by-date-range', data, callback)
  },

}

export default cdoCashActivity
