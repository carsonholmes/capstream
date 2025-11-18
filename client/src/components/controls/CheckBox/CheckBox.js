import React from 'react'
import './CheckBox.css'

const CheckBox = (props) => {

    const notifyChange = (event) => {
        if (props.onChange) props.onChange(props.dataCol, event.target.checked)
    }

    return (
        <div className={props.styleName ? `${props.styleName}` : ''}>
            <input type='checkbox' className={props.styleName ? `checkbox ${props.styleName}` : 'checkbox'}
                id={props.id} onChange={notifyChange} disabled={props.disabled} checked={props.checked}
                defaultChecked={props.defaultChecked}/>
            <label className={props.styleName ? `${props.styleName} checkbox` : 'checkbox'}
                htmlFor={props.id}>{props.children}</label>                                    
        </div>
    )
}

export default CheckBox
