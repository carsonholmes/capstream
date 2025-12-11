// CashActivity.jsx
import React, { useEffect, useMemo, useState } from 'react'
import { AppContext } from '../../AppContext'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import TextBox from '../controls/TextBox/TextBox'
import Button from '../controls/buttons/Button'
import Select from '../controls/Select/Select'
import TextArea from '../controls/TextArea/TextArea'
import DatePicker from '../controls/DatePicker/DatePicker'
import './CashActivity.css'

// Real CDOs
import cdoCashActivity, { getEmptyRow as getEmptyCashRow } from '../../cdo/cdoCashActivity'
import cdoPositions from '../../cdo/cdoPositions'
import cdoAttachments from '../../cdo/cdoAttachments'

const CashActivity = () => {
  const { appContext } = React.useContext(AppContext)

  // ---- selection ---------------------------------------------------------------
  const [properties, setProperties] = useState([])
  const [selectedPropertyId, setSelectedPropertyId] = useState('')

  // ---- table data / filters ----------------------------------------------------
  const [activities, setActivities] = useState([])
  const [filterYear, setFilterYear] = useState('All')
  const [filterType, setFilterType] = useState('All')

  // ---- form state --------------------------------------------------------------
  const mapServerToUI = (r = {}) => ({
    id: r.idEntity || r.id || null,
    propertyId: r.idProperty || r.propertyId || '',
    propertyName: r.propertyName || '',
    activityDate: r.activityDate || null,
    type: r.activityType || r.type || 'Distribution',
    amount: r.amount ?? '',
    method: r.method || '',
    memo: r.notes || r.memo || '',
    periodStart: r.periodStart || '',
    periodEnd: r.periodEnd || '',
    attachment: r.attachment || null
  })

  const mapUIToServer = (u = {}) => {
    const payload = {
      idProperty: u.propertyId || undefined,
      propertyName: u.propertyName || undefined,
      activityDate: u.activityDate || undefined,
      activityType: u.type || undefined,
      amount: u.amount ?? undefined,
      notes: u.memo || undefined,
      method: u.method || undefined,
      periodStart: u.periodStart || undefined,
      periodEnd: u.periodEnd || undefined
    }
    // Only include idEntity if updating an existing record
    if (u.id) payload.idEntity = u.id
    return payload
  }

  const emptyUIRow = () => mapServerToUI(getEmptyCashRow())

  const [row, setRow] = useState(emptyUIRow())
  const [isSaving, setIsSaving] = useState(false)

  // validations
  const canSubmit = useMemo(() => {
    const required = [row.propertyId, row.activityDate, row.type, row.amount]
    const hasRequired = required.every(v => v !== undefined && v !== null && String(v).toString().length > 0)
    return !isSaving && hasRequired
  }, [row, isSaving])

  // initial load
  useEffect(() => {
    let isMounted = true
    cdoPositions.listByClient({ activeClient: appContext.activeClient }, (err, list) => {
      if (!err && isMounted) {
        const props = Array.isArray(list) ? list.map(p => ({ id: p.idEntity || p.id, name: p.propertyName || p.propertyName })) : []
        setProperties(props)
      }
    })
    return () => { isMounted = false }
  }, [])

  // load property ledger
  useEffect(() => {
    let isMounted = true
    if (!selectedPropertyId) { setActivities([]); return }
    cdoCashActivity.listByProperty({ idProperty: selectedPropertyId }, (err, list) => {
      if (!err && isMounted) {
        const mapped = (Array.isArray(list) ? list : []).map(r => mapServerToUI(r))
        setActivities(mapped)
      }
    })
    return () => { isMounted = false }
  }, [selectedPropertyId])

  // helpers
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

  const clearForm = () => {
    if (!selectedPropertyId) {
      alert('Please select a property before adding a new cash activity.')
      return
    }
    setRow(prev => ({ ...emptyUIRow(), propertyId: selectedPropertyId, propertyName: properties.find(p => p.id === selectedPropertyId)?.name || '' }))
  }

  const onSave = () => {
    if (!canSubmit) return
    setIsSaving(true)
    const send = mapUIToServer({ ...row, propertyName: row.propertyName || properties.find(p => p.id === selectedPropertyId)?.name || '' })
    // ensure idProperty is present
    if (!send.idProperty) send.idProperty = selectedPropertyId
    const done = (err, payload) => {
      setIsSaving(false)
      if (err || payload?.error) {
        alert('Save failed')
        console.error('save error', err, payload)
        return
      }
      const savedId = payload?.idEntity || payload?.id || row.id
      const savedRow = mapServerToUI({ ...payload, idEntity: savedId })
      setRow(savedRow)
      // refresh list
      cdoCashActivity.listByProperty({ idProperty: send.idProperty }, (lerr, list) => {
        if (!lerr) setActivities((Array.isArray(list) ? list : []).map(r => mapServerToUI(r)))
      })
      // Show success message
      alert(row.id ? 'Cash Activity updated successfully!' : 'Cash Activity created successfully!')
    }

    if (!row.id) cdoCashActivity.add(send, done)
    else cdoCashActivity.update(send, done)
  }

  const onFilePick = (evt) => {
    const file = evt?.target?.files?.[0]
    if (!file) return
    if (!row.id) { alert('Save the record before adding files.'); return }
    cdoAttachments.uploadAttachment({ idEntity: row.id, file }, (aerr, meta) => {
      if (aerr || meta?.error) {
        alert('Upload failed')
        console.error('upload error', aerr, meta)
      } else {
        setRow(prev => ({ ...prev, attachment: meta }))
      }
      if (evt?.target) evt.target.value = ''
    })
  }

  const onEditRow = (t) => {
    setRow(prev => ({ ...emptyUIRow(), ...mapServerToUI(t) }))
    setSelectedPropertyId(t.propertyId || t.idProperty)
  }

  const yearsForSelect = useMemo(() => {
    const allDates = activities.map(a => (a.activityDate || '').slice(0, 4)).filter(Boolean)
    const unique = Array.from(new Set(allDates)).sort((a, b) => b.localeCompare(a))
    return ['All', ...unique]
  }, [activities])

  const filtered = useMemo(() => {
    return activities.filter(a => {
      const byYear = filterYear === 'All' || (a.activityDate || '').startsWith(String(filterYear))
      const byType = filterType === 'All' || a.type === filterType
      return byYear && byType
    })
  }, [activities, filterYear, filterType])

  const totals = useMemo(() => {
    const sum = (list) => list.reduce((acc, t) => acc + (Number(t.amount) || 0), 0)
    const ytdList = activities.filter(a => (a.activityDate || '').startsWith(new Date().getFullYear().toString()))
    return {
      all: sum(activities),
      ytd: sum(ytdList),
      filtered: sum(filtered)
    }
  }, [activities, filtered])

  const fmt = (n) => (n === '' || n === null || n === undefined) ? '' : n.toLocaleString(undefined, { style: 'currency', currency: 'USD', maximumFractionDigits: 2 })
  const bg = appContext?.activeBackground || '#f5f5f5'

  // format ISO/Date-ish strings to local date (short)
  const fmtDate = (d) => {
    if (!d) return ''
    try {
      const dt = (d instanceof Date) ? d : new Date(d)
      if (isNaN(dt)) return String(d)
      return dt.toLocaleDateString()
    } catch (e) {
      return String(d)
    }
  }

  return (
    <ContentContainer>
      <div className='flex-wrapper-row' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <Select
          id='propertySelect'
          dataCol='propertyId'
          label='Property'
          type='text'
          value={selectedPropertyId || ''}
          data={[{ value: '', caption: 'Select a property' }, ...properties.map(p => ({ value: String(p.id), caption: p.name }))]}
          onChange={onPickProperty}
        />
        <Select
          id='filterYear'
          dataCol='filterYear'
          type='text'
          label='Year'
          value={filterYear}
          data={yearsForSelect.map(y => ({ value: y, caption: String(y) }))}
          onChange={(col, v) => setFilterYear(v)}
        />
        <Select
          id='filterType'
          dataCol='filterType'
          type='text'
          label='Type'
          value={filterType}
          data={['All', 'Distribution', 'Capital Call', 'Contribution', 'Expense'].map(t => ({ value: t, caption: t }))}
          onChange={(col, v) => setFilterType(v)}
        />
      </div>
      <div className='grid-wrapper' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <h2>{row.id ? 'Edit Cash Activity' : 'Add Cash Activity'}</h2>
        <DatePicker id='activityDate' dataCol='activityDate' placeholder='Activity date' value={row.activityDate || null} onChange={update} disabled={!selectedPropertyId} />
        <Select id='type' dataCol='type' type='text' value={row.type || 'Distribution'} label='Type' onChange={update} disabled={!selectedPropertyId}
          data={[
            { value: 'Distribution', caption: 'Distribution (to you)' },
            { value: 'Capital Call', caption: 'Capital Call (you pay)' },
            { value: 'Contribution', caption: 'Additional Contribution' },
            { value: 'Expense', caption: 'Expense/Fees' }
          ]}
        />
        <TextBox id='amount' dataCol='amount' value={row.amount} placeholder='Amount (use negative for outflow)' onChange={update} onSubmit={onSave} type='number' disabled={!selectedPropertyId} />
        <TextBox id='method' dataCol='method' value={row.method} placeholder='Method (ACH, check, wire)' onChange={update} onSubmit={onSave} disabled={!selectedPropertyId} />
        <DatePicker id='periodStart' dataCol='periodStart' placeholder='Period start (optional)' value={row.periodStart || null} onChange={update} disabled={!selectedPropertyId} />
        <DatePicker id='periodEnd' dataCol='periodEnd' placeholder='Period end (optional)' value={row.periodEnd || null} onChange={update} disabled={!selectedPropertyId} />
        <TextArea id='memo' dataCol='memo' value={row.memo} placeholder='Memo / Notes' onChange={update} disabled={!selectedPropertyId} />
      </div>
      <div className='ca-attachments' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <div className='ca-drop'>Drop statement/wire receipt (optional)</div>
        <input type='file' onChange={onFilePick} disabled={!selectedPropertyId || !row.id} />
        {row.attachment && (
          <div className='ca-fileline'>Attached: {row.attachment.name} <span className='ca-file-meta'>({row.attachment.size} bytes)</span></div>
        )}
      </div>
      <Button styleName='primary submit' disabled={!canSubmit} onClick={onSave}>{isSaving ? 'Saving…' : 'Save Activity'}</Button>
      <div className='flex-wrapper-column' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`, marginTop: '2rem'}}>
        <div style={{ display: 'flex', alignItems: 'center', flexWrap: 'wrap', justifyContent: 'space-evenly', padding: '0 1rem', width: '100%' }}>
          <h2>Cash ledger</h2>
          <Button styleName='primary' onClick={() => clearForm()} disabled={!selectedPropertyId}>Add New</Button>
        </div>
        {selectedPropertyId ? (
          <div className='ca-table-wrap'>
            <table className='ca-table'>
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Type</th>
                  <th>Amount</th>
                  <th>Method</th>
                  <th>Period</th>
                  <th>Memo</th>
                </tr>
              </thead>
              <tbody>
                {filtered.length === 0 && (
                  <tr><td colSpan={6} className='ca-empty'>No activity for the selected filters.</td></tr>
                )}
                {filtered.map(t => (
                  <tr key={t.id} onClick={() => onEditRow(t)} className='ca-row-click'>
                    <td>{fmtDate(t.activityDate)}</td>
                    <td>{t.type}</td>
                    <td>{fmt(Number(t.amount) || 0)}</td>
                    <td>{t.method || ''}</td>
                    <td>{(t.periodStart || t.periodEnd) ? `${fmtDate(t.periodStart)} – ${fmtDate(t.periodEnd)}` : ''}</td>
                    <td className='ca-memo'>{t.memo}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            <div className='ca-hint'>Click a row to edit.</div>
          </div>
        ) : (
          <div className='ca-empty'>Select a property to view and add cash activity.</div>
        )}
      </div>
    </ContentContainer>
  )
}

export default CashActivity


