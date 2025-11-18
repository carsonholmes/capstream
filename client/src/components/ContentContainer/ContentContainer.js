import React from 'react'
import './ContentContainer.css'
import {AppContext} from '../../AppContext'

const ContentContainer = (props) => {

    const {appContext, setAppContext} = React.useContext(AppContext)
        
    const keyDown = event  => {
        if (event.keyCode===13) 
            if (props.onSubmit) props.onSubmit()
    }

    return (
        <main className={props.styleName ? `content-container ${props.styleName} ${appContext.darkMode ? 'dark-mode' : 'light-mode'}` : `content-container ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`}
            onKeyDown={keyDown} tabIndex={-1}>
            <h1 className='content-heading'>{props.contentHeading}</h1>
            <form onSubmit={(e)=>{ e.preventDefault(); props.onSubmit?.(); }} autoComplete="off">
                {props.children}
            </form>
        </main>
    )
}

export default ContentContainer
