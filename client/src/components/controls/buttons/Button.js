import React from 'react'
// uses styling from App.css

const Button = (props) => {
    
    const setStyle = () => {
        var style = 'standard'
        if (props.styleName) style += ' '  + props.styleName
        if (props.disabled) style += ' disabled'
        return style
    }

    const handleClick = () => {
        if (!props.disabled) {
            if (props.onClick) setTimeout(props.onClick, 1)
            if (props.to) window.location.href = props.to
        }
    }

    return (
        <button className={setStyle()} onClick={handleClick}>     
            {props.children}
        </button>)
}

export default Button
