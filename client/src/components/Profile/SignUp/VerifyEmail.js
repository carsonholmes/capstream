import React, {useState} from 'react'
import {AppContext} from '../../../AppContext'
import SignIn from '../SignIn/SignIn'
import TextBox from '../../controls/TextBox/TextBox'
import Button from '../../controls/buttons/Button'
import NavLink from '../../controls/NavLink/NavLink'
import Card from '../../Card/Card'
import ContentContainer from '../../ContentContainer/ContentContainer'
import ProfileCDO from '../../../cdos/ProfileCDO'
const cdo = new ProfileCDO()

const VerifyEmail = (props) => {
    
    const [didCodeFail, setDidCodeFail] = useState(false)
    const [emailVerifyCode, setEmailVerifyCode] = useState('')
    const [isSixNums, setIsSixNums] = useState(false)
    const {appContext, setAppContext} = React.useContext(AppContext)
    
    const updateVerifyCode = (id, newValue) => {
        setEmailVerifyCode(newValue)
        setDidCodeFail(false)
        var isSixNumsFlag = false
        if (newValue.length === 6 && !isNaN(newValue)) isSixNumsFlag=true
        setIsSixNums(isSixNumsFlag)
    }

    const verifyEmail = () => {
        cdo.verifyEmail({idEntity: appContext.idEntity, 
            emailAddress: appContext.emailAddress, 
            emailVerifyCode: emailVerifyCode},
            cbVerifyEmail)
    }

    const cbVerifyEmail = (error, data) => {
        if (!error) {
            if (data.response ==='Verified') {
                let newContext = JSON.parse(JSON.stringify(appContext))
                newContext.emailVerified = true
                newContext.authState = 'home'
                setAppContext(newContext)
            }
            else {
                setDidCodeFail(true)
            }
        }
        else {
            alert('Error ' + data.error.errno + ' verifying code for email: ' + data.error.code + ' - ' + data.error.sqlMessage);
            setDidCodeFail(true)
        }
    }

    const resendEmail = () => {
        cdo.resendEmail(appContext, cbResendEmail)
    }

    const cbResendEmail = (error, data) => {
        if (!error && data.response === 'Success') {
            alert("Resent email")
        }
        else {
            console.table( data.error )
            alert('Error ' + data.error.errno + ' generating new verify code for email: ' + data.error.code + ' - ' + data.error.sqlMessage);
        }
    }

    if (appContext.idEntity === null || appContext.idSession === null) return <SignIn></SignIn>
    if (appContext.emailVerified) window.location.href = './profile'
    else return (
        <ContentContainer onSubmit={verifyEmail}>
            <Card>
                <label className='bold-text'>You have successfully registered.</label> <br/><br/>
                Please check your email <label className='bold-text'>{appContext.emailAddress  || 'CONTEXT-ERROR'}</label>
                to validate the address.<br/><br/>Enter the 6-digit code from your email:
                <TextBox id='emailVerifyCode' dataCol='emailVerifyCode' value={emailVerifyCode} placeholder='Verify Code'
                    onChange={updateVerifyCode}></TextBox>
                {didCodeFail && <div className='input-error'>Invalid code entered.</div>}
                <Button styleName='primary submit' disabled={!isSixNums}
                    onClick={verifyEmail}>Submit</Button>
                <br />
                <NavLink styleName='page-link' onClick={resendEmail}>Resend verification email?</NavLink>
                <NavLink styleName='page-link' to='./profile'>Wrong email address?</NavLink>
            </Card>
        </ContentContainer>
    )
}

export default VerifyEmail
