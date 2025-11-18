import React from 'react'
import EmailBox from '../controls/EmailBox/EmailBox'
import Button from '../controls/buttons/Button'
import './EmailDetails.css'

const EmailDetails = (props) => {

    return (
        <div onClick={props.onSelect} className='email-details-container'>
            <EmailBox id={'emailAddress'+props.index} dataCol='emailAddress' placeholder='Email Address'
                value={props.row.emailAddress} onChange={props.onChange} emailValidity={props.setValid}
                displayOnly={!props.isEditing}></EmailBox>
            <div className='email-buttons-container'>
                {props.row.primary ?
                    <div className='email-label'>Primary</div> :
                    <Button styleName='email-change-button primary small'>Make Primary</Button>}
                {props.row.emailVerified ? 
                    <div className='email-label'>Verified</div> :
                    <Button styleName='email-change-button primary small'>Verify Email</Button>}
            </div>
            {/* {props.row.primary ? 
                <div className='email-label'>Primary</div> : ''}
            {props.row.emailVerified ? 
                <div className='email-label'>Verified</div> : ''}
            {!props.row.primary ? 
                <Button styleName='email-change-button'>Make Primary</Button> : ''}
            {!props.row.emailVerified ? 
                <Button styleName='email-change-button'>Verify Email</Button> : ''} */}
            {/* // <CheckBox id={'primary'+props.index} dataCol='primary' checked={props.row.primary} 
            //     onChange={props.onChange} disabled={props.row.primary || !props.isEditing}>
            //     Primary
            // </CheckBox>
            // <CheckBox id={'emailVerified'+props.index} dataCol='emailVerified' checked={props.row.emailVerified} 
            //     disabled={true}>
            //     Verified
            // </CheckBox> */}
        </div>
    )

}

export default EmailDetails
