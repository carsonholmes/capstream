import React from 'react'
import HelpIcon from '../HelpIcon/HelpIcon'
import './RadioButtons.css'

const RadioButtons = (props) => {

    const onChange = (index) => {
        if (props.onChange) props.onChange(props.dataCol, props.data[index].value)
    }

    return (
        <div className={props.styleName ? `${props.styleName} radio-buttons-container` :
            'radio-buttons-container'}>
            {props.data.map((row, index)=> {
                return (
                    <span key={index} className={props.styleName ?
                        `${props.styleName} radio-button-and-label` : 'radio-button-and-label'}>
                        <input type='radio' className={index===0 ? 'radio-button' : 'radio-button'}
                            id={row.caption} name={props.name} checked={row.value===props.value}
                            onChange={()=>onChange(index)}>
                        </input>
                        <label className={index===props.data.length-1 || row.help ? 'radio-button'
                            : 'radio-button'}
                            htmlFor={row.caption}>
                            {row.caption}
                        </label>
                        {row.help && <HelpIcon>{row.help}</HelpIcon>}
                    </span>
                )
            })}
        </div>
    )
}

export default RadioButtons
