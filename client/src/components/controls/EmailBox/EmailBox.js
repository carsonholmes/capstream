import React, {useState} from 'react'
import './EmailBox.css'
const REGEX_EMAIL = /^[a-z A-Z 0-9 _ \- \\.]+[@][a-z]+\.[a-z]{2,3}$|^$/
// uses styling from TextBox.css

const EmailBox = (props) => {

    const [isEmailValid, setIsEmailValid] = useState(true)
    const [isError, setIsError] = useState(false)
   
    const updateEmail = (event) => {
        var valid = REGEX_EMAIL.test(event.target.value) //validateEmail(event.target.value)
        setIsEmailValid(valid)
        props.emailValidity(valid)
        props.onChange(props.dataCol, event.target.value)
    }

    // const validateEmail = (str) => {
    //     //local-part@domain
    //     const atSymbolPosition = str.indexOf('@')
    //     if (atSymbolPosition === -1) return false  //must contain @ symbol
    //     //const localPart = str.substring(1,atSymbolPosition-1)
    //     const domain = str.substring(atSymbolPosition+1,str.length)
    //     if (domain.length < 4) return false  //domain + dot + extension must be at least 4 characters
    //     const domainPeriodPosition = domain.indexOf('.')
    //     if (domainPeriodPosition===-1) return false //domain must have a dot
    //     const ext = domain.substring(domainPeriodPosition+1,domain.length)  //domain extension string
    //     if (ext.length+1 === domain.length) return false //domain must have at least one character
    //     if (domainPeriodPosition===-1 || ext.length<2) return false //domain and extension must be separated by a dot and extension must be at least two characters
    //     const leftBracketPosition = str.indexOf('[')
    //     const rightBracketPosition = str.indexOf(']')
    //     if (leftBracketPosition!==-1 || rightBracketPosition!==-1) return false
    //     const strArray = str.split('')
    //     const isFirstCharPeriod = (strArray[0]==='.') //first character can not be dot
    //     const isLastTwoCharsPeriod = (strArray[str.length]==='.' && strArray[str.length-1]==='.') //neither of the last two characters can be a dot
    //     if (atSymbolPosition<64 && domain.length<256 && !isFirstCharPeriod && !isLastTwoCharsPeriod) return true   //also check local-part@domain lengths 
  
    //     /* tech debt here: need to add check for single or double quotations inside of local-part, nor does it consider '(comment)' notation 
    //        see https://en.wikipedia.org/wiki/Email_address#Syntax */
    // }

    const checkForError = () => setIsError(!isEmailValid && props.value.length > 0)

    if (props.displayOnly)
        return (
            <div className={props.styleName ? `input-container ${props.styleName}` : 'input-container'}>
                <label htmlFor={props.id} className='display-label email-display-label'>
                    {props.placeholder}</label>
                <label id={props.id} className='display-value email-display-value' onClick={props.onClick}>
                    {props.value}</label>
            </div>
        )
    else return (
        <>
            <div className={props.styleName ? `input-container ${props.styleName}` : 'input-container'}>
                <input className={props.styleName ? `input-element email-box ${props.styleName}` : 
                        'input-element email-box'} type='text' id={props.id} value={props.value}
                    placeholder=' ' onChange={(event)=>updateEmail(event)} onBlur={checkForError}
                    onFocus={()=>setIsError(false)} onClick={props.onClick}>
                </input>
                <label className={isError ? 'input-label error-label' : 'input-label'} htmlFor={props.id}>
                    {props.placeholder}</label>
            </div>
            {isError && <div className='input-error'>{'Email address is not valid.'}</div>}
        </>
     )
}

export default EmailBox