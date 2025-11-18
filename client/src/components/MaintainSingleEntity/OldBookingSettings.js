import React, { Fragment, useEffect, useState } from 'react'
import Card from '../Card/Card'
import CheckBox from '../controls/CheckBox/CheckBox'
import Select from '../controls/Select/Select'
import HelpIcon from '../controls/HelpIcon/HelpIcon'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
import RadioButtons from '../controls/RadioButtons/RadioButtons'
import './BookingSettings.css'
import TextBox, { REGEX_NUMBER, REGEX_PERCENT } from '../controls/TextBox/TextBox'
import {START_TIME_OPTIONS, TIME_BLOCK_OPTIONS, LEAD_TYPES_SINGULAR, LEAD_TYPES_PLURAL, valueIndex} from '../../shared/serviceConstants'
// uses styling from MaintainSingleEntity.css


const BookingSettings = (props) => {

    const checkLeadTimes = (property) => {
        if (property > 0) return true
        else return false
    }
    
    const [bookingLeadTypeOptions, setBookingLeadTypeOptions] = useState(LEAD_TYPES_SINGULAR)
    const [cancelLeadTypeOptions, setCancelLeadTypeOptions] = useState(LEAD_TYPES_PLURAL)
    const [showBookingLeadTime, setShowBookingLeadTime] = useState(checkLeadTimes(props.data.bookingLeadNumber))
    const [showCancelLeadTime, setShowCancelLeadTime] = useState(checkLeadTimes(props.data.cancelLeadNumber))

    // determine singular or plural bookingLeadType
    useEffect(() => {
        if (props.data.bookingLeadNumber === 1) setBookingLeadTypeOptions(LEAD_TYPES_SINGULAR)
        else setBookingLeadTypeOptions(LEAD_TYPES_PLURAL)
    }, [props.data.bookingLeadNumber])
    
    // determine singular or plural cancelLeadType
    useEffect(() => {
        if (props.data.cancelLeadNumber === 1) setCancelLeadTypeOptions(LEAD_TYPES_SINGULAR)
        else setCancelLeadTypeOptions(LEAD_TYPES_PLURAL)
    }, [props.data.cancelLeadNumber])
    
    const updateData = (dataCol, value) => {
        let newOffer = {...props.data}
        newOffer[dataCol] = value
        props.updateOffer(newOffer)
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

    const toggleCancelLeadTime = () => {
        if (showCancelLeadTime) {
            setShowCancelLeadTime(false)
            updateData('cancelLeadNumber', 0)
        }
        else {
            setShowCancelLeadTime(true)
            updateData('cancelLeadNumber', 1)
        }
    }

    const limitBasedOnMin = () => {
        return [TIME_BLOCK_OPTIONS[0]].concat(TIME_BLOCK_OPTIONS.slice(valueIndex(TIME_BLOCK_OPTIONS, props.data.minTimeIncrement)))
    }

    return (
        <Card>
            <div className='button-container'>
            <IconButton styleName='save-button' caption={props.idEntity ? 'Save' : 'Done'} 
                    disabled={!props.dirty}
                    src={props.idEntity ? icons.saveIcon : icons.checkIcon} onClick={props.saveOffer}></IconButton>
                <IconButton styleName={(props.dirty ? 'cancel-button' : 'edit-button')} 
                    caption={(props.dirty ? 'Cancel' : 'Close')} src={icons.closeIcon}
                    onClick={props.cancelOffer}></IconButton>
            </div>
            <br />
            <CheckBox id='offerType' dataCol='offerType' onChange={updateData}
                styleName='offer-checkbox' checked={props.data.offerType}>
                Offer this service to other users
            </CheckBox><br/>
            {(props.data.offerType===true || props.data.offerType===1) &&
               <div className='booking-settings-container'>
                    <Fragment>
                        <div className='booking-settings-radio-title'>Confirm appointment requests:</div>
                        <RadioButtons styleName='booking-settings-radios'
                            data={[{caption: 'Manually', value: 0},
                                    {caption: 'Automatically', value: 1 }]} 
                            dataCol='confirmMethod' 
                            value={props.data.confirmMethod}
                            onChange={updateData}
                            name='confirmMethod'></RadioButtons>
                    </Fragment>
                    <HelpIcon styleName='booking-settings-help'>
                        This is the shortest duration someone can book this service.</HelpIcon>
                    <Select id='minTimeIncrement' data={TIME_BLOCK_OPTIONS.slice(1)} label='Minimum Time Block'
                            value={props.data.minTimeIncrement} dataCol='minTimeIncrement'
                            onChange={updateData} styleName='booking-settings'
                            optionsStyle='booking-settings' containerStyle='booking-options-container'>
                    </Select>
                    <HelpIcon styleName='booking-settings-help'>
                        This is the longest duration someone can book this service.</HelpIcon>
                    <Select id='maxTimeIncrement' data={limitBasedOnMin()} label='Maximum Time Block'
                            value={props.data.maxTimeIncrement} dataCol='maxTimeIncrement'
                            onChange={updateData} styleName='booking-settings'
                            optionsStyle='booking-settings' containerStyle='booking-options-container'>
                    </Select>
                    <HelpIcon styleName='booking-settings-help'>
                        Choose when customers can begin their appointments.</HelpIcon>
                    <Select id='startTimeIncrement' data={START_TIME_OPTIONS} label='Start Time Options'
                            value={props.data.startTimeIncrement} dataCol='startTimeIncrement'
                            onChange={updateData} styleName='booking-settings'
                            optionsStyle='booking-settings' containerStyle='booking-options-container'>
                    </Select>
                    <HelpIcon styleName='booking-settings-lead-time-help'>
                        Your customer must book with at least this much notice before the appointment starts.
                    </HelpIcon>
                    <h3 className='matching-label'>&nbsp;Booking Lead Time&nbsp;</h3>
                    <div className='lead-time-container'>
                        <CheckBox id='bookingLeadCheckbox' styleName='lead-checkbox'
                            checked={showBookingLeadTime} onChange={toggleBookingLeadTime}>
                            Require booking lead time</CheckBox>
                        {showBookingLeadTime &&
                            <div className='lead-num-and-type'>
                                <TextBox id='bookingLeadNumber' placeholder='Number' onChange={updateData}
                                    type='number' dataCol='bookingLeadNumber' regex={REGEX_NUMBER}
                                    value={props.data.bookingLeadNumber} emptyError='Please enter a number.'
                                    styleName='booking-settings-textbox'></TextBox>
                                <Select id='bookingLeadType' data={bookingLeadTypeOptions} label='Time Frame'
                                        value={props.data.bookingLeadType} dataCol='bookingLeadType'
                                        onChange={updateData} styleName='booking-settings booking-lead-type'
                                        optionsStyle='booking-settings'
                                        containerStyle='booking-options-container'></Select>
                            </div>}
                    </div>
                    <HelpIcon styleName='booking-settings-lead-time-help'>
                        Your customer must cancel with at least this much notice before the appointment starts.
                    </HelpIcon>
                    <h3 className='matching-label'>&nbsp;Cancelation Lead Time&nbsp;</h3>
                    <div className='lead-time-container'>
                        <CheckBox id='cancelLeadCheckbox' styleName='lead-checkbox'
                            checked={showCancelLeadTime} onChange={toggleCancelLeadTime}>
                            Require cancellation lead time</CheckBox>
                        {showCancelLeadTime &&
                            <Fragment>
                                <div className='lead-num-and-type'>
                                    <TextBox id='cancelLeadNumber' placeholder='Number' onChange={updateData}
                                        value={props.data.cancelLeadNumber} dataCol='cancelLeadNumber'
                                        type='number' emptyError='Please enter a number.' regex={REGEX_NUMBER}
                                        styleName='booking-settings-textbox'></TextBox>
                                    <Select id='cancelLeadType' data={cancelLeadTypeOptions} label='Time Frame'
                                            value={props.data.cancelLeadType} dataCol='cancelLeadType'
                                            onChange={updateData} styleName='booking-settings booking-lead-type'
                                            optionsStyle='booking-settings'
                                            containerStyle='booking-options-container'>
                                    </Select>
                                </div>
                                <HelpIcon styleName='booking-settings-cancel-fee-help'>
                                    Your cancellation fee will be a percentage of the total price of the booked 
                                        appointment.
                                </HelpIcon>
                                <TextBox id='cancelFee' placeholder='Cancellation Fee Percent'
                                    value={props.data.cancelFee} dataCol='cancelFee'
                                    containerStyle='cancel-fee' type='number'
                                    onChange={updateData} regex={REGEX_PERCENT}
                                    emptyError='Please enter a percentage.'
                                    styleName='booking-settings-textbox'></TextBox>
                            </Fragment>}
                    </div>
                    <HelpIcon styleName='booking-settings-help'>
                        Please indicate how many customers you can serve during one appointment.
                    </HelpIcon>
                    <TextBox id='quantity' placeholder='Customers per Time Block' dataCol='quantity'
                        value={props.data.quantity} onChange={updateData}regex={REGEX_NUMBER}
                        emptyError='Please enter a number.' containerStyle='booking-settings-quantity'
                        styleName='booking-settings-textbox booking-settings-quantity'></TextBox>
                </div>
            }
        </Card>
    )
}

export default BookingSettings