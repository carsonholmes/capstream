import React from 'react'
// imports styling from TextBox.css

const PhoneBox = (props) => {

    const notifyChange = (event) => {
        if (props.onChange) props.onChange(props.dataCol, event.target.value)
     }

    return (
        <div className='input-container'>
            <input className='input-element' type='tel' id={props.id} value={props.value}
            placeholder=' ' onChange={(event) => notifyChange(event)} onBlur={props.onBlur}></input>
            <label htmlFor={props.id} className='input-label'>{props.placeholder}</label>
        </div>
    )
}

export default PhoneBox
