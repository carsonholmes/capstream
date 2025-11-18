// controls/DatePicker/DatePicker.jsx
import React, { useEffect, useMemo, useRef, useState } from 'react';
import './DatePicker.css';

const pad2 = (n) => String(n).padStart(2, '0');
const toISO = (d) => (d ? `${d.getFullYear()}-${pad2(d.getMonth() + 1)}-${pad2(d.getDate())}` : '');
const startOfDay = (d) => { const x = new Date(d); x.setHours(0,0,0,0); return x; };

// Parse strings as **local** dates to avoid off-by-one
const normalizeToDate = (v) => {
  if (!v) return null;
  if (v instanceof Date) return Number.isNaN(v.getTime()) ? null : startOfDay(v);
  if (typeof v === 'string' && /^\d{4}-\d{2}-\d{2}$/.test(v)) {
    const [yy, mm, dd] = v.split('-').map(Number);
    return new Date(yy, mm - 1, dd); // local midnight
  }
  const d = new Date(v);
  return Number.isNaN(d.getTime()) ? null : startOfDay(d);
};

const sameDay = (a, b) =>
  !!a && !!b && a.getFullYear() === b.getFullYear() && a.getMonth() === b.getMonth() && a.getDate() === b.getDate();

const daysInMonth = (y, m) => new Date(y, m + 1, 0).getDate();
const firstDow = (y, m) => new Date(y, m, 1).getDay();

export default function DatePicker({
  id,
  dataCol,
  value,
  onChange,
  placeholder = 'Select date',     // <— NEW: prop
  disabled = false,
  className = '',
  align = 'center',                // 'left' | 'center' | 'right' (optional)
}) {
  const selected = normalizeToDate(value);
  const today = useMemo(() => startOfDay(new Date()), []);
  const [open, setOpen] = useState(false);
  const [view, setView] = useState(() => selected || today);

  useEffect(() => { if (selected) setView(selected); }, [selected?.getFullYear?.(), selected?.getMonth?.()]);

  const inputRef = useRef(null);
  const popRef   = useRef(null);

  // close on outside click / Escape
  useEffect(() => {
    if (!open) return;
    const onDocClick = (e) => {
      if (popRef.current?.contains(e.target) || inputRef.current?.contains(e.target)) return;
      setOpen(false);
    };
    const onKey = (e) => e.key === 'Escape' && setOpen(false);
    document.addEventListener('mousedown', onDocClick);
    document.addEventListener('keydown', onKey);
    return () => { document.removeEventListener('mousedown', onDocClick); document.removeEventListener('keydown', onKey); };
  }, [open]);

  const y = view.getFullYear();
  const m = view.getMonth();
  const dim = daysInMonth(y, m);
  const lead = firstDow(y, m);

  const cells = [];
  for (let i = 0; i < lead; i++) cells.push(null);
  for (let d = 1; d <= dim; d++) cells.push(new Date(y, m, d));

  const handlePick = (d) => { setOpen(false); onChange?.(dataCol, toISO(d)); };
  const clear = (e) => { e.stopPropagation(); onChange?.(dataCol, ''); };

  const hasValue = !!selected;

  return (
    <div className={`cs-date-field ${className}`} id={id}>
      {/* “Input shell” */}
      <div
        ref={inputRef}
        className={`cs-date-input ${disabled ? 'is-disabled' : ''} ${hasValue ? 'has-value' : ''}`}
        tabIndex={disabled ? -1 : 0}
        onClick={() => !disabled && setOpen(v => !v)}
        onKeyDown={(e) => {
          if (disabled) return;
          if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); setOpen(v => !v); }
          if (e.key === 'Backspace' || e.key === 'Delete') { e.preventDefault(); clear(e); }
        }}
        aria-haspopup="dialog"
        aria-expanded={open}
      >
        {/* Visible value */}
        <span className="cs-date-value">{hasValue ? toISO(selected) : ''}</span>

        {/* Clear + caret */}
        {!disabled && hasValue && (
          <button type="button" className="cs-date-clear" aria-label="Clear date" onClick={clear}>×</button>
        )}
        <span className="cs-date-caret" aria-hidden>▾</span>
      </div>

      {/* Floating label using your house style */}
      <label
        className={`dp-label ${open || hasValue ? 'label-on-border' : ''}`}
        onClick={() => inputRef.current?.click()}
      >
        {placeholder}
      </label>

      {/* Calendar popup */}
      {open && (
        <div ref={popRef} className={`cs-cal-pop align-${align}`}>
          <div className="cs-cal-header">
            <button type="button" className="nav" onClick={() => setView(new Date(y, m - 1, 1))} aria-label="Prev month">‹</button>
            <div className="title">{view.toLocaleString(undefined, { month: 'long', year: 'numeric' })}</div>
            <button type="button" className="nav" onClick={() => setView(new Date(y, m + 1, 1))} aria-label="Next month">›</button>
          </div>

          <div className="cs-cal-grid">
            {['S','M','T','W','T','F','S'].map((d) => <div key={`h-${d}`} className="dow">{d}</div>)}
            {cells.map((d, i) =>
              d ? (
                <button
                  key={i}
                  type="button"
                  className={
                    'cell' +
                    (sameDay(d, today) ? ' today' : '') +
                    (selected && sameDay(d, selected) ? ' selected' : '')
                  }
                  onClick={() => handlePick(d)}
                >
                  {d.getDate()}
                </button>
              ) : <div key={i} className="cell empty" aria-hidden />
            )}
          </div>
        </div>
      )}
    </div>
  );
}
