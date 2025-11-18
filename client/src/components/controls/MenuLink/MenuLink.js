import React from 'react'
import './MenuLink.css'

const MenuLink = (props) => {

    const handleClick = () => {
        if (!props.disabled) {
            props.onClick()
            if (props.to && window.location.pathname !== props.to) window.location.href = props.to
        }
    }

    return (
        <div className={props.disabled ? 'menu-link-disabled' : 'menu-link-container'} onClick={handleClick}>
            <span><img className='menu-link-icon' src={props.src} alt='menu icon'/></span>
            <span className='menu-link-text'>{props.children}</span>
        </div>
    )

}

export default MenuLink
