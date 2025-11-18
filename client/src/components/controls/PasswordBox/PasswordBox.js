import React from 'react'
// uses styling from TextBox.css

const PasswordBox = (props) => {
    
    const notifyChange = (event) => {
        if (props.onChange) props.onChange(props.dataCol, event.target.value)
     }

    const checkPassword = (event) => {
        if (props.onBlur) props.onBlur(event.target.value)
    }
 
    return (
        <div className='input-container'>
            <input className={props.error ? 'input-element not-matching-border' : 'input-element'} 
                type={props.type ? props.type : 'password'} id={props.id} value={props.value}
                placeholder={' '} onChange={(event)=>notifyChange(event)}
                onBlur={(event)=>checkPassword(event)} onFocus={props.onFocus}>
            </input>
            <label className={props.error ? 'input-label error-label' : 'input-label'}
                htmlFor={props.id}>{props.placeholder}</label>
        </div>
    )
}

export default PasswordBox
