import React, { useState, useEffect, useCallback } from 'react'
import {AppContext, emptyContext} from '../../AppContext'
import Modal from '../controls/Modal/Modal'
import ProfileCDO from '../../cdos/ProfileCDO'
const cdo = new ProfileCDO()

const AuthFrame = (props) => {
    const {appContext, setAppContext} = React.useContext(AppContext)
    const [validSession, setValidSession] = useState(false)
    const [sessionChecked, setSessionChecked] = useState(false)
    const [alertMsg, setAlertMsg] = useState(null)
    
    //if (!appContext.signedIn && props.mandatory) window.location.href = "/"
    const redirectAuth = useCallback((state) => {
        if (appContext.authState !== state  && !appContext.signingOut) {
            var newContext = JSON.parse(JSON.stringify(emptyContext))
            newContext.authState = state
            setAppContext(newContext)
        }
        if (appContext.signingOut) window.location.href = '/'
        setAlertMsg(null)  // added for expired alert modal closing
    }, [appContext.authState, appContext.signingOut, setAppContext])
    
    useEffect(()=>{ 
        const validateSession = () => {
            checkSignedIn()
            checkEmailVerified()
            if (appContext.idEntity) cdo.validateSession({idEntity: appContext.idEntity, idSession: appContext.idSession}, cbValidateSession)
            setSessionChecked(true)
        }

        const checkSignedIn = () => { 
            if (!appContext.signedIn) {
                console.log('Not signed in.')
                redirectAuth('authBlock')
            }
        }

        const checkEmailVerified = () => {
            if (!appContext.emailVerified && !props.profile) {
                console.log('Email address not verified')
                var newContext = JSON.parse(JSON.stringify(appContext))
                newContext.authState = 'verifyEmail'
                setAppContext(newContext)
            }
        }
            
        const cbValidateSession = (error, dbData) => {
            console.log('Session: ' + dbData.response)
            if (!error) {
                if (dbData.response === 'Valid') setValidSession(true)
                if (dbData.response === 'Invalid') redirectAuth('authBlock')
                if (dbData.response === 'Expired') {
                    setAlertMsg('Your session has expired.  Please sign in again.')
                }
            }  
        }
    
        if (!sessionChecked) 
            validateSession()
    }, [validSession, sessionChecked, appContext, setAppContext, redirectAuth, props.profile])

    useEffect(()=>{ setSessionChecked(false) }, [appContext.idSession])

    return ( 
        <div>
            {validSession && props.children}
            {alertMsg ? <Modal buttonText='Close' onClick={()=>redirectAuth('authBlock')}>{alertMsg}</Modal> : null}
        </div>)
    
}

export default AuthFrame
