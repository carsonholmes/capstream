import React, { Fragment, useEffect, useState } from 'react'
import CheckBox from '../controls/CheckBox/CheckBox'
import RadioButtons from '../controls/RadioButtons/RadioButtons'
import Select from '../controls/Select/Select'
import TextBox, { REGEX_NUMBER } from '../controls/TextBox/TextBox'
import {LEAD_TYPES_SINGULAR, LEAD_TYPES_PLURAL} from '../../shared/serviceConstants'
import HelpIcon from '../controls/HelpIcon/HelpIcon'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'

const BookingSettings = (props) => {

    const checkLeadTimes = (property) => {
        if (property > 0) return true
        else return false
    }

    const [bookingLeadTypeOptions, setBookingLeadTypeOptions] = useState(LEAD_TYPES_SINGULAR)
    const [showBookingLeadTime, setShowBookingLeadTime] = useState(checkLeadTimes(props.data.bookingLeadNumber))
    const [deactiveService, setDeactiveService] = useState()

    // determine singular or plural bookingLeadType
    useEffect(() => {
        if (props.data.bookingLeadNumber === 1) setBookingLeadTypeOptions(LEAD_TYPES_SINGULAR)
        else setBookingLeadTypeOptions(LEAD_TYPES_PLURAL)
    }, [props.data.bookingLeadNumber])

    useEffect(()=>{
        if (props.data.offerType) setDeactiveService(0)
        else setDeactiveService(1)
    },[props.data.offerType])

    const updateData = (dataCol, value) => {
        let newOffer = {...props.data}
        if (dataCol === 'offerType') {
            if (value) value = 0
            //setDeactiveService(value)
            else {
                value = 1
                //setDeactiveService(value)
            }
        }
        newOffer[dataCol] = value
        props.updateData(newOffer)
    }
    
    const toggleBookingLeadTime = () => {
        if (showBookingLeadTime) {
            setShowBookingLeadTime(false)
            updateData('bookingLeadNumber', 0)
        }
        else {
            setShowBookingLeadTime(true)
            updateData('bookingLeadNumber', 1)
        }
    }

    return (
        <Card cardHeading='Edit Booking Settings' setRef={props.setRef}
            styleHeading='edit-entity-heading'
            styleName='edit-entity-card'>
            {console.log('offerType: ', props.data.offerType)}
            <Fragment>
                <div className='edit-entity-radios-with-title'>
                    <div className='edit-entity-radio-title'>Confirm booking requests:</div>
                    <RadioButtons styleName='edit-entity-radios'
                        data={[{caption: 'Manually', value: 0,
                            help: 'You will be notified of any booking requests, at which point you may confirm or decline them.'},
                            {caption: 'Automatically', value: 1,
                            help: 'Booking requests will be automatically confirmed, and you will be notified of the booking.' }]} 
                        dataCol='confirmMethod' 
                        value={props.data.confirmMethod}
                        onChange={updateData}
                        name='confirmMethod'></RadioButtons>
                </div>
                <div className='edit-entity-container'>
                    <HelpIcon styleName='edit-entity-help booking-lead-help'>
                        Your customer must book with at least this much notice before the appointment starts.
                    </HelpIcon>
                    <div className='lead-time-container'>
                        <CheckBox id='bookingLeadCheckbox' styleName='booking-lead-checkbox'
                            checked={showBookingLeadTime} onChange={toggleBookingLeadTime}>
                            Require booking lead time</CheckBox>
                        {showBookingLeadTime &&
                            <div className='lead-num-and-type'>
                                <TextBox id='bookingLeadNumber' placeholder='Number' onChange={updateData}
                                    type='number' dataCol='bookingLeadNumber' regex={REGEX_NUMBER}
                                    value={props.data.bookingLeadNumber} emptyError='Please enter a number.'
                                    styleName='edit-entity-textbox'></TextBox>
                                <Select id='bookingLeadType' data={bookingLeadTypeOptions} label='Time Frame'
                                        value={props.data.bookingLeadType} dataCol='bookingLeadType'
                                        onChange={updateData} styleName='edit-entity edit-entity-lead-type'
                                        optionsStyle='edit-entity'
                                        containerStyle='edit-entity-options-container'></Select>
                            </div>}
                    </div>
                    <HelpIcon styleName='edit-entity-help'>
                        Please indicate how many customers you can serve during one appointment.
                    </HelpIcon>
                    <TextBox id='quantity' placeholder='Customers per Time Block' dataCol='quantity'
                        value={props.data.quantity} onChange={updateData} regex={REGEX_NUMBER}
                        emptyError='Please enter a number.' containerStyle='booking-settings-quantity'
                        styleName='edit-entity-textbox booking-settings-quantity'
                        type='number'></TextBox>
                </div>
                <div className='deactivate-container'>
                    <CheckBox id='offerType' dataCol='offerType'
                        checked={deactiveService} onChange={updateData}
                        styleName='edit-entity-checkbox deactivate-checkbox'>
                        Deactivate this service</CheckBox>
                    <HelpIcon styleName='edit-entity-help deactivate-help'>
                        Your service will not be visible to other users, and will not appear in any search results.
                    </HelpIcon>
                </div>
            </Fragment>
            <br />
            <IconButton styleName={'primary medium-small'}
                src={icons.saveIcon}
                onClick={props.saveData} caption='Save'>
            </IconButton>
            <IconButton styleName={'primary medium-small'}
                src={icons.closeIcon}
                onClick={props.handleClose} caption='Close'>
            </IconButton>
        </Card>
    )
}

export default BookingSettings