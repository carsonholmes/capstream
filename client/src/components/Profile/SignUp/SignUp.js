import React, { useState, useRef } from 'react'
import { AppContext } from '../../../AppContext'
import './SignUp.css'
import TextBox from '../../controls/TextBox/TextBox'
import PasswordChecks from '../../controls/PasswordChecks/PasswordChecks'
import NavLink from '../../controls/NavLink/NavLink'
import Card from '../../Card/Card'
import CheckBox from '../../controls/CheckBox/CheckBox'
import Button from '../../controls/buttons/Button'
import ProfileCDO from '../../../cdos/ProfileCDO'
import ContentContainer from '../../ContentContainer/ContentContainer'
import EmailBox from '../../controls/EmailBox/EmailBox'
import Modal from '../../controls/Modal/Modal'
const cdo = new ProfileCDO();

const SignUp = () => {

    const [userData, setUserData] = useState(cdo.getEmptyRow)
    const [isPasswordValid, setIsPasswordValid] = useState(true)
    const [isEnteringUserName, setIsEnteringUserName] = useState(false)
    const [isUserNameValid, setIsUserNameValid] = useState(true)
    const [isUserNameUnique, setIsUserNameUnique] = useState(true)
    const [isTitleEdited, setIsTitleEdited] = useState(false)
    const [isEmailValid, setIsEmailValid] = useState(false)
    const isSubmitInProgress = useRef(false)
    const [isPasswordHidden, setIsPasswordHidden] = useState(true)
    const [displayEULA, setDisplayEULA] = useState(false)
    const { appContext, setAppContext } = React.useContext(AppContext);

    const clickSignIn = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'signIn'
        setAppContext(newContext)
    }

    const updateUser = (dataCol, newValue) => {
        let user = JSON.parse(JSON.stringify(userData))
        user[dataCol] = newValue
        if (dataCol === 'entityTitle') setIsTitleEdited(true)
        if (dataCol === 'personFirstName' && !isTitleEdited) user['entityTitle'] = newValue + ' ' +
            userData.personLastName
        if (dataCol === 'personLastName' && !isTitleEdited) user['entityTitle'] = userData.personFirstName +
            ' ' + newValue
        setUserData(user)
    }

    const registerUser = () => {
        //add all validation here
        if (enableSubmit() && !isSubmitInProgress.current) {
            isSubmitInProgress.current = true
            cdo.addProfile(userData, cbRegisterUser)
        }
    }

    //callback function for addProfile above
    const cbRegisterUser = (error, data) => {
        if (data.response === 'Success') {
            console.table(data)
            let newContext = JSON.parse(JSON.stringify(appContext))
            for (let itemName in data) {
                newContext[itemName] = data[itemName]
            }
            newContext.signedIn = true
            newContext.emailVerified = false
            newContext.idEntity = data.idEntity
            newContext.personFirstName = data.personFirstName
            newContext.personLastName = data.personLastName
            newContext.userName = data.userName
            newContext.emailAddress = data.emailAddress
            newContext.authState = 'verifyEmail'
            setAppContext(newContext);
        }
        else {
            alert('Error ' + error + ' registering user: ' + JSON.stringify(data));
            isSubmitInProgress.current = false
        }
    }

    const checkUserName = () => {
        setIsEnteringUserName(false)

        const uNameCheck = /^[0-9a-zA-Z]+$/
        if (userData.userName.length > 0 && !userData.userName.match(uNameCheck))
            setIsUserNameValid(false)
        else
            setIsUserNameValid(true)

        if (userData.userName && userData.userName.length > 0)
            cdo.validateUserName(userData, cbCheckUserName)
        else
            setIsUserNameUnique(true)
    }

    const cbCheckUserName = (error, data) => {
        if (!error) {
            if (data && data.idEntity) setIsUserNameUnique(false);
            else setIsUserNameUnique(true);
        }
        else {
            alert("Error " + error + " checking on user name uniqueness: " +
                JSON.stringify(data, null, 2));
            setIsUserNameUnique(false);
        }
    }

    const enableSubmit = () => {
        return (
            !isSubmitInProgress.current && userData.userName.length > 0 && userData.userPassword.length > 0 &&
            isPasswordValid && isUserNameUnique && isEmailValid && userData.acceptEULA &&
            (userData.personFirstName.length > 0 || userData.personLastName.length > 0))
    }

    const userNameErrorCheck = () => {
        return (
            (!isUserNameUnique && !isEnteringUserName) || (!isUserNameValid && !isEnteringUserName)
        )
    }

    return (
        <>
            <ContentContainer onSubmit={registerUser}>
                <div className="flex-wrapper-column">
                    <h2 className='segment-header'>Create an Account</h2>
                    <TextBox id='userName' name='new-user-name' dataCol='userName' value={userData.userName} placeholder='User Name'
                        onChange={updateUser} onBlur={checkUserName} onFocus={() => setIsEnteringUserName(true)}
                        onSubmit={registerUser} error={userNameErrorCheck()}></TextBox>
                    {!isUserNameValid && !isEnteringUserName && <div className='input-error'>
                        User names must only include letters and numbers.</div>}
                    {!isUserNameUnique && !isEnteringUserName && <div className='input-error'>
                        That user name is unavailable.</div>}
                    <TextBox id='personFirstName' dataCol='personFirstName' value={userData.personFirstName} placeholder='First Name'
                        onChange={updateUser} onSubmit={registerUser}></TextBox>
                    <TextBox id='personLastName' dataCol='personLastName' value={userData.personLastName} placeholder='Last Name'
                        onChange={updateUser} onSubmit={registerUser}></TextBox>
                    <EmailBox id='emailAddress' dataCol='emailAddress' placeholder='Email Address' value={userData.emailAddress}
                        onChange={updateUser} onSubmit={registerUser} emailValidity={setIsEmailValid}></EmailBox>
                    <PasswordChecks placeholder1='Password' type={isPasswordHidden ? 'password' : 'text'}
                        onChange={updateUser} passwordValidity={setIsPasswordValid} onSubmit={registerUser}></PasswordChecks>
                    <CheckBox id='showPassword' styleName='show-passwords' dataCol='showPassword'
                        onChange={() => setIsPasswordHidden(!isPasswordHidden)} onSubmit={registerUser}>
                        Show passwords</CheckBox>
                    <div className='check-read'>
                        <hr></hr>
                        <CheckBox id='acceptEULA' dataCol='acceptEULA' value={userData.acceptEULA}
                            onChange={updateUser} onSubmit={registerUser}>
                            I agree to the terms and conditions described in the End User Licensing Agreement.
                        </CheckBox>
                        <span className='read-eula' onClick={() => setDisplayEULA(true)}>Read</span>
                    </div>
                    <Button styleName='primary submit' disabled={!enableSubmit()}
                        onClick={registerUser}>Submit</Button>
                </div>
                <div className='flex-wrapper-column'>
                    <div className='card-text'>Already have an account?</div>
                    <NavLink onClick={clickSignIn}>Sign in instead?</NavLink>
                </div>
            </ContentContainer>
            {displayEULA && <Modal buttonText='Close' onClick={() => setDisplayEULA(false)}>
                This will be the text of the End User Licensing Agreement</Modal>}
        </>
    )
}

export default SignUp
