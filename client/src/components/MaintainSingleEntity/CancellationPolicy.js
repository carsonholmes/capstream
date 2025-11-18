import React, { Fragment, useEffect, useState } from 'react'
import TextBox, { REGEX_CURRENCY, REGEX_NUMBER, REGEX_PERCENT } from '../controls/TextBox/TextBox'
import Select from '../controls/Select/Select'
import CheckBox from '../controls/CheckBox/CheckBox'
import RadioButtons from '../controls/RadioButtons/RadioButtons'
import {LEAD_TYPES_SINGULAR, LEAD_TYPES_PLURAL} from '../../shared/serviceConstants'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'

const CancellationPolicy = (props) => {

    const [cancelLeadTypeOptions, setCancelLeadTypeOptions] = useState(LEAD_TYPES_PLURAL)

	// determine singular or plural cancelLeadType
	useEffect(() => {
		if (props.data.cancelLeadNumber === 1) setCancelLeadTypeOptions(LEAD_TYPES_SINGULAR)
		else setCancelLeadTypeOptions(LEAD_TYPES_PLURAL)
	}, [props.data])

	const updateData = (dataCol, value) => {
        let newOffer = {...props.data}
        newOffer[dataCol] = value
        props.updateData(newOffer)
    }

	return (
		<Card cardHeading='Edit Cancellation Policy' setRef={props.setRef}
			styleHeading='edit-entity-heading'
			styleName='edit-entity-card'> {console.log('props.data: ', props.data)}
			<CheckBox id='cancelPolicyOn' checked={props.data.cancelPolicyOn}
				dataCol='cancelPolicyOn' onChange={updateData}
				styleName='edit-entity-checkbox'>
				Include a cancellation policy</CheckBox>
			{(props.data.cancelPolicyOn === true || props.data.cancelPolicyOn === 1) &&
				<Fragment>
					<RadioButtons styleName='edit-entity-radios'
						data={[{caption: 'Flat fee', value: 0},
								{caption: 'Percentage', value: 1,
									help: 'Your cancellation fee will be a percentage of the total price of the booked appointment.'}]} 
						dataCol='cancelFeeType'
						value={props.data.cancelFeeType}
						onChange={updateData}
						name='cancelFeeType'></RadioButtons>
					<TextBox placeholder={props.data.cancelFeeType === 0 ? 'Fee Amount' : 'Fee Percentage'}
						id='cancelFee' dataCol='cancelFee' containerStyle='edit-entity-fee-percent'
						value={props.data.cancelFee} type='number'
						regex={props.data.cancelFeeType === 0 ? REGEX_CURRENCY : REGEX_PERCENT}
						onChange={updateData} name='cancelFee'
						emptyError={`Please enter ${props.data.cancelFeeType === 0 ? 'an amount' : 'a percentage'}.`}>
					</TextBox>
					<br />
					<h3 className='edit-entity-sub-section'>Cancellation Lead Time:</h3>
					<p className='edit-entity-explanation'>
					To avoid the cancellation fee, your customer must cancel with at least this much notice before the appointment starts.
					</p>
					<div className='lead-num-and-type'>
						<TextBox id='cancelLeadNumber' placeholder='Number' onChange={updateData}
							value={props.data.cancelLeadNumber} dataCol='cancelLeadNumber'
							type='number' emptyError='Please enter a number.' regex={REGEX_NUMBER}
							styleName='edit-entity-textbox'></TextBox>
						<Select id='cancelLeadType' data={cancelLeadTypeOptions} label='Time Frame'
								value={props.data.cancelLeadType} dataCol='cancelLeadType'
								onChange={updateData} styleName='edit-entity edit-entity-lead-type'
								optionsStyle='edit-entity'
								containerStyle='edit-entity-options-container'>
						</Select>
					</div>
				</Fragment>
			}
			<br /><br />
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

export default CancellationPolicy