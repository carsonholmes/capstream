import React, { useState } from 'react'
import icons from '../../shared/icons'
import CheckBox from '../controls/CheckBox/CheckBox'
import './NotificationDetails.css'

const NotificationDetails = (props) => {

    const [displayServiceBeingBooked, setDisplayServiceBeingBooked] = useState(false)
    const [displayBookingRequestSubmitted, setDisplayBookingRequestSubmitted] = useState(false)
    const [displayBookingRequestConfirmed, setDisplayBookingRequestConfirmed] = useState(false)
    const [reminderProviderAppt, setReminderProviderAppt] = useState(false)
    const [reminderConsumerAppt, setReminderConsumerAppt] = useState(false)

    const getSettings = (email, text) => {
        let settings = ''
        if (email) settings += 'Email'
        if (email && text) settings += ', '
        if (text) settings += 'Text'
        if (!email && !text) settings = 'No notifications set'
        return settings
    }

    const onChange = (dataCol, value) => {
        props.onChange(dataCol,value)
    }

    return (
        <section className='notification-details-container'>
            <h3 className='notification-subheading'>Notify me about:</h3>
            <div className='notification-type'>My services being booked
                {!displayServiceBeingBooked ?
                    <img className='notification-arrow' src={icons.downBlueIcon} alt='down'
                        onClick={()=>setDisplayServiceBeingBooked(!displayServiceBeingBooked)}/>:
                    <img className='notification-arrow' src={icons.upBlueIcon} alt='up'
                        onClick={()=>setDisplayServiceBeingBooked(!displayServiceBeingBooked)}/>}
            </div>
            <div className='current-notification-settings'>
                {getSettings(props.data.serviceBeingBookedEmail, props.data.serviceBeingBookedText)}
            </div>
            {displayServiceBeingBooked &&
                <div className='notification-checkbox-container'>
                    <CheckBox id='serviceBeingBookedEmail' styleName='notification-checkbox'
                        dataCol={'serviceBeingBookedEmail'} onChange={onChange}
                        checked={props.data.serviceBeingBookedEmail}>Email</CheckBox>
                    <CheckBox id='serviceBeingBookedText' styleName='notification-checkbox'
                        dataCol={'serviceBeingBookedText'} onChange={onChange}
                        checked={props.data.serviceBeingBookedText}>Text</CheckBox></div>}
            <hr className='notification-hr'/>
            <div className='notification-type'>My booking requests being submitted
                {!displayBookingRequestSubmitted ?
                    <img className='notification-arrow' src={icons.downBlueIcon} alt='down'
                        onClick={()=>setDisplayBookingRequestSubmitted(!displayBookingRequestSubmitted)}/>:
                    <img className='notification-arrow' src={icons.upBlueIcon} alt='up'
                        onClick={()=>setDisplayBookingRequestSubmitted(!displayBookingRequestSubmitted)}/>}
            </div>
            <div className='current-notification-settings'>
                {getSettings(props.data.bookingRequestSubmittedEmail, props.data.bookingRequestSubmittedText)}
            </div>
            {displayBookingRequestSubmitted &&
                <div className='notification-checkbox-container'>
                    <CheckBox id='bookingRequestSubmittedEmail' styleName='notification-checkbox'
                        dataCol={'bookingRequestSubmittedEmail'} onChange={onChange}
                        checked={props.data.bookingRequestSubmittedEmail}>Email</CheckBox>
                    <CheckBox id='bookingRequestSubmittedText' styleName='notification-checkbox'
                        dataCol={'bookingRequestSubmittedText'} onChange={onChange}
                        checked={props.data.bookingRequestSubmittedText}>Text</CheckBox></div>}
            <hr className='notification-hr'/>
            <div className='notification-type'>My booking requests being confirmed
                {!displayBookingRequestConfirmed ?
                    <img className='notification-arrow' src={icons.downBlueIcon} alt='down'
                        onClick={()=>setDisplayBookingRequestConfirmed(!displayBookingRequestConfirmed)}/>:
                    <img className='notification-arrow' src={icons.upBlueIcon} alt='up'
                        onClick={()=>setDisplayBookingRequestConfirmed(!displayBookingRequestConfirmed)}/>}
            </div>
            <div className='current-notification-settings'>
                {getSettings(props.data.bookingRequestConfirmedEmail, props.data.bookingRequestConfirmedText)}
            </div>
            {displayBookingRequestConfirmed &&
                <div className='notification-checkbox-container'>
                    <CheckBox id='bookingRequestConfirmedEmail' styleName='notification-checkbox'
                        dataCol={'bookingRequestConfirmedEmail'} onChange={onChange}
                        checked={props.data.bookingRequestConfirmedEmail}>Email</CheckBox>
                    <CheckBox id='bookingRequestConfirmedText' styleName='notification-checkbox'
                        dataCol={'bookingRequestConfirmedText'} onChange={onChange}
                        checked={props.data.bookingRequestConfirmedText}>Text</CheckBox></div>}
            <hr className='notification-hr'/>
            <div className='notification-type'>30-min reminder for my service appointments
            {!reminderProviderAppt ?
                    <img className='notification-arrow' src={icons.downBlueIcon} alt='down'
                        onClick={()=>setReminderProviderAppt(!reminderProviderAppt)}/>:
                    <img className='notification-arrow' src={icons.upBlueIcon} alt='up'
                        onClick={()=>setReminderProviderAppt(!reminderProviderAppt)}/>}
            </div>
            <div className='current-notification-settings'>
                {getSettings(props.data.reminderProviderApptEmail, props.data.reminderProviderApptText)}
            </div>
            {reminderProviderAppt &&
                <div className='notification-checkbox-container'>
                    <CheckBox id='reminderProviderApptEmail' styleName='notification-checkbox'
                        dataCol={'reminderProviderApptEmail'} onChange={onChange}
                        checked={props.data.reminderProviderApptEmail}>Email</CheckBox>
                    <CheckBox id='reminderProviderApptText' styleName='notification-checkbox'
                        dataCol={'reminderProviderApptText'} onChange={onChange}
                        checked={props.data.reminderProviderApptText}>Text</CheckBox></div>}
            <hr className='notification-hr'/>
            <div className='notification-type'>30-min reminder for my appointments
            {!reminderConsumerAppt ?
                    <img className='notification-arrow' src={icons.downBlueIcon} alt='down'
                        onClick={()=>setReminderConsumerAppt(!reminderConsumerAppt)}/>:
                    <img className='notification-arrow' src={icons.upBlueIcon} alt='up'
                        onClick={()=>setReminderConsumerAppt(!reminderConsumerAppt)}/>}
            </div>
            <div className='current-notification-settings'>
                {getSettings(props.data.reminderConsumerApptEmail, props.data.reminderConsumerApptText)}
            </div>
            {reminderConsumerAppt &&
                <div className='notification-checkbox-container'>
                    <CheckBox id='reminderConsumerApptEmail' styleName='notification-checkbox'
                        dataCol={'reminderConsumerApptEmail'} onChange={onChange}
                        checked={props.data.reminderConsumerApptEmail}>Email</CheckBox>
                    <CheckBox id='reminderConsumerApptText' styleName='notification-checkbox'
                        dataCol={'reminderConsumerApptText'} onChange={onChange}
                        checked={props.data.reminderConsumerApptText}>Text</CheckBox></div>}
            <hr className='notification-hr'/>
            <div className='notification-notes'>
                Email notifications will be sent to your primary email address.</div>
            <div className='notification-notes'>Text notifications are coming soon!</div>
        </section>
    )
}

export default NotificationDetails