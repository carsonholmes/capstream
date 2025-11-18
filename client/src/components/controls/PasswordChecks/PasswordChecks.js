import React, {useState} from 'react'
import './PasswordChecks.css'
import PasswordBox from '../PasswordBox/PasswordBox'

const PasswordChecks = (props) => {
    const [userPassword, setUserPassword] = useState('')
    const [isEnteringPassword, setIsEnteringPassword] = useState('false')
    const [confirm, setConfirm] = useState('')
    const [areMatching, setAreMatching] = useState(true)
    const [hasOneChar, setHasOneChar] = useState(false)
    const [hasEnoughChars, setHasEnoughChars] = useState(false)
    const [hasUppercase, setHasUppercase] = useState(false)
    const [hasNumber, setHasNumber] = useState(false)

    const updatePassword = (dataCol, newValue) => {
        setUserPassword(newValue)
        let areMatchingFlag = false
        if (confirm.length > 0 && confirm !== newValue) {
            areMatchingFlag = false
        }
        else areMatchingFlag = true
        props.passwordValidity(confirm.length > 0 && hasEnoughChars && hasUppercase && hasNumber && areMatchingFlag)
        props.onChange(dataCol, newValue) //calls updateUser
        setAreMatching(areMatchingFlag)
    }

    const updateConfirm = (dataCol, newValue) => {
        //parameters declared for call from child, but are likely not needed by this function
        let areMatchingFlag = false
        setConfirm(newValue);
        if (newValue.length > 0 && userPassword !== newValue) {
            areMatchingFlag = false
        }
        else areMatchingFlag = true
        props.passwordValidity(newValue.length > 0 && hasEnoughChars && hasUppercase && hasNumber && areMatchingFlag)
        setAreMatching(areMatchingFlag)
    }
  
    const checkPasswordPolicy = (password) => {
        setIsEnteringPassword(false)
        let bHasOneChar, bHasEnoughChars, bHasUppercase, bHasNumber = false
        
        if (password.length > 0) bHasOneChar = true

        if (password.length >= 8) {
            bHasEnoughChars = true
            var passwordArray = password.split('')
            for (var character of passwordArray) {
                if (character >= 'A' && character <='Z') bHasUppercase = true
                if (character >= '0' && character <='9') bHasNumber = true
            }
        }
        props.passwordValidity(confirm.length > 0 && bHasEnoughChars && bHasUppercase && bHasNumber && areMatching)
    
        setHasOneChar(bHasOneChar)
        setHasEnoughChars(bHasEnoughChars)
        setHasUppercase(bHasUppercase)
        setHasNumber(bHasNumber)

    }

   const passwordErrorMessage = () =>{
        if (!hasEnoughChars) return 'The password must include at least 8 characters.'
        if (!hasUppercase) return 'The password must include at least one uppercase letter.'
        if (!hasNumber) return 'The password must include at least one number.'
    }

    const isInvalidPassword = () => {
        return (hasOneChar && !isEnteringPassword && !(hasEnoughChars && hasUppercase && hasNumber))
    }

    return (
        <div className='password-checks-container'>
            <PasswordBox id='userPassword' dataCol='userPassword' value={userPassword} placeholder={props.placeholder1}
                type={props.type} onChange={updatePassword} onSubmit={props.onSubmit}
                onFocus={()=>setIsEnteringPassword(true)} onBlur={checkPasswordPolicy}
                error={isInvalidPassword()}></PasswordBox>
            {isInvalidPassword() ?
                <div className='input-error'>{passwordErrorMessage()}</div>:
                <div className='error-spacer'></div>}
            <div className='input-policy'>Password must include at least 8 characters,<br />
                one number, and one uppercase letter.</div>
            <PasswordBox id='confirm' dataCol='confirm' value={confirm} placeholder='Confirm Password'
                type={props.type} onChange={updateConfirm} onSubmit={props.onSubmit} 
                onBlur={checkPasswordPolicy} error={!areMatching}>
            </PasswordBox>
            {!areMatching && <div className='input-error'>Passwords don't match.</div>}
        </div>
    )
}

export default PasswordChecks