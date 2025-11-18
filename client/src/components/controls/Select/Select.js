import React, { Fragment, useRef, useState } from 'react';
import './Select.css';

const isUnselected = (v) =>
  v === '' || v === null || v === undefined || v === -1 || v === '-1';

const Select = ({
  id,
  value,
  data = [],
  label,
  onChange,
  type = 'text',          // 'text' | 'number'
  dataCol,
  disabled = false,
  containerStyle = '',
  styleName = '',
  optionsStyle = '',
  placeholderStyle = '',
}) => {
  const [focused, setFocused] = useState(false);
  const ref = useRef(null);

  const handleChange = (e) => {
    const raw = e.target.value;
    if (!onChange) return;

    if (type === 'number') {
      const n = raw === '' ? null : Number(raw);
      onChange(dataCol, Number.isFinite(n) ? n : null);
    } else {
      onChange(dataCol, raw);
    }
  };

  const selectCls = [
    'input-element',
    isUnselected(value) ? 'options-container' : '',
    styleName || '',
  ]
    .filter(Boolean)
    .join(' ');

  const labelCls = [
    'label-as-placeholder',
    !isUnselected(value) || focused ? 'label-on-border' : '',
    placeholderStyle || '',
  ]
    .filter(Boolean)
    .join(' ');

  return (
    <div className={`input-container ${containerStyle}`}>
      <select
        id={id}
        value={isUnselected(value) ? '' : value}
        onChange={handleChange}
        onFocus={() => setFocused(true)}
        onBlur={() => setFocused(false)}
        className={selectCls}
        disabled={disabled}
        ref={ref}
      >
        {/* Proper placeholder option */}
        <option value="" disabled hidden>
          {/* kept hidden; visible text is the floating label */}
        </option>

        {data.map((row, i) => (
          <Fragment key={i}>
            <option
              value={row.value}
              className={
                row.value === -1
                  ? `placeholder-option ${optionsStyle || ''}`.trim()
                  : `not-placeholder-option ${optionsStyle || ''}`.trim()
              }
            >
              {row.caption}
            </option>
          </Fragment>
        ))}
      </select>

      <label
        htmlFor={id}
        className={labelCls}
        onClick={() => ref.current?.focus()}
      >
        {label}
      </label>
    </div>
  );
};

export default Select;
