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

// Real CDOs
import cdoUpdates, { getEmptyRow as getEmptyUpdateRow } from '../../cdo/cdoUpdates'
import cdoPositions from '../../cdo/cdoPositions'
import cdoAttachments from '../../cdo/cdoAttachments'

// map server row -> UI model
const mapServerToUI = (r = {}) => ({
    id: r.idEntity || r.id || null,
    propertyId: r.idProperty || r.propertyId || '',
    propertyName: r.propertyName || '',
    updateDate: r.updateDate || null,
    revisedSaleDate: r.revisedSaleDate || null,
    revisedIrrPct: r.revisedIrrPct ?? '',
    revisedEquityMultiple: r.revisedEquityMultiple ?? '',
    distributionGuidance: r.distributionGuidance || 'Same as OM',
    notes: r.notes || '',
    attachment: r.attachment || null,
})

// map UI model -> server payload
const mapUIToServer = (u = {}) => {
    const payload = {
        idProperty: u.propertyId || undefined,
        propertyName: u.propertyName || undefined,
        updateDate: u.updateDate || undefined,
        revisedSaleDate: u.revisedSaleDate || undefined,
        revisedIrrPct: u.revisedIrrPct ?? undefined,
        revisedEquityMultiple: u.revisedEquityMultiple ?? undefined,
        distributionGuidance: u.distributionGuidance || undefined,
        notes: u.notes || undefined
    }
    // Only include idEntity if updating an existing record
    if (u.id) payload.idEntity = u.id
    return payload
}

const emptyUIRow = () => mapServerToUI(getEmptyUpdateRow())

const Updates = () => {
    const { appContext } = React.useContext(AppContext)

    // ---- selection / search ------------------------------------------------------
    const [properties, setProperties] = useState([])
    const [selectedPropertyId, setSelectedPropertyId] = useState('')
    const [timeline, setTimeline] = useState([])

    // ---- form state --------------------------------------------------------------
    const [row, setRow] = useState(emptyUIRow())
    const [isSaving, setIsSaving] = useState(false)

    const canSubmit = useMemo(() => {
        const required = [row.propertyId, row.updateDate]
        const hasRequired = required.every(v => v !== undefined && v !== null && String(v).toString().length > 0)
        return !isSaving && hasRequired
    }, [row, isSaving])

    // initial load - properties for selector
    useEffect(() => {
        let isMounted = true
        cdoPositions.listByClient({ activeClient: appContext?.activeClient }, (err, list) => {
            if (!isMounted) return
            const arr = Array.isArray(list) ? list.map(p => ({ id: p.idEntity || p.id, name: p.propertyName || p.name || '', propertyName: p.propertyName || p.name || '' })) : []
            setProperties(arr)
        })
        return () => { isMounted = false }
    }, [])

    // load timeline on property change
    useEffect(() => {
        let isMounted = true
        if (!selectedPropertyId) { setTimeline([]); return }
        cdoUpdates.listByProperty({ idProperty: selectedPropertyId }, (err, list) => {
            if (!isMounted) return
            const arr = Array.isArray(list) ? list : []
            const mapped = arr.map(mapServerToUI).sort((a, b) => String(b.updateDate || '').localeCompare(String(a.updateDate || '')))
            setTimeline(mapped)
        })
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
            propertyName: prop?.propertyName || prop?.name || ''
        }))
    }

    const clearForm = () => {
        if (!selectedPropertyId) {
            alert('Please select a property before adding a new update.')
            return
        }
        setRow({ ...emptyUIRow(), propertyId: selectedPropertyId, propertyName: properties.find(p => String(p.id) === String(selectedPropertyId))?.propertyName || properties.find(p => String(p.id) === String(selectedPropertyId))?.name || '' })
    }

    const onSave = async () => {
        if (!canSubmit) return
        setIsSaving(true)
        try {
            const payload = mapUIToServer(row)
            const res = await new Promise((resolve, reject) => {
                const cb = (err, res) => {
                    if (err) reject(err)
                    else if (res?.error) reject(new Error(typeof res.error === 'object' ? JSON.stringify(res.error, null, 2) : res.error))
                    else resolve(res)
                }
                if (!row.id) cdoUpdates.add(payload, cb)
                else cdoUpdates.update(payload, cb)
            })

            // refresh timeline after save (use payload or selectedPropertyId as fallback)
            const propId = payload?.idProperty || row.propertyId || selectedPropertyId
            await new Promise((resolve) => {
                if (!propId) { resolve(); return }
                cdoUpdates.listByProperty({ idProperty: propId }, (err, list) => {
                    const arr = Array.isArray(list) ? list : []
                    setTimeline(arr.map(mapServerToUI))
                    // ensure selection remains set so timeline is visible
                    if (!selectedPropertyId && propId) setSelectedPropertyId(propId)
                    resolve()
                })
            })
            // clear form to new empty row for new entry (preserve property selection)
            setRow({ ...emptyUIRow(), propertyId: selectedPropertyId, propertyName: properties.find(p => String(p.id) === String(selectedPropertyId))?.propertyName || '' })
            // Show success message
            alert(row.id ? 'Update updated successfully!' : 'Update created successfully!')
        } catch (e) {
            const errMsg = e?.message || (typeof e === 'object' ? JSON.stringify(e, null, 2) : String(e))
            console.error('Save failed:', errMsg)
            alert(`Save failed. Check browser console (F12) for details.`)
        } finally {
            setIsSaving(false)
        }
    }

    const onFilePick = async (evt) => {
        const file = evt?.target?.files?.[0]
        if (!file) return
        // attach to the existing entity if it has an id, otherwise upload but it won't be associated until saved
        const idEntity = row.id || null
        cdoAttachments.uploadAttachment({ idEntity, file }, (err, meta) => {
            if (err) return console.error('upload failed', err)
            setRow(prev => ({ ...prev, attachment: meta }))
        })
        evt.target.value = ''
    }

    const onEditFromTimeline = async (u) => {
        setRow(prev => ({ ...emptyUIRow(), ...mapServerToUI(u) }))
        setSelectedPropertyId(u.propertyId)
    }

    // const bg = appContext?.activeBackground || '#f5f5f5'

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
            {/* <div className='flex-wrapper-row' style={{ backgroundColor: `color-mix(in oklch, white 95%, ${bg} 5%)` }}> */}
            <div className='flex-wrapper-row'>
                <Select
                    id='propertySelect'
                    dataCol='propertyId'
                    label='Select a Property'
                    type='text'
                    value={selectedPropertyId || ''}
                    data={[{ value: '', caption: 'Select a property' }, ...properties.map(p => ({ value: String(p.id), caption: p.propertyName || p.name || '' }))]}
                    onChange={onPickProperty}
                />
                <Button styleName='primary sign-in home' onClick={clearForm} disabled={!selectedPropertyId}>New Update</Button>
            </div>

            {/* <div className='grid-wrapper' style={{ backgroundColor: `color-mix(in oklch, white 95%, ${bg} 5%)` }}> */}
            <div className='grid-wrapper'>
                <h2>{row.id ? 'Edit Update' : 'Create Update'}</h2>
                <DatePicker id='updateDate' dataCol='updateDate' placeholder='Update date' value={row.updateDate || null} onChange={update} disabled={!selectedPropertyId} />
                <DatePicker id='revisedSaleDate' dataCol='revisedSaleDate' placeholder='Revised sale date' value={row.revisedSaleDate || null} onChange={update} disabled={!selectedPropertyId} />
                <TextBox id='revisedIrrPct' dataCol='revisedIrrPct' value={row.revisedIrrPct} placeholder='Revised IRR (est, %)' onChange={update} onSubmit={onSave} type='number' disabled={!selectedPropertyId} />
                <TextBox id='revisedEquityMultiple' dataCol='revisedEquityMultiple' value={row.revisedEquityMultiple} placeholder='Revised Equity Multiple (est)' onChange={update} onSubmit={onSave} type='number' disabled={!selectedPropertyId} />
                <Select id='distributionGuidance' dataCol='distributionGuidance' type='text' value={row.distributionGuidance || 'Same as OM'} label='Distribution guidance' onChange={update} disabled={!selectedPropertyId}
                    data={[
                        { value: 'Same as OM', caption: 'Same as OM' },
                        { value: 'Increase', caption: 'Increase' },
                        { value: 'Decrease', caption: 'Decrease' },
                        { value: 'Suspend', caption: 'Suspend' }
                    ]}
                />
                <TextArea id='notes' dataCol='notes' value={row.notes} placeholder='Notes (capex/occupancy, etc.)' onChange={update} disabled={!selectedPropertyId} />
            </div>

            {/* <div className='updates-attachments' style={{ backgroundColor: `color-mix(in oklch, white 95%, ${bg} 5%)` }}> */}
            <div className='flex-wrapper-column'>
                <div className='attachments-drop'>Drop pdf/image/email</div>
                <input type='file' onChange={onFilePick} disabled={!selectedPropertyId || !row.id} />
                {row.attachment && (
                    <div className='updates-fileline'>Attached: {row.attachment.name} <span className='updates-file-meta'>({row.attachment.size} bytes)</span></div>
                )}
            </div>

            <Button styleName='primary submit' disabled={!canSubmit} onClick={onSave}>{isSaving ? 'Saving…' : 'Save Update'}</Button>

            {/* Timeline */}
            {/* <div className='flex-wrapper-column' style={{ backgroundColor: `color-mix(in oklch, white 95%, ${bg} 5%)`, marginTop: '2rem' }}> */}
            <div className='flex-wrapper-column' style={{ marginTop: '2rem' }}>
                <div style={{ display: 'flex', alignItems: 'center', flexWrap: 'wrap', justifyContent: 'space-evenly', padding: '0 1rem', width: '100%' }}>
                    <h2>Previous updates (timeline)</h2>
                    <Button styleName='primary' onClick={() => clearForm()} disabled={!selectedPropertyId}>Add New</Button>
                </div>
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
                                        <td>{fmtDate(u.updateDate)}</td>
                                        <td>{fmtDate(u.revisedSaleDate)}</td>
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


