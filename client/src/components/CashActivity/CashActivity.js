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

// ---- Minimal CDO stub (replace with real implementation later) -----------------
class CashActivityCDO {
  constructor() {
    this._properties = [
      { id: '1', name: 'Example Apartments' },
      { id: '2', name: 'Ridge Office' }
    ]
    // seeded transactions
    this._byProperty = {
      '1': [
        { id: 't-2025-07-15-1', propertyId: '1', propertyName: 'Example Apartments', activityDate: '2025-07-15', type: 'Distribution', amount: 3500, memo: 'Q2 distribution', method: 'ACH', periodStart: '2025-04-01', periodEnd: '2025-06-30' },
        { id: 't-2025-03-20-1', propertyId: '1', propertyName: 'Example Apartments', activityDate: '2025-03-20', type: 'Capital Call', amount: -10000, memo: 'Roof reserve', method: 'Wire', periodStart: '2025-01-01', periodEnd: '2025-03-31' }
      ],
      '2': [
        { id: 't-2025-08-10-1', propertyId: '2', propertyName: 'Ridge Office', activityDate: '2025-08-10', type: 'Distribution', amount: 2200, memo: 'Monthly distribution', method: 'ACH', periodStart: '2025-07-01', periodEnd: '2025-07-31' }
      ]
    }
  }

  get getEmptyRow() {
    return {
      id: null,
      propertyId: '',
      propertyName: '',
      activityDate: '',
      type: 'Distribution',
      amount: '', // positive for inflow to LP, negative for outflow (capital call)
      method: 'ACH',
      memo: '',
      periodStart: '',
      periodEnd: '',
      attachment: null
    }
  }

  async listProperties(search = '') {
    return this._properties.filter(p => !search || p.name.toLowerCase().includes(search.toLowerCase()))
  }

  async listActivities(propertyId) {
    const list = this._byProperty[propertyId] || []
    return [...list].sort((a, b) => String(b.activityDate).localeCompare(String(a.activityDate)))
  }

  async saveActivity(row) {
    const id = row.id ?? `t-${Date.now()}`
    const pid = row.propertyId
    if (!this._byProperty[pid]) this._byProperty[pid] = []
    const idx = this._byProperty[pid].findIndex(t => t.id === id)
    const saved = { ...row, id }
    if (idx >= 0) this._byProperty[pid][idx] = saved
    else this._byProperty[pid].push(saved)
    return saved
  }

  async uploadAttachment(file) {
    return { name: file?.name ?? 'unnamed', size: file?.size ?? 0, id: String(Math.random()) }
  }
}
const cdo = new CashActivityCDO()
// -------------------------------------------------------------------------------

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
  const [row, setRow] = useState(cdo.getEmptyRow)
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
    cdo.listProperties('')
      .then(list => { if (isMounted) setProperties(list) })
    return () => { isMounted = false }
  }, [])

  // load property ledger
  useEffect(() => {
    let isMounted = true
    if (!selectedPropertyId) { setActivities([]); return }
    cdo.listActivities(selectedPropertyId).then(list => { if (isMounted) setActivities(list) })
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

  const clearForm = () => setRow({ ...cdo.getEmptyRow, propertyId: selectedPropertyId, propertyName: properties.find(p => p.id === selectedPropertyId)?.name || '' })

  const onSave = async () => {
    if (!canSubmit) return
    try {
      setIsSaving(true)
      // normalize numeric amount
      const amountNum = Number(row.amount)
      const saved = await cdo.saveActivity({ ...row, amount: isFinite(amountNum) ? amountNum : row.amount })
      setRow(saved)
      const list = await cdo.listActivities(saved.propertyId)
      setActivities(list)
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

  const onEditRow = (t) => {
    setRow({ ...cdo.getEmptyRow, ...t })
    setSelectedPropertyId(t.propertyId)
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

  return (
    <ContentContainer>
      <div className='ca-select' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
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
      <div className='ca-form-wrapper' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <h2 className='segment-header'>{row.id ? 'Edit Cash Activity' : 'Add Cash Activity'}</h2>
        <DatePicker id='activityDate' dataCol='activityDate' placeholder='Activity date' value={row.activityDate || null} onChange={update} />
        <Select id='type' dataCol='type' type='text' value={row.type || 'Distribution'} label='Type' onChange={update}
          data={[
            { value: 'Distribution', caption: 'Distribution (to you)' },
            { value: 'Capital Call', caption: 'Capital Call (you pay)' },
            { value: 'Contribution', caption: 'Additional Contribution' },
            { value: 'Expense', caption: 'Expense/Fees' }
          ]}
        />
        <TextBox id='amount' dataCol='amount' value={row.amount} placeholder='Amount (use negative for outflow)' onChange={update} onSubmit={onSave} type='number' />
        <TextBox id='method' dataCol='method' value={row.method} placeholder='Method (ACH, check, wire)' onChange={update} onSubmit={onSave} />
        <DatePicker id='periodStart' dataCol='periodStart' placeholder='Period start (optional)' value={row.periodStart || null} onChange={update} />
        <DatePicker id='periodEnd' dataCol='periodEnd' placeholder='Period end (optional)' value={row.periodEnd || null} onChange={update} />
        <TextArea id='memo' dataCol='memo' value={row.memo} placeholder='Memo / Notes' onChange={update} />
      </div>
      <div className='ca-attachments' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <div className='ca-drop'>Drop statement/wire receipt (optional)</div>
        <input type='file' onChange={onFilePick} />
        {row.attachment && (
          <div className='ca-fileline'>Attached: {row.attachment.name} <span className='ca-file-meta'>({row.attachment.size} bytes)</span></div>
        )}
      </div>
      <Button styleName='primary submit' disabled={!canSubmit} onClick={onSave}>{isSaving ? 'Saving…' : 'Save Activity'}</Button>
      <div className='ca-ledger-wrapper' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <h2 className='segment-header'>Cash ledger</h2>
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
                    <td>{t.activityDate || ''}</td>
                    <td>{t.type}</td>
                    <td>{fmt(Number(t.amount) || 0)}</td>
                    <td>{t.method || ''}</td>
                    <td>{(t.periodStart && t.periodEnd) ? `${t.periodStart} – ${t.periodEnd}` : ''}</td>
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


