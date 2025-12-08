// cdoAttachments.js
import util from '../shared/util.js'
import config from '../config.js'
import { AppContext } from '../AppContext.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/`
if (config.server.url === "https://data.capstream.io") {
  servicesURL = "https://data.capstream.io/"
    }
servicesURL += "attachments/"

const cdoAttachments = {
  
  /**
   * List attachments for a record.
   * @param {{ idEntity: string }} data
   */
  listAttachments: (data, callback) => {
    util.putJSON(servicesURL+'list', data, callback)
  },

  /**
   * Upload an attachment (expects a File or Blob). Your util should implement postForm.
   * @param {{ idEntity: string, file: File }} data
   */
  uploadAttachment: (data, callback) => {
    const { idEntity, file } = data || {}
    if (!idEntity || !file) return callback({ error: 'idEntity and file are required' })
    const form = new FormData()
    form.append('idEntity', idEntity)
    form.append('idUser', AppContext.idEntity)
    // form.append('fileName', file)
    form.append('file', file)
    // form.append('file', file)
    // form.append('file', file)
    util.putFile(servicesURL+'upload', form, {}, callback)
  },

  /**
   * Delete an attachment by id.
   * @param {{ idAttachment: string }} data
   */
  deleteAttachment: (data, callback) => {
    util.putJSON(servicesURL+'delete', data, callback)
  },
}

export default cdoAttachments
