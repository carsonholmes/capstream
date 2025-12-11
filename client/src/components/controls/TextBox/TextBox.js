import React, { useState } from 'react'
import './TextBox.css'
import { AppContext } from '../../../AppContext'

// Regex helpers exported for callers to reuse
export const REGEX_NUMBER   = /^[0-9]+$|^$/;                 // integers only or empty
export const REGEX_CURRENCY = /^[0-9]*\.?[0-9]{0,2}$|^$/;    // up to 2 decimals or empty
// 0–100 inclusive, allow up to 2 decimals (e.g., 7, 7.5, 99.99, 100, 0, 0.5)
export const REGEX_PERCENT  = /^(100(\.0{1,2})?|(\d{1,2})(\.\d{1,2})?|0(\.\d{1,2})?)$|^$/;

const TextBox = (props) => {
  const { appContext } = React.useContext(AppContext);
  const [displayErrorMessage, setDisplayErrorMessage] = useState(false);

  const checkForError = (value) => {
    if (value === '') setDisplayErrorMessage(true);
    else setDisplayErrorMessage(false);
  };

  const notifyChange = (event) => {
    const raw = event.target.value;

    // Respect optional regex guard first
    if (!props.regex || props.regex.test(raw)) {
      if (props.onChange) {
        if (props.type === 'number') {
          // Strip thousands separators, attempt float conversion
          const cleaned = raw.replace(/,/g, '');
          const num = cleaned === '' ? '' : Number.parseFloat(cleaned);

          // If empty or a finite number, pass number (or empty). Otherwise keep raw string to avoid NaN mid-typing.
          if (cleaned === '' || Number.isFinite(num)) {
            props.onChange(props.dataCol, cleaned === '' ? '' : num);
          } else {
            props.onChange(props.dataCol, raw);
          }
        } else {
          props.onChange(props.dataCol, raw);
        }
      }
      if (props.emptyError) checkForError(raw);
    } else if (props.emptyError) {
      checkForError(props.value);
    }
  };

  const keyDown = (event) => {
    if (event.keyCode === 13 && props.onSubmit) {
      props.onSubmit();
    }
  };

  // Display-only mode
  if (props.displayOnly) {
    return (
      <div className={props.styleName ? `input-container ${props.styleName} ${appContext.darkMode ? 'dark-mode' : 'light-mode'}` : `input-container ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`}>
        <label htmlFor={props.id} className="display-label">{props.placeholder}</label>
        <label id={props.id} className={props.styleName ? `display-value ${props.styleName}` : 'display-value'} onClick={props.onClick}>{props.value}</label>
      </div>
    );
  }

  // Editable input
  return (
    <div className={props.styleName ? `input-container ${props.styleName} ${appContext.darkMode ? 'dark-mode' : 'light-mode'}` : `input-container ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`}>
      <input
        id={props.id}
        value={props.value}
        placeholder=" "
        onFocus={props.onFocus}
        className={
          props.styleName
            ? `input-element ${props.styleName} ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`
            : `input-element ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`
        }
        type={props.type || 'text'}
        step={props.step}
        onChange={notifyChange}
        onBlur={props.onBlur}
        onClick={props.onClick}
        disabled={props.disabled}
        inputMode={props.inputMode || (props.type === 'number' ? 'decimal' : undefined)}
        onKeyDown={keyDown}
        autoComplete="off"
        name={props.name}/>
      <label htmlFor={props.id} className={props.error ? 'input-label error-label' : 'input-label'}>{props.placeholder}</label>
      {displayErrorMessage && <div className="input-error">{props.emptyError}</div>}
    </div>
  );
};

export default TextBox;
