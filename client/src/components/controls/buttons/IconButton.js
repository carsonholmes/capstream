import React from 'react'
import './button.css'

const IconButton = (props) => {

    const setStyle = () => {
        var style = 'icon-button'
        if (props.styleName) {
            if (props.disabled) style = `${style} ${props.styleName} disabled`
            else style = `${style} ${props.styleName}`
        }
        else if (props.disabled) style = `${style} disabled`
        return style
    }

    const handleClick = () => {
        if (!props.disabled && props.onClick) props.onClick()
    }

    return (
        <button className={setStyle()} onClick={handleClick}>
            <div className={props.disabled ? 'button-contents-container disabled' : 'button-contents-container'}>
                <img className='icon' src={props.src} alt={props.caption}/>
                {props.caption &&
                    <label className={props.disabled ? 'button-caption disabled' : 'button-caption'}>
                        {props.caption}</label>}
                {props.tooltip &&
                    <div className={props.disabled ? 'tooltip disabled' : 'tooltip'}>{props.tooltip}</div>}
            </div>
        </button>    
    )
}

export default IconButton
