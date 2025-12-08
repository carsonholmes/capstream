import React, { useEffect, useMemo, useState, useRef } from 'react'
import { AppContext } from '../../AppContext'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import TextBox, { REGEX_CURRENCY, REGEX_PERCENT } from '../controls/TextBox/TextBox'
import Button from '../controls/buttons/Button'
import Select from '../controls/Select/Select'
import TextArea from '../controls/TextArea/TextArea'
import DatePicker from '../controls/DatePicker/DatePicker'
import './PropertiesAndPositions.css'

// NEW: real CDOs
import cdoPositions, { getEmptyRow as getEmptyPositionRow } from '../../cdo/cdoPositions'
import cdoAttachments from '../../cdo/cdoAttachments'

const PropertiesAndPositions = () => {
  const { appContext } = React.useContext(AppContext)

  // ---- selection / search ------------------------------------------------------
  const [records, setRecords] = useState([])
  const [selectedId, setSelectedId] = useState(null)
  const loadedRef = useRef(false)

  // ---- form state --------------------------------------------------------------
  const [row, setRow] = useState(getEmptyPositionRow())
  const [isSaving, setIsSaving] = useState(false)

  const canSubmit = useMemo(() => {
    const required = [row.propertyName, row.sponsorGP, row.lpEntity, row.investedEquity, row.investmentDate]
    const hasRequired = required.every(v => v !== undefined && v !== null && String(v).toString().length > 0)
    return !isSaving && hasRequired
  }, [row, isSaving])

  // ---- data load ---------------------------------------------------------------
  useEffect(() => {
    if (loadedRef.current) return
    loadedRef.current = true
    cdoPositions.listByClient({activeClient: appContext.activeClient}, (err, data) => {
      if (!err) {
        console.log(data)
        setRecords(Array.isArray(data) ? data : [])
      }
      else console.error('positions.list error', err, data)
    })
  }, [])

  // when a record is selected, load it
  useEffect(() => {
    if (!selectedId || selectedId === undefined || selectedId === null) return
    cdoPositions.load({ idEntity: selectedId }, (err, data) => {
      if (err) return console.error('positions.load error', err, data)
      const loaded = { ...getEmptyPositionRow(), ...(data || {}) }
      setRow(loaded)
      // Also fetch attachments for this entity (service expects idEntity)
      cdoAttachments.listAttachments({ idEntity: loaded.idEntity }, (aerr, list) => {
        if (!aerr && Array.isArray(list)) setRow(prev => ({ ...prev, attachments: list }))
      })
    })
  }, [selectedId])

  // ---- helpers ----------------------------------------------------------------
  const update = (dataCol, newValue) => setRow(prev => ({ ...prev, [dataCol]: newValue }))

  const refreshList = () => {
    cdoPositions.listByClient({activeClient: appContext.activeClient}, (err, data) => {
      if (!err && data !== undefined) setRecords(Array.isArray(data) ? data : [])
    })
  }

  const clearForm = () => {
    setSelectedId(null)
    setRow(getEmptyPositionRow())
  }

  const onSave = () => {
    if (!canSubmit) return
    setIsSaving(true)
    const isNew = !row.idEntity
    const done = (err, payload) => {
      setIsSaving(false)
      if (err || payload?.error) {
        // Build a helpful message for the user from available error info
        const serverMsg = payload?.error || payload?.message || payload?.sqlMessage
        const errMsg = err?.message || (typeof err === 'string' ? err : null)
        const toJson = (v) => {
          try {
            return (typeof v === 'object') ? JSON.stringify(v, null, 2) : String(v)
          } catch (e) {
            try { return String(v) } catch (e2) { return 'Unserializable error' }
          }
        }
        const details = serverMsg ? toJson(serverMsg) : (errMsg ? toJson(errMsg) : (payload ? toJson(payload) : 'Unknown error'))
        // Show a clearer alert and log full objects for debugging
        alert(`Save failed: ${details}`)
        console.error('save error', err, payload)
        return
      }
      // After save, reload list and keep editing the saved row
      const savedId = payload?.idEntity || row.idEntity
      setSelectedId(savedId)
      refreshList()
      // Show success message
      alert(isNew ? 'Property & Position created successfully!' : 'Property & Position updated successfully!')
    }
    const data = {...row, activeClient: appContext.activeClient}
    if (isNew) cdoPositions.add(data, done)
    else cdoPositions.update(data, done)
  }

  const onFilePick = (evt) => {
    const file = evt?.target?.files?.[0]
    if (!file) return
    if (!row.idEntity) { alert('Save the record before adding files.'); return }
    cdoAttachments.uploadAttachment({ idEntity: row.idEntity, file }, (err, meta) => {
      if (err || meta?.error) {
        alert('Upload failed')
        console.error('upload error', err, meta)
      } else {
        // refresh attachment list
        cdoAttachments.listAttachments({ idEntity: row.idEntity }, (aerr, list) => {
          if (!aerr && Array.isArray(list)) setRow(prev => ({ ...prev, attachments: list }))
        })
      }
      if (evt?.target) evt.target.value = ''
    })
  }

  const deleteAttachment = (idAttachment) => {
    if (!window.confirm('Delete this file?')) return
    cdoAttachments.deleteAttachment({ idAttachment }, (err, resp) => {
      if (err || resp?.error) {
        alert('Delete failed')
        console.error('delete attachment error', err, resp)
        return
      }
      cdoAttachments.listAttachments({ idEntity: row.idEntity }, (aerr, list) => {
        if (!aerr && Array.isArray(list)) setRow(prev => ({ ...prev, attachments: list }))
      })
    })
  }

  const renderRecordOptionLabel = (r) => `${r.propertyName} — ${r.sponsorGP}`
  const bg = appContext?.activeBackground || '#f5f5f5'

  // ---- render -----------------------------------------------------------------
  return (
    <ContentContainer>
      <div className='pap-select' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <Select id='existingRecord' dataCol='existingRecord' label='Select a Position to Edit' type='text' value={selectedId ?? -1} onChange={(col, v) => setSelectedId(v === -1 ? null : String(v))}
          data={[{ value: -1, caption: 'Select a Property & Position record to edit' }, ...records.map(r => ({ value: String(r.idEntity), caption: renderRecordOptionLabel(r) }))]}/>
        <Button styleName='primary sign-in home' onClick={clearForm}>Add New</Button>
      </div>
      <div className='pap-wrapper' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <h2 className='segment-header'>{row.idEntity ? 'Edit Property & Position' : 'Create Property + Position'}</h2>
        <h3 className='segment-subheader'>Property</h3>
        <TextBox id='propertyName' dataCol='propertyName' value={row.propertyName} placeholder='Name' onChange={update} onSubmit={onSave} />
        <TextBox id='sponsorGP'   dataCol='sponsorGP'   value={row.sponsorGP}   placeholder='Sponsor/GP' onChange={update} onSubmit={onSave} />
        <TextBox id='partnershipLP' dataCol='partnershipLP' value={row.partnershipLP} placeholder='Partnership (LP)' onChange={update} onSubmit={onSave} />
        <DatePicker id='acquisitionDate' dataCol='acquisitionDate' placeholder='Acquisition Date' value={row.acquisitionDate || null} onChange={update} />
        <TextArea id='propertyNotes' dataCol='propertyNotes' value={row.propertyNotes} placeholder='Notes' onChange={update} />
        <h3 className="segment-subheader">Your Position</h3>
        <TextBox id='lpEntity' dataCol='lpEntity' value={row.lpEntity} placeholder='LP Entity' onChange={update} onSubmit={onSave} />
        <TextBox id='investedEquity' dataCol='investedEquity' value={row.investedEquity ?? ''} placeholder='Invested equity' onChange={update} onSubmit={onSave} type='number' step='0.01' regex={REGEX_CURRENCY}/>
        <DatePicker id='investmentDate' dataCol='investmentDate' placeholder='Investment Date' value={row.investmentDate || null} onChange={update} />
        <div className='ownership-and-help'>
          <TextBox id='ownershipPct' dataCol='ownershipPct' value={row.ownershipPct ?? ''} placeholder='Ownership %' onChange={update} onSubmit={onSave} type='number' step='0.01' regex={REGEX_PERCENT}/>
          <span className='pap-help' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>Leave blank if unknown or single-investor</span>
        </div>
        <TextBox id='prefReturnPct' dataCol='prefReturnPct' value={row.prefReturnPct ?? ''} placeholder='Preferred return (%)' onChange={update} onSubmit={onSave} type='number' step='0.01' regex={REGEX_PERCENT}/>
          <Select id='distributionCadence' dataCol='distributionCadence' type='text' value={row.distributionCadence || 'Monthly'} label='Distribution cadence' onChange={update}
              data={[
                { value: 'Monthly', caption: 'Monthly' },
                { value: 'Quarterly', caption: 'Quarterly' },
                { value: 'Semiannual', caption: 'Semiannual' },
                { value: 'Annually', caption: 'Annually' }
              ]}/>
        <h3 className='segment-subheader'>Targets from OM</h3>
        <TextBox id='targetIRR' dataCol='targetIRR' value={row.targetIRR ?? ''} placeholder='Target IRR (%)' onChange={update} onSubmit={onSave} type='number' step='0.01' regex={REGEX_PERCENT} />
        <TextBox id='targetEquityMultiple' dataCol='targetEquityMultiple' value={row.targetEquityMultiple ?? ''} placeholder='Target Equity Multiple' onChange={update} onSubmit={onSave}
          type='number' step='0.01' regex={REGEX_CURRENCY} />
        <DatePicker id='projectedSaleDate' dataCol='projectedSaleDate' placeholder='Projected Sale Date' value={row.projectedSaleDate || null} onChange={update} />
        <Button styleName='primary submit' disabled={!canSubmit} onClick={onSave}>{isSaving ? 'Saving…' : 'Save'}</Button>
      </div>
      <div className='pap-attachments' style={{ backgroundColor:`color-mix(in oklch, white 95%, ${bg} 5%)`}}>
        <div className='pap-drop'>Drop OM PDF here (optional)</div>
        <input type='file' onChange={onFilePick} />
        {row.attachments?.length > 0 && (
          <ul className='pap-files'>
            {row.attachments.map((f) => (
              <li key={f.idAttachment || f.id}>
                {f.fileName || f.name} <span>({f.sizeBytes ?? f.size ?? 0} bytes)</span>
                <Button kind='text' styleName='primary home sign-cancel' onClick={() => deleteAttachment(f.idAttachment || f.id)}>Delete</Button>
              </li>
            ))}
          </ul>
        )}
      </div>
    </ContentContainer>
  )
}

export default PropertiesAndPositions