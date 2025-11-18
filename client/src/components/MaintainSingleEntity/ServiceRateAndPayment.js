import React, { Fragment, useEffect, useState } from 'react'
import RadioButtons from '../controls/RadioButtons/RadioButtons'
import TextBox, { REGEX_CURRENCY } from '../controls/TextBox/TextBox'
import Select from '../controls/Select/Select'
import CheckBox from '../controls/CheckBox/CheckBox'
import { RATE_TIME_FRAMES } from '../../shared/serviceConstants'
import { FEATURE_NEGOTIABLE } from '../../shared/featureFlags'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
// uses styling from MaintainSingleEntity.css

const ServiceRateAndPayment = (props) => {

    const [enableRateInputs, setEnableRateInputs] = useState(true)
    const [enablePreferredRate, setEnablePrefferedRate] = useState(false)
    const [rateSetType, setRateSetType] = useState(0)

    // useEffect(() => {
    //     window.scroll({
    //         top: window.scrollY + refCard.current.getBoundingClientRect().top - 160,
    //         behavior: 'smooth'
    //         })
    // }, [])
    
    
    useEffect(() => {
        if (props.data.negotiable) {
            setRateSetType(1)
            if (props.data.price > 0) setEnablePrefferedRate(true)
            else setEnableRateInputs(false)
        }
        else {
            if (props.data.price > 0) setRateSetType(0)
            else {
                if (props.data.rateSetType === 2) {
                    setRateSetType(2)
                    setEnableRateInputs(false)
                }
            }
        }
    }, [props.data, props.data.idOffer, props.data.rateSetType])    

    const updateData = (dataCol, value) => {
        var newData = {...props.data}
        newData[dataCol] = value
        props.updateData(newData)
    }

    const updateRateSetType = (dataCol, value) => {
        var newData = {...props.data}
        newData.rateSetType = value
        setRateSetType(value)
        if (value === 0) { // Set Your Rate selected
            newData.negotiable = false
            setEnableRateInputs(true)
        }
        else if (value === 1) { // Negotiable selected
            newData.negotiable = true
            if (newData.price > 0) {
                setEnablePrefferedRate(true)
                setEnableRateInputs(true)
            }
            else {
                setEnablePrefferedRate(false)
                setEnableRateInputs(false)
            }
        }
        else { // Free selected
            newData.negotiable = false
            newData.price = 0
            newData.rateType = 0 // Flat Rate
            newData.handlePayment = 0
            setEnableRateInputs(false)
        }
        props.updateData(newData)
    }

    const updatePreferredRate = () => {
        if (enablePreferredRate) updateData('price', 0)
        setEnableRateInputs(!enablePreferredRate)
        setEnablePrefferedRate(!enablePreferredRate)
    }
    
    return (
        <Card cardHeading={`${props.action} Service`} styleHeading='edit-entity-heading'
            styleName='edit-entity-card' setRef={props.setRef}>
            <p className='edit-entity-explanation'>
                Please set the rate for your service.</p>
            <h2 className='matching-label'>&nbsp;Rate&nbsp;</h2>
            <div className='rate-info'>
                <div className='rate-radios-container'>
                    {FEATURE_NEGOTIABLE ?
                        <RadioButtons data={[
                            {caption: 'Set Your Rate', value: 0},
                            {caption: 'Negotiable', value: 1},
                            {caption: 'Free', value: 2}]}
                            styleName='rate-radios' dataCol='rateSetType'
                            value={rateSetType} onChange={updateRateSetType}
                            name='rateRadios'></RadioButtons> :
                        <RadioButtons data={[
                            {caption: 'Set Your Rate', value: 0},
                            {caption: 'Free', value: 2}]}
                            styleName='rate-radios' dataCol='rateSetType'
                            value={rateSetType} onChange={updateRateSetType}
                            name='rateRadios'></RadioButtons>}
                </div>
                {rateSetType === 1 &&
                    <CheckBox id='preferredRate' checked={enablePreferredRate} onChange={updatePreferredRate}>
                    Set a preferred rate</CheckBox>}
                <div className='rate-inputs'>
                    <TextBox id='rate-dollars' value={props.data.price}
                        onChange={updateData}
                        placeholder='Dollar Amount' containerStyle='rate-dollars' 
                        styleName='rate-dollars' dataCol='price' disabled={!enableRateInputs}
                        regex={REGEX_CURRENCY} emptyError='Please enter a dollar amount.'>
                    </TextBox>
                    <Select id='rate-time-frame' value={props.data.rateType}
                        onChange={updateData} label='Time Frame' disabled={!enableRateInputs}
                        data={RATE_TIME_FRAMES} containerStyle='rate-time-frame'
                        optionsStyle='rate-time-frame' styleName='rate-time-frame'
                        dataCol='rateType'></Select>
                </div>
            </div>
            <p className={rateSetType !== 2 ? 'edit-entity-explanation' :
                'edit-entity-explanation edit-entity-explanation-disabled'}>
                Would you like FairHub to handle the payments for this service?
            </p>
            {rateSetType !== 2 ?
                <RadioButtons value={props.data.handlePayment} name='handlePayment'
                    id='handlePayment'
                    styleName='handle-payment-radios'
                    data={[{caption: 'Yes, please', value: 1},
                            {caption: 'No, thanks', value: 0}]}
                    onChange={updateData}
                    dataCol='handlePayment'>
                </RadioButtons> :
                <RadioButtons value={0} id='handlePayment'
                    styleName='handle-payment-radios handle-payment-radios-disabled'
                    data={[{caption: 'Yes, please', value: 1},
                            {caption: 'No, thanks', value: 0}]}>
                </RadioButtons>}
            <br />
            {props.action === 'Create' ?
            <Fragment>
                <IconButton styleName='primary medium-small' 
                    src={icons.previousIcon}
                    onClick={props.handleBack} caption='Back'>
                </IconButton>
                <IconButton styleName='primary medium-small' 
                    src={icons.nextIcon}
                    onClick={props.handleNext} caption='Next'>
                </IconButton>
                <IconButton styleName='primary medium-small'
                    src={icons.saveIcon} onClick={props.validateSave}
                    caption='Save'>
                </IconButton>
            </Fragment> :
            <Fragment> {/* action = Edit */}
                <IconButton styleName='primary medium-small'
                    src={icons.saveIcon}
                    onClick={()=>props.saveData()} caption='Save'>
                </IconButton>
                <IconButton styleName='primary medium-small'
                    src={icons.closeIcon}
                    onClick={props.handleClose} caption='Close'>
                </IconButton>
            </Fragment>}
        </Card>
  )
}

export default ServiceRateAndPayment

      /* <div className='service-checkboxes'>
            <div className='checkbox-title'>Delivered:</div>
            <div className='checkbox-and-icon'>
                <CheckBox id='deliveredInPerson' dataCol='deliveredInPerson'
                    checked={props.data.deliveredInPerson} onChange={updateData}
                    styleName='service-checkbox'>In-Person
                </CheckBox>
                <HelpIcon>By selecting this, your service will appear in local search 
                    results.
                </HelpIcon>
            </div>
            <div className='checkbox-and-icon'>
                <CheckBox id='deliveredOnline' dataCol='deliveredOnline'
                    checked={props.data.deliveredOnline} onChange={updateData}
                    styleName='service-checkbox'>Online
                </CheckBox>
                <HelpIcon>By selecting this, your service will not be limited by local 
                    search results.
                </HelpIcon>
            </div>
        </div>
        <div className='service-checkboxes'> 
            <div className='checkbox-title'>Scheduled:</div>
            <div className='checkbox-and-icon'>
                <CheckBox id='scheduledOnDemand' dataCol='scheduledOnDemand'
                    checked={props.data.scheduledOnDemand} onChange={updateData}
                    styleName='service-checkbox'>On-Demand
                </CheckBox>
                <HelpIcon>By selecting this, clients can procure your service when you 
                    are online and available.
                </HelpIcon>
            </div>
            <div className='checkbox-and-icon'>
                <CheckBox id='scheduledByAppointment' dataCol='scheduledByAppointment'
                    checked={props.data.scheduledByAppointment} onChange={updateData}
                    styleName='service-checkbox'>By Appointment
                </CheckBox>
                <HelpIcon>By selecting this, clients can reserve specific times based on your 
                    calendar availability.
                </HelpIcon>
            </div>
        </div>
        {props.data.scheduledByAppointment &&
            <Fragment>
                <div className='checkbox-title'>Confirm appointment requests:</div>
                <RadioButtons styleName='maintain-single-radios'
                    data={[{caption: 'Manually', value: true},
                            {caption: 'Automatically', value: false }]} 
                    dataCol = 'confirmMethod' 
                    value={props.data.confirmMethod}
                    onChange={updateData}
                    name='confirmMethod'></RadioButtons>
            </Fragment>} */