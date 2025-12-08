import db from '../shared/db.js';

const toIsoDate = (v) => {
  if (v === null || v === undefined) return ''
  if (typeof v === 'string') {
    const s = v.trim()
    if (/^\d{4}-\d{2}-\d{2}$/.test(s)) return s
    const d = new Date(s)
    if (!isNaN(d)) {
      const yyyy = d.getFullYear()
      const mm = String(d.getMonth()+1).padStart(2,'0')
      const dd = String(d.getDate()).padStart(2,'0')
      return `${yyyy}-${mm}-${dd}`
    }
    return s
  }
  if (v instanceof Date) {
    if (isNaN(v)) return ''
    const yyyy = v.getFullYear()
    const mm = String(v.getMonth()+1).padStart(2,'0')
    const dd = String(v.getDate()).padStart(2,'0')
    return `${yyyy}-${mm}-${dd}`
  }
  try { return String(v) } catch (e) { return '' }
}

export default {
    beginTransaction: function (callback) {
        db.dbo.beginTransaction( (err) => {
            callback(err)
        })
    },

    commitTransaction: function (callback) {
        db.dbo.commit( (err) => {
            callback(err)
        })  
    },

    rollbackTransaction: function (callback) {
        db.dbo.rollback( (err) => {
            callback(err)
        })  
    },

    /**
     * Normalize date fields on an object into 'YYYY-MM-DD' strings.
     * @param {Object} data
     * @param {Array<string>} fields - array of field names to normalize
     * @returns {Object} shallow copy with normalized date fields
     */
    normalizeDates: function(data, fields) {
      const out = { ...data }
      if (!fields || !Array.isArray(fields)) return out
      fields.forEach(f => { out[f] = toIsoDate(out[f]) })
      return out
    }

}