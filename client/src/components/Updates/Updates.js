// Updates.jsx
import React, { useEffect, useMemo, useState } from 'react'
import { AppContext } from '../../AppContext'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import TextBox from '../controls/TextBox/TextBox'
import Button from '../controls/buttons/Button'
import Select from '../controls/Select/Select'
import TextArea from '../controls/TextArea/TextArea'
import DatePicker from '../controls/DatePicker/DatePicker'
import './Updates.css'

// ---- Minimal CDO stub (replace with real implementation later) -----------------
class UpdatesCDO {
  constructor() {
    this._properties = [
      { id: '1', name: 'Example Apartments' },
      { id: '2', name: 'Ridge Office' }
    ]
    // seed a couple of previous updates for Example Apartments
    this._updatesByProperty = {
      '1': [
        { id: 'u-2025-06-30', propertyId: '1', propertyName: 'Example Apartments', updateDate: '2025-06-30', revisedSaleDate: '2027-09-01', revisedIrrPct: 14.5, revisedEquityMultiple: 1.85, distributionGuidance: 'Decrease', notes: 'Roof replacement', attachment: null },
        { id: 'u-2025-03-31', propertyId: '1', propertyName: 'Example Apartments', updateDate: '2025-03-31', revisedSaleDate: '2027-06-01', revisedIrrPct: 15.0, revisedEquityMultiple: 1.9, distributionGuidance: 'Same as OM', notes: 'Baseline', attachment: null }
      ],
      '2': []
    }
  }

  get getEmptyRow() {
    return {
      id: null,
      propertyId: '',
      propertyName: '',
      updateDate: '',
      // revisions (optional)
      revisedSaleDate: '',
      revisedIrrPct: '',
      revisedEquityMultiple: '',
      distributionGuidance: 'Same as OM',
      notes: '',
      attachment: null
    }
  }

  async listProperties(search = '') {
    return this._properties.filter(p => !search || p.name.toLowerCase().includes(search.toLowerCase()))
  }

  async listUpdates(propertyId) {
    const list = this._updatesByProperty[propertyId] || []
    // sort desc by date
    return [...list].sort((a, b) => String(b.updateDate).localeCompare(String(a.updateDate)))
  }

  async getUpdateById(id) {
    for (const pid of Object.keys(this._updatesByProperty)) {
      const found = (this._updatesByProperty[pid] || []).find(u => u.id === id)
      if (found) return found
    }
    return null
  }

  async saveUpdate(row) {
    const id = row.id ?? `u-${Date.now()}`
    const propertyId = row.propertyId
    if (!this._updatesByProperty[propertyId]) this._updatesByProperty[propertyId] = []
    const existingIdx = this._updatesByProperty[propertyId].findIndex(u => u.id === id)
    const saved = { ...row, id }
    if (existingIdx >= 0) this._updatesByProperty[propertyId][existingIdx] = saved
    else this._updatesByProperty[propertyId].push(saved)
    return saved
  }

  async uploadAttachment(file) {
    return { name: file?.name ?? 'unnamed', size: file?.size ?? 0, id: String(Math.random()) }
  }
}
const cdo = new UpdatesCDO()
// -------------------------------------------------------------------------------

const Updates = () => {
  const { appContext } = React.useContext(AppContext)

  // ---- selection / search ------------------------------------------------------
  const [properties, setProperties] = useState([])
  const [selectedPropertyId, setSelectedPropertyId] = useState('')
  const [timeline, setTimeline] = useState([])

  // ---- form state --------------------------------------------------------------
  const [row, setRow] = useState(cdo.getEmptyRow)
  const [isSaving, setIsSaving] = useState(false)

  const canSubmit = useMemo(() => {
    const required = [row.propertyId, row.updateDate]
    const hasRequired = required.every(v => v !== undefined && v !== null && String(v).toString().length > 0)
    return !isSaving && hasRequired
  }, [row, isSaving])

  // initial load
  useEffect(() => {
    let isMounted = true
    cdo.listProperties('')
      .then(list => { if (isMounted) setProperties(list) })
    return () => { isMounted = false }
  }, [])

  // load timeline on property change
  useEffect(() => {
    let isMounted = true
    if (!selectedPropertyId) { setTimeline([]); return }
    cdo.listUpdates(selectedPropertyId).then(list => { if (isMounted) setTimeline(list) })
    return () => { isMounted = false }
  }, [selectedPropertyId])

  const update = (dataCol, newValue) => setRow(prev => ({ ...prev, [dataCol]: newValue }))

  const onPickProperty = (col, value) => {
    const id = String(value || '')
    const prop = properties.find(p => String(p.id) === id)
    setSelectedPropertyId(id)
    setRow(prev => ({
      ...prev,
      propertyId: id,
      propertyName: prop?.name ?? ''
    }))
  }

  const clearForm = () => setRow({ ...cdo.getEmptyRow, propertyId: selectedPropertyId, propertyName: properties.find(p => p.id === selectedPropertyId)?.name || '' })

  const onSave = async () => {
    if (!canSubmit) return
    try {
      setIsSaving(true)
      const saved = await cdo.saveUpdate(row)
      setRow(saved)
      // refresh timeline
      const list = await cdo.listUpdates(saved.propertyId)
      setTimeline(list)
    } finally {
      setIsSaving(false)
    }
  }

  const onFilePick = async (evt) => {
    const file = evt?.target?.files?.[0]
    if (!file) return
    const meta = await cdo.uploadAttachment(file)
    setRow(prev => ({ ...prev, attachment: meta }))
    evt.target.value = ''
  }

  const onEditFromTimeline = async (u) => {
    setRow({ ...cdo.getEmptyRow, ...u })
    setSelectedPropertyId(u.propertyId)
  }

  const bg = appContext?.activeBackground || '#f5f5f5'

  return (
    <ContentContainer>
      <div className='updates-select' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <Select
          id='propertySelect'
          dataCol='propertyId'
          label='Select a Property'
          type='text'
          value={selectedPropertyId || ''}
          data={[{ value: '', caption: 'Select a property' }, ...properties.map(p => ({ value: String(p.id), caption: p.name }))]}
          onChange={onPickProperty}
        />
        <Button styleName='primary sign-in home' onClick={clearForm}>New Update</Button>
      </div>

      <div className='updates-wrapper' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <h2 className='segment-header'>{row.idEntity ? 'Edit Update' : 'Create Update'}</h2>
        <DatePicker id='updateDate' dataCol='updateDate' placeholder='Update date' value={row.updateDate || null} onChange={update} />
        <DatePicker id='revisedSaleDate' dataCol='revisedSaleDate' placeholder='Revised sale date' value={row.revisedSaleDate || null} onChange={update} />
        <TextBox id='revisedIrrPct' dataCol='revisedIrrPct' value={row.revisedIrrPct} placeholder='Revised IRR (est, %)' onChange={update} onSubmit={onSave} type='number' />
        <TextBox id='revisedEquityMultiple' dataCol='revisedEquityMultiple' value={row.revisedEquityMultiple} placeholder='Revised Equity Multiple (est)' onChange={update} onSubmit={onSave} type='number' />
        <Select id='distributionGuidance' dataCol='distributionGuidance' type='text' value={row.distributionGuidance || 'Same as OM'} label='Distribution guidance' onChange={update}
          data={[
            { value: 'Same as OM', caption: 'Same as OM' },
            { value: 'Increase', caption: 'Increase' },
            { value: 'Decrease', caption: 'Decrease' },
            { value: 'Suspend', caption: 'Suspend' }
          ]}
        />
        <TextArea id='notes' dataCol='notes' value={row.notes} placeholder='Notes (capex/occupancy, etc.)' onChange={update} />
      </div>

      <div className='updates-attachments' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <div className='updates-drop'>Drop pdf/image/email</div>
        <input type='file' onChange={onFilePick} />
        {row.attachment && (
          <div className='updates-fileline'>Attached: {row.attachment.name} <span className='updates-file-meta'>({row.attachment.size} bytes)</span></div>
        )}
      </div>

      <div className='upd-actions'>
        <Button styleName='primary submit' disabled={!canSubmit} onClick={onSave}>
          {isSaving ? 'Saving…' : 'Save Update'}
        </Button>
      </div>

        {/* Timeline */}
        <div className='updates-timeline' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
          <h2 className='segment-header'>Previous updates (timeline)</h2>
          {selectedPropertyId ? (
            <div className='upd-table-wrap'>
              <table className='upd-table'>
                <thead>
                  <tr>
                    <th>Date</th>
                    <th>Revised Sale</th>
                    <th>IRR est</th>
                    <th>Multiple est</th>
                    <th>Guidance</th>
                    <th>Notes</th>
                  </tr>
                </thead>
                <tbody>
                  {timeline.length === 0 && (
                    <tr><td colSpan={6} className='upd-empty'>No updates yet.</td></tr>
                  )}
                  {timeline.map(u => (
                    <tr key={u.id} onClick={() => onEditFromTimeline(u)} className='upd-row-click'>
                      <td>{u.updateDate || ''}</td>
                      <td>{u.revisedSaleDate || ''}</td>
                      <td>{u.revisedIrrPct !== undefined && u.revisedIrrPct !== '' ? `${u.revisedIrrPct}%` : ''}</td>
                      <td>{u.revisedEquityMultiple}</td>
                      <td>{u.distributionGuidance}</td>
                      <td className='upd-notes'>{u.notes}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
              <div className='upd-hint'>Click a row to load it into the form for editing.</div>
            </div>
          ) : (
            <div className='upd-empty'>Select a property to view its update history.</div>
          )}
        </div>
    </ContentContainer>
  )
}

export default Updates


