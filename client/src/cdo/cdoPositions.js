// cdoPositions.js

import util from '../shared/util.js'
import config from '../config.js'

var servicesURL = `${config.server.url}:${config.server.webServicesPort}/`
if (config.server.url === "https://data.capstream.io") {
  servicesURL = "https://data.capstream.io/"
    }
servicesURL += "positions/"

export const getEmptyRow = () => ({
  // Property
  idPosition: null,            // primary key on the server for this merged view
  propertyName: '',
  sponsorGP: '',
  partnershipLP: '',
  acquisitionDate: null,       // 'YYYY-MM-DD' or null
  propertyNotes: '',

  // Position (your investment)
  lpEntity: '',
  investedEquity: null,        // number
  investmentDate: null,        // 'YYYY-MM-DD' or null
  ownershipPct: null,          // number (0-100)
  prefReturnPct: null,         // number (0-100)
  distributionCadence: 'Quarterly', // 'Monthly' | 'Quarterly' | 'Semiannual' | 'Annually'

  // Targets
  targetIRR: null,             // number
  targetEquityMultiple: null,  // number
  projectedSaleDate: null,     // 'YYYY-MM-DD' or null

  // Misc
  attachments: [],             // [{ idAttachment, fileName, sizeBytes }]
  dtCreated: null,
  dtLastEdited: null,
})


const cdoPositions = {
  /** Primary key accessor used by generic UI code */
  getId: () => 'idPosition',

  /** Empty row factory (exported above for convenience) */
  getEmptyRow,

  /**
   * List records with optional full‑text search.
   * @param {(error: any, data: any[]) => void} callback
   */
  listByClient: (data, callback) => {
    util.putJSON(servicesURL+'list', data, callback)
  },

  /**
   * Load a single record by id.
   * @param {{ idEntity: string }} data
   */
  load: (data, callback) => {
    util.putJSON(servicesURL+'load',data,callback)
  },

  /**
   * Create / Add a new record.
   * @param {ReturnType<typeof getEmptyRow>} row
   * @param {(error: any, payload: any) => void} callback
   */
  add: (data, callback) => {
     util.putJSON(servicesURL+'add',data,callback)
  },

  /**
   * Update an existing record.
   * @param {Partial<ReturnType<typeof getEmptyRow>> & { idPosition: string }} row
   * @param {(error: any, payload: any) => void} callback
   */
  update: (data, callback) => {
    util.putJSON(servicesURL+'update',data,callback)
  },

  /**
   * Delete a record by id.
   * @param {{ idPosition: string }} data
   * @param {(error: any, payload: any) => void} callback
   */
  delete: (data, callback) => {
    util.putJSON(servicesURL+'delete', data, callback)
  },

}

export default cdoPositions
