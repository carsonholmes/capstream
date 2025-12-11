import React, { useState, useRef } from 'react'
import { AppContext } from '../../../AppContext'
import ContentContainer from '../../ContentContainer/ContentContainer'
import TextBox from '../../controls/TextBox/TextBox'
import PasswordBox from '../../controls/PasswordBox/PasswordBox'
import NavLink from '../../controls/NavLink/NavLink'
import Card from '../../Card/Card'
import CheckBox from '../../controls/CheckBox/CheckBox'
import Button from '../../controls/buttons/Button'
import ProfileCDO from '../../../cdos/ProfileCDO'
//import CartCDO from '../../../cdos/CartCDO'
import './SignIn.css'

const cdo = new ProfileCDO();
//const cdoCart = new CartCDO();

const SignIn = (props) => {

    const [credentials, setCredentials] = useState({ userNameOrEmail: '', userPassword: '' })
    const [isInvalidCreds, setIsInvalidCreds] = useState(false)
    const [signInInProgress, setSignInInProgress] = useState(false)
    const [isMultipleAccounts, setIsMultipleAccounts] = useState(false)
    const { appContext, setAppContext } = React.useContext(AppContext);
    const newContext = useRef();
    const [isPasswordHidden, setIsPasswordHidden] = useState(true)
    const [isFocused, setIsFocused] = useState(false)

    const updateCredentials = (dataCol, newValue) => {
        let newCreds = JSON.parse(JSON.stringify(credentials))
        newCreds[dataCol] = newValue
        setCredentials(newCreds)
        setIsInvalidCreds(false)
        setIsMultipleAccounts(false)
    }

    const signIn = () => {
        if (enableSubmit() && !signInInProgress) {
            setSignInInProgress(true)
            setIsFocused(false)
            cdo.signIn(credentials, cbSignIn)
        }
    }

    const cbSignIn = (error, data) => {
        if (!error && data.response === 'Success') {
            newContext.current = { ...appContext }
            for (let itemName in data.session) {
                newContext.current[itemName] = data.session[itemName]
            }
            newContext.current.signedIn = true
            newContext.current.authState = 'home'
            setAppContext(newContext.current);
            //cdoCart.loadData({idUser: newContext.current.idEntity, idSession: newContext.current.idSession}, setCartQuantityTotal);
        }
        else {
            if (!error) {
                if (data.response === 'Multiple accounts') setIsMultipleAccounts(true)
                else setIsInvalidCreds(true)
            }
            else alert("Error communicating with web services.")
        }
        setSignInInProgress(false)
    }

    // const setCartQuantityTotal = (error, cartData) => {
    //     let newQuantity = 0
    //     if (!error && cartData && cartData.length > 0) {
    //         for (let i=0; i<cartData.length; i++) {
    //             newQuantity += cartData[i].quantity
    //         }
    //     }
    //     let context = {...newContext.current}
    //     context.cartQuantity = newQuantity
    //     setAppContext(context);
    // }

    const clickForgotPassword = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'forgotPassword'
        setAppContext(newContext)
    }

    const clickSignUp = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'signUp'
        setAppContext(newContext)
    }

    const enableSubmit = () => {
        return (credentials.userNameOrEmail.length > 0 && credentials.userPassword.length > 7 && !signInInProgress)
    }

    return (
        <ContentContainer onSubmit={signIn}>
            <div className='flex-wrapper-column'>
                <h2 className='segment-header'>Sign In</h2>
                <TextBox id='userNameOrEmail' dataCol='userNameOrEmail' placeholder='User Name or Email Address' onFocus={() => setIsFocused(true)}
                    onChange={updateCredentials} onBlur={() => setIsFocused(false)}></TextBox>
                <PasswordBox id='userPassword' dataCol='userPassword' placeholder='Password' onFocus={() => setIsFocused(true)}
                    onBlur={() => setIsFocused(false)} type={isPasswordHidden ? 'password' : 'text'}
                    onChange={updateCredentials}></PasswordBox>
                <CheckBox id='showPassword' styleName='show-password' dataCol='showPassword' onChange={() => setIsPasswordHidden(!isPasswordHidden)}>Show password</CheckBox>
                <Button styleName='primary submit' disabled={!enableSubmit()} onClick={signIn}>Sign In</Button>
                {isInvalidCreds && !isFocused && <div className='input-error error-top-margin'>
                    User name or password is not valid.</div>}
                {isMultipleAccounts && !isFocused && <div className='input-error error-top-margin'>
                    Multiple accounts exist for that email address, please log in with user name</div>}
                <NavLink onClick={clickForgotPassword}>
                    Forgot User Name or Password?</NavLink>
            </div>
            <div className='flex-wrapper-column'>
                <div className='card-text'>Don't have an account?</div>
                <NavLink onClick={clickSignUp}>Sign up</NavLink>
            </div>
        </ContentContainer>
    )
}

export default SignIn