import React from 'react'
//import React, {useState} from 'react'
//import {Redirect} from 'react-router-dom'
import './NavLink.css'

const NavLink = (props) => {
    
    const onClick = () => {
        if (props.onClick) setTimeout(props.onClick, 1);
    }

    return <a className={props.styleName ? props.styleName + ' nav-link' : 'nav-link'}
        href={props.to} onClick={onClick}>{props.src ? <img className='icon' src={props.src} alt='Navigation Icon'/> : ''}
        {props.children}</a>
}

export default NavLink
