import React, { useRef, useState } from 'react'
import { AppContext } from '../../AppContext'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import TextBox from '../controls/TextBox/TextBox'
import Button from '../controls/buttons/Button'
import './Clients.css'
import cdo from '../../cdo/cdoGroup';

// If you're using react-colorful:
import { HexColorPicker, HexColorInput } from 'react-colorful'

// WCAG-ish contrast check for foreground text
function getContrastTextColor(hex) {
  let c = hex?.trim() || '#ffffff'
  if (!/^#([0-9a-f]{3}|[0-9a-f]{6})$/i.test(c)) c = '#ffffff'
  if (c.length === 4) c = '#' + [...c.slice(1)].map(ch => ch + ch).join('')
  const r = parseInt(c.slice(1,3), 16)
  const g = parseInt(c.slice(3,5), 16)
  const b = parseInt(c.slice(5,7), 16)
  const L = (0.2126*r + 0.7152*g + 0.0722*b) / 255
  return L > 0.6 ? '#000' : '#fff'
}

// Sanitize -> class-safe suffix
const clsForId = (id) => `client-color-${String(id || 'new').replace(/[^a-z0-9_-]/gi, '')}`

export default function Clients() {
  const {appContext, setAppContext} = React.useContext(AppContext);
  const [rows, setRows] = useState([])
  const dataLoaded = useRef(false)
  const [editingId, setEditingId] = useState(null)
  const [draft, setDraft] = useState({...cdo.getEmptyRow(), groupType: cdo.CLIENT_GROUP_TYPE} )
  
  const cbList = (error, data) => {
      if (!error) {
        setRows(data || [])
        console.log(data)
      }
      else {
        alert(JSON.stringify(data,null,2))
    }
  }

  React.useEffect(() => {
    if (!dataLoaded.current) {
      dataLoaded.current = true
      cdo.list(cbList)
    }
  }, [rows])

  const startAdd = () => { setDraft(cdo.getEmptyRow()); setEditingId('new') }
  const startEdit = (row) => { setDraft({ ...row }); setEditingId(row.idEntity) }
  const cancelEdit = () => { setEditingId(null); setDraft(cdo.getEmptyRow()) }
  const setActive = (row) => {
      var newContext = JSON.parse(JSON.stringify(appContext))
      newContext.activeClient = row.idEntity
      newContext.activeClientName = row.entityTitle
      newContext.activeBackground = row.backgroundColor
      newContext.authState = 'home'
      setAppContext(newContext)
  }

  // Match TextBox signature (dataCol, newValue)
  const update = (dataCol, newValue) =>
    setDraft(prev => ({ ...prev, [dataCol]: newValue }))

  const cbAdd = (error, data) => {
    if (error === null && !data?.error ) {
      cancelEdit()
      cdo.list(cbList)
    }
    else {
     alert(JSON.stringify(error,null,2))
      alert(JSON.stringify(data,null,2))
    }
  }

  const cbUpdate = (error, data) => {
    if (error === null && !data?.error ) {
      var newContext = JSON.parse(JSON.stringify(appContext))
      newContext.activeClientName = draft.entityTitle
      newContext.activeBackground = draft.backgroundColor
      setAppContext(newContext)
      cancelEdit()
      cdo.list(cbList)
    }
    else {
     alert(JSON.stringify(error,null,2))
      alert(JSON.stringify(data,null,2))
    }
  }
  
  const save = async () => {
    const payload = { ...draft }
    if (!/^#([0-9a-f]{6})$/i.test(payload.backgroundColor)) {
      alert('Please use a 6-digit HEX like #AABBCC'); return
    }
    if (editingId === 'new') cdo.addGroup(payload, cbAdd) 
    else cdo.updateGroup(payload, cbUpdate)
  }

  const remove = async (id) => {
    if (!window.confirm('Delete this client?')) return
    cdo.deleteGroup({ idEntity: id }, cbUpdate);
  }

  return (
    <AppContext.Consumer>
      {() => (
        <ContentContainer>
          {/* Inject the dynamic color classes */}
          {rows.length>0 && <style>{rows.map(r => {
                                      const fg = getContrastTextColor(r.backgroundColor)
                                      const cls = clsForId(r.idEntity)
                                      return `.${cls}{background-color:${r.backgroundColor} !important;color:${fg} !important;}`
                                    }).join('\n')}</style>}
          <div className="clients-header">
            <Button onClick={startAdd} styleName='primary home add-client' >Add Client</Button>
          </div>

          <div className="clients-list">
            {editingId === 'new' && (
              <Card className="client-card editing" cardHeading="New Client">
                <div className="client-form">
                  <div className="field">
                    <TextBox
                      id="clientName_new"
                          dataCol="entityTitle"
                          value={draft.entityTitle}
                          placeholder="Client Name"
                          onChange={update}
                          styleName = "client-name"
                    />
                  </div>

                  <div className="color-field">
                    <div className="label">Background Color</div>
                    <div className="color-picker-wrap">
                      <HexColorPicker
                        color={draft.backgroundColor}
                        onChange={c => setDraft({ ...draft, backgroundColor: `#${c.replace('#','')}` })}
                      />
                      <HexColorInput
                        color={draft.backgroundColor}
                        onChange={c => setDraft({ ...draft, backgroundColor: c.startsWith('#') ? c : `#${c}` })}
                        prefixed
                        className="hex-input"
                      />
                      <div className="hint">Use HEX (e.g., #AABBCC)</div>
                    </div>
                  </div>

                  <div className="actions">
                    <Button onClick={save}  styleName='primary home' >Save</Button>
                    <Button kind="text" onClick={cancelEdit}  styleName='primary home sign-cancel' >Cancel</Button>
                  </div>
                </div>
              </Card>
            )}

            {rows.length>0 && rows.map(row => {
              const isEditing = editingId === row.idEntity
              const isActive = appContext?.activeClient === row.idEntity
              const colorClass = isEditing ? 'editing' : clsForId(row.idEntity)

              return (
                <Card
                  key={row.idEntity}
                  styleName={`client-card ${isEditing ? 'editing' : ''} ${isActive ? 'active' : ''} ${colorClass}`}
                >
                  {isEditing ? (
                    <div className="client-form">
                      <div className="field">
                        <div className="label">Client Name</div>
                        <TextBox
                          id="clientName_new"
                          dataCol="entityTitle"
                          value={draft.entityTitle}
                          placeholder="Client Name"
                          onChange={update}
                        />
                      </div>

                      <div className="field">
                        <div className="label">Background Color</div>
                        <div className="color-picker-wrap">
                          <HexColorPicker
                            color={draft.backgroundColor}
                            onChange={c => setDraft({ ...draft, backgroundColor: `#${c.replace('#','')}` })}
                          />
                          <HexColorInput
                            color={draft.backgroundColor}
                            onChange={c => setDraft({ ...draft, backgroundColor: c.startsWith('#') ? c : `#${c}` })}
                            prefixed
                            className="hex-input"
                          />
                          <div className="hint">Use HEX (e.g., #AABBCC)</div>
                        </div>
                      </div>
                      <div className="actions">
                        <Button onClick={save} styleName='primary sign-in home' >Save</Button>
                        <Button kind="text" onClick={cancelEdit} styleName='primary home sign-cancel' >Cancel</Button>
                      </div>
                    </div>
                  ) : (
                    <div className="client-display">
                      <div className="client-title" onClick={() => setActive(row)}>{row.entityTitle}</div>
                      <div className="actions">
                        <Button onClick={() => startEdit(row)} styleName='primary home' >Edit</Button>
                        {row.idEntity !== appContext.activeClient && <Button onClick={() => setActive(row)} styleName='primary home' >Set Active</Button>}
                        <Button kind="text" onClick={() => remove(row.idEntity)} styleName='primary home sign-cancel' >Delete</Button>
                      </div>
                    </div>
                  )}
                </Card>
              )
            })}
          </div>
        </ContentContainer>
      )}
    </AppContext.Consumer>
  )
}
