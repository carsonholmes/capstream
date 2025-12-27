import React from 'react'
import { AppContext } from '../../AppContext'
import Button from '../controls/buttons/Button'
import './ClientBanner.css'

// Reuse the same WCAG-ish contrast logic so text stays readable
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

// Static tabs: no hook needed
const TABS = [
//   { key: 'home', label: 'Reporting' },
  { key: 'reporting', label: 'Reporting' },
  { key: 'positions', label: 'Positions' },
  { key: 'updates', label: 'Updates' },
  { key: 'cash-activity', label: 'Cash Activity' },
]

export default function ClientBanner() {
  const { appContext, setAppContext } = React.useContext(AppContext)

  // Hooks FIRST, before any early return.
  const tabRefs = React.useRef([])

  const bg = appContext?.activeBackground || '#f5f5f5'
  const name = appContext?.activeClientName || ''
  const textColor = getContrastTextColor(bg)
  const current = appContext?.authState

  // Hide the banner if no active client
  if (!appContext?.activeClient) return null

  const switchClient = () => {
    const next = { ...appContext, authState: 'clients' }
    setAppContext(next)
  }

  const goToTab = (tabKey) => {
    const next = { ...appContext, authState: tabKey }
    setAppContext(next)
  }

  const onKeyDown = (e, idx) => {
    const { key } = e
    const lastIdx = TABS.length - 1
    let nextIdx = idx

    if (key === 'ArrowRight') nextIdx = idx === lastIdx ? 0 : idx + 1
    if (key === 'ArrowLeft')  nextIdx = idx === 0 ? lastIdx : idx - 1
    if (key === 'Home')       nextIdx = 0
    if (key === 'End')        nextIdx = lastIdx

    if (nextIdx !== idx && ['ArrowRight','ArrowLeft','Home','End'].includes(key)) {
      e.preventDefault()
      tabRefs.current[nextIdx]?.focus()
    }

    if (key === 'Enter' || key === ' ') {
      e.preventDefault()
      goToTab(TABS[idx].key)
    }
  }

  return (
    <div
      className="client-banner"
      style={{ backgroundColor: bg, color: textColor, '--client-bg': bg }}
      role="region"
      aria-label="Active client banner"
    >
      <div className="client-banner__content">
        <div className="client-banner__spacer" aria-hidden="true" />
        <div className="client-banner__title" title={name}>
          {name}
        </div>
        <div className="client-banner__actions">
          <Button onClick={switchClient} styleName="primary home switch">
            Switch Client
          </Button>
        </div>
      </div>

      {/* Tabs show only when signed in; small-screen hiding handled via CSS */}
      {appContext?.signedIn && (
        <div
          className="client-banner__tabs"
          role="tablist"
          aria-label="Client sections"
        >
          {TABS.map((t, i) => {
            const selected = current === t.key
            return (
              <button
                key={t.key}
                ref={el => (tabRefs.current[i] = el)}
                className={`client-banner__tab${selected ? ' is-active' : ''}`}
                role="tab"
                aria-selected={selected}
                aria-controls={`panel-${t.key}`}
                tabIndex={selected ? 0 : -1}
                onClick={() => goToTab(t.key)}
                onKeyDown={(e) => onKeyDown(e, i)}
                style={selected ? { backgroundColor: `color-mix(in oklch, white 30%, ${bg} 70%)` } : undefined}
                type="button"
              >
                <span className="tab-label">{t.label}</span>
              </button>
            )
          })}
        </div>
      )}
    </div>
  )
}
