import React, {useState} from 'react'
import {AppContext} from '../../../AppContext'
import Card from '../../Card/Card'
import TextBox from '../../controls/TextBox/TextBox'
import EmailBox from '../../controls/EmailBox/EmailBox'
import Button from '../../controls/buttons/Button'
import NavLink from '../../controls/NavLink/NavLink'
import Modal from '../../controls/Modal/Modal'
import ProfileCDO from '../../../cdos/ProfileCDO'
import ContentContainer from '../../ContentContainer/ContentContainer'
const cdo = new ProfileCDO();

const ForgotPassword = (props) => {
    const {appContext, setAppContext} = React.useContext(AppContext);
    const [forgotData, setForgotData] = useState({emailAddress: '', userNameOrEmail: ''})
    const [isProcessing, setIsProcessing] = useState(false)
    const [alertMsg, setAlertMsg] = useState(null)
    const [isEmailValid, setIsEmailValid] = useState(false)

    const updateForgotData = ( dataCol, newValue) => {
        let newData = {...forgotData}
        newData[dataCol] = newValue
        setForgotData(newData)
    }

    const forgotUserName = () => {
        setIsProcessing(true)
        setAlertMsg('If your account was found, an email with your user name has been sent.  Please check your email.')
        cdo.forgotUserName(forgotData, cbForgot)
    }

    const forgotPassword = () => {
        setIsProcessing(true)
        setAlertMsg('If your account was found, an email to reset your password has been sent.  Please check your email and use the link provided to create a new password.')
        cdo.forgotPassword(forgotData, cbForgot)
    }

    const cbForgot = (error, data) => {
        if (error) {
            setAlertMsg('Error processing request.  Please try again later.')
            setIsProcessing(false)
        }
    }

    const closeAlert = () => {
        setAlertMsg(null)
        var newContext = JSON.parse(JSON.stringify(appContext))
        if (isProcessing) {
            newContext.authState = 'home'
            setAppContext(newContext)
        }
    }

    const clickSignIn = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'signIn'
        setAppContext(newContext)
    }

    const enableGetUserName = () => {
        return (!isProcessing && isEmailValid)
    }

    const enableForgotPassword = () => {
        return (!isProcessing && forgotData.userNameOrEmail.length > 0)
    }

    const onSubmit = () => {
        if (enableGetUserName() && !enableForgotPassword()) forgotUserName()
        else if (!enableGetUserName() && enableForgotPassword()) forgotPassword()
    }

    return (
        <ContentContainer onSubmit={onSubmit}>
            <Card>
                <div className='card-heading'>Forgot user name?</div>
                <EmailBox id='emailAddress' dataCol='emailAddress' value={forgotData.emailAddress} placeholder='Email'
                    onChange={updateForgotData} onSubmit={forgotUserName} emailValidity={setIsEmailValid}>
                </EmailBox>
                <Button styleName='primary submit' enabled={!enableGetUserName()}
                    onClick={forgotUserName}>Get User Name</Button>
                <br />
                <div className='card-heading'>Forgot password?</div>
                <TextBox id='userNameOrEmail' dataCol='userNameOrEmail' value={forgotData.userNameOrEmail}
                    placeholder='User Name or Email' onChange={updateForgotData}></TextBox>
                <Button styleName='primary submit' diabled={!enableForgotPassword()}
                    onClick={forgotPassword}>Reset Password</Button>
                <br />
                <NavLink styleName='page-link' onClick={clickSignIn}>Back to Sign In</NavLink>
            </Card>
            {alertMsg ? <Modal buttonText='Close' onClick={closeAlert}>{alertMsg}</Modal> : null}
        </ContentContainer>
    )
}

export default ForgotPassword
