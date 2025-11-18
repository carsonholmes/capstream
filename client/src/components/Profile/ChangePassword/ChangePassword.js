import React, {useState, useContext} from 'react'
import {AppContext} from '../../../AppContext'
import AuthFrame from '../../AuthFrame/AuthFrame'
import Card from '../../Card/Card'
import Button from '../../controls/buttons/Button'
import NavLink from '../../controls/NavLink/NavLink'
import PasswordBox from '../../controls/PasswordBox/PasswordBox'
import PasswordChecks from '../../controls/PasswordChecks/PasswordChecks'
import CheckBox from '../../controls/CheckBox/CheckBox'
import Modal from '../../controls/Modal/Modal'
import ContentContainer from '../../ContentContainer/ContentContainer'
import ProfileCDO from '../../../cdos/ProfileCDO'
const cdo = new ProfileCDO();

const ChangePassword = (props) => {

    const {appContext} = useContext(AppContext)
    const [passwordData, setPasswordData] = useState({currentPassword: '', userPassword: '', idEntity: appContext.idEntity})
    const [isPasswordValid, setIsPasswordValid] = useState(false)
    const [isPasswordHidden, setIsPasswordHidden] = useState(true)
    const [isProcessing, setIsProcessing] = useState(false)
    const [alertMsg, setAlertMsg] = useState(null)
    
    const updatePasswordData = (dataCol, newValue) => {
        let password = JSON.parse(JSON.stringify(passwordData))
        password[dataCol] = newValue
        setPasswordData(password)
    }
    
    const changePassword = () => {
        if (enableSubmit()) {
            setIsProcessing(true)
            cdo.changePassword( passwordData, cbChangePassword )
        }
    }

    const cbChangePassword = (error, data) => {
        if (error) {
            setAlertMsg('Error processing request.  Please try again later.')
            setIsProcessing(false)
        }
        else {
            if (data.response === 'Success') {
                setAlertMsg('You have successfully reset your password.')
            }
            else {
                setAlertMsg(data.response)
                setIsProcessing(false)
            }
        }
    }

    const closeAlert = () => {
        setAlertMsg(null)
        if (isProcessing) window.location.href = '/'
    }

    const enableSubmit = () => {
        return (!isProcessing && passwordData.currentPassword.length > 7 && isPasswordValid)
    }

    return (
        <AuthFrame>
             <ContentContainer onSubmit={changePassword}>
                <Card>
                    <div className='card-heading'>Change Password</div>
                    <PasswordBox id='currentPassword' dataCol='currentPassword' placeholder='Current Password'
                        onChange={updatePasswordData} type={isPasswordHidden ? 'password' : 'text'}>
                    </PasswordBox>
                    <PasswordChecks id='userPassword' dataCol='userPassword' placeholder1='New Password'
                        type={isPasswordHidden ? 'password' : 'text'} onChange={updatePasswordData}
                        passwordValidity={setIsPasswordValid}></PasswordChecks>
                    <CheckBox id='showPassword' dataCol='showPassword' onChange={()=>setIsPasswordHidden(!isPasswordHidden)}>
                        Show passwords</CheckBox>
                    <Button disabled={!enableSubmit()} styleName={'primary submit'}  
                        onClick={changePassword}>Submit</Button>
                    <NavLink to='/profile'>Back to Profile</NavLink>
                </Card>
                {alertMsg ? <Modal buttonText='Close' onClick={closeAlert}>{alertMsg}</Modal> : null}
            </ContentContainer>
        </AuthFrame>
    )
}

export default ChangePassword