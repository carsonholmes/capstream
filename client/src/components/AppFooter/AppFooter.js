import React, {useState} from 'react'
import './AppFooter.css'
import {AppContext} from '../../AppContext'

const AppFooter = () => {

    const {appContext, setAppContext} = React.useContext(AppContext);

    return (
        <div className={`footer-container ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`}>
            &copy; 2025 CapStream.io
        </div>
    )
}

export default AppFooter