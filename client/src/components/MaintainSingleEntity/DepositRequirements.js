import React, { Fragment, useState } from 'react'
import TextBox, { REGEX_CURRENCY, REGEX_PERCENT } from '../controls/TextBox/TextBox'
import RadioButtons from '../controls/RadioButtons/RadioButtons'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'

const DepositRequirements = (props) => {

	const getDepositDueOptions = () => {
		if (props.cancelPolicyOn) return (
			[{caption: 'No', value: 0},
			{caption: 'Upon booking', value: 1},
			{caption: 'Prior to cancellation lead-time', value: 2},
			{caption: 'Prior to rendering the service', value: 3}])
		else return (
			[{caption: 'No', value: 0},
			{caption: 'Upon booking', value: 1},
			{caption: 'Prior to rendering the service', value: 3}])
	}

	const [depositDueOptions] = useState(() => getDepositDueOptions)

	const updateData = (dataCol, value) => {
        let newOffer = {...props.data}
        newOffer[dataCol] = value
        props.updateData(newOffer)
    }

	return (
		<Card cardHeading='Edit Deposit Requirements' setRef={props.setRef}
			styleHeading='edit-entity-heading'
			styleName='edit-entity-card'>
			<div className='edit-entity-radios-with-title'>
				<div className='edit-entity-radio-title'>Require a deposit?</div>
				<RadioButtons styleName='edit-entity-radios deposit-radios'
					data={depositDueOptions()} 
					dataCol='depositRequired' 
					value={props.data.depositRequired}
					onChange={updateData}
					name='depositRequired'></RadioButtons>
			</div>
			{props.data.depositRequired > 0 &&
				<Fragment>
					<div className='edit-entity-radios-with-title'>
						<div className='edit-entity-radio-title'>Select the deposit type:</div>
						<RadioButtons styleName='edit-entity-radios'
						data={[{caption: 'Flat fee', value: 0},
								{caption: 'Percentage of service fee', value: 1}]} 
						dataCol='depositAmountType'
						value={props.data.depositAmountType}
						onChange={updateData}
						name='depositAmountType'></RadioButtons>
					</div>
					<TextBox placeholder={props.data.depositAmountType === 0 ? 'Deposit Amount' : 'Deposit Percentage'}
						id='depositAmount' dataCol='depositAmount'
						value={props.data.depositAmount} type='number'
						onChange={updateData} name='depositAmount'
						regex={props.data.depositAmountType === 0 ? REGEX_CURRENCY : REGEX_PERCENT}
						emptyError='Please enter a number.'
						containerStyle='edit-entity-fee-percent'>
					</TextBox>
					{console.log(props.data.depositAmountType, props.data.depositAmount)}
					<p className='edit-entity-explanation'
						style={{display: props.data.depositAmountType === 1
							&& props.data.depositAmount === 100 ? 'none' : 'block'}}>
						The balance of the payment will be due after the service is rendered.
					</p>
				</Fragment>
			}
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

export default DepositRequirements