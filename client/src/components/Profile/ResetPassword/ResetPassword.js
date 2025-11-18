import React, {useState, useContext} from 'react'
import {AppContext} from '../../../AppContext'
import Card from '../../Card/Card'
import PasswordChecks from '../../controls/PasswordChecks/PasswordChecks'
import CheckBox from '../../controls/CheckBox/CheckBox'
import Button from '../../controls/buttons/Button'
import Modal from '../../controls/Modal/Modal'
import ContentContainer from '../../ContentContainer/ContentContainer'
import ProfileCDO from '../../../cdos/ProfileCDO'
const cdo = new ProfileCDO();
    
const ResetPassword = (props) => {

    const {appContext, setAppContext} = useContext(AppContext)
    const [userPassword, setUserPassword] = useState('')
    const [isPasswordValid, setIsPasswordValid] = useState(false)
    const [isPasswordHidden, setIsPasswordHidden] = useState(true)
    const [isProcessing, setIsProcessing] = useState(false)
    const [alertMsg, setAlertMsg] = useState(null)
    
    //get password code from URL to validate reset
    const idSession = window.location.pathname.substring(16, window.location.pathname.length)  //16 because '/reset-password/' is the first 0-15

    const updatePassword = (dataCol, newValue) => setUserPassword(newValue)
    
    const resetPassword = () => {
        setIsProcessing(true)
        cdo.resetPassword({userPassword: userPassword, idSession: idSession}, cbResetPassword)
    }

    const cbResetPassword = (error, data) => {
        console.table(data)
        if (error || data.response !== "Success") {
            if (data.response === 'Expired') {
                setAlertMsg('That link to reset your password has expired.  Please try "Forgot Password" again.')
                setIsProcessing(2)  //code=2 used to redirect to forgot password page
            }
            else {
                setAlertMsg('Error processing request. ' + data.response)
                setIsProcessing(false)
            }
        }
        else {
            setAlertMsg('You have successful reset your password.')
        }
    }

    const closeAlert = () => {
        setAlertMsg(null)
        var newContext = JSON.parse(JSON.stringify(appContext))
        if (isProcessing===2) {
            newContext.authState = 'forgotPassword'
            setAppContext(newContext)
            window.location.href = '/'
        }
        else if (isProcessing) {
            newContext.authState = 'home'
            setAppContext(newContext)
            window.location.href = '/'
        }   
    }

    return (
        <ContentContainer onSubmit={resetPassword}>
            <Card>
                <div className='card-heading'>Reset Password</div>
                <PasswordChecks placeholder1='New Password' type={isPasswordHidden ? 'password' : 'text'} 
                    onChange={updatePassword} passwordValidity={setIsPasswordValid}></PasswordChecks>
                <CheckBox id='showPassword' dataCol='showPassword' onChange={()=>setIsPasswordHidden(!isPasswordHidden)}>
                    Show passwords</CheckBox>
                <Button styleName='primary submit' 
                    disabled={!(!isProcessing && userPassword.length > 0 && isPasswordValid)}
                    onClick={resetPassword}>Submit
                </Button>
            </Card>
            {alertMsg ? <Modal buttonText='Close' onClick={closeAlert}>{alertMsg}</Modal> : null}
        </ContentContainer>
    )
}

export default ResetPassword