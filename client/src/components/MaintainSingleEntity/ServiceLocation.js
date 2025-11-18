import React, { Fragment } from 'react'
import icons from '../../shared/icons'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import RadioButtons from '../controls/RadioButtons/RadioButtons'
import TextBox, { REGEX_NUMBER } from '../controls/TextBox/TextBox'

const ServiceLocation = (props) => {

    const updateData = (dataCol, value) => {
        let newOffer = {...props.data}
        newOffer[dataCol] = value
        props.updateData(newOffer)
    }

	const updateArea = (dataCol, value) => {
        let newArea = {...props.data.area}
        newArea[dataCol] = value
        updateData('area', newArea)
    } 

	return (
		<Card cardHeading={`${props.action} Service`} setRef={props.setRef}
			styleHeading='edit-entity-heading'
			styleName='edit-entity-card'>
			<p className='edit-entity-explanation'>
				Please indicate the location where your service will be rendered.
			</p>
			<RadioButtons styleName='edit-entity-radios'
				data={[{caption: 'Online', value: 0},
					{caption: 'In Person', value: 1},
					{caption: 'Both', value: 2}]} 
				dataCol='serviceLocation' 
				value={props.data.serviceLocation}
				onChange={updateData}
				name='serviceLocation'>
			</RadioButtons>{console.log(props.data)}
			{(props.data.serviceLocation === 1 || props.data.serviceLocation === 2) &&
				<TextBox placeholder='Enter Zip Code' type='number'
					value={props.data.area.postalCode}
					id='postalCode' regex={REGEX_NUMBER}
					dataCol='postalCode'
					emptyError='Please enter the service postal code.'
					onChange={updateArea}></TextBox>
			}
			<br />
			{props.action === 'Create' ?
				<Fragment>
					<IconButton styleName='primary medium-small' 
						src={icons.previousIcon}
						onClick={props.handleBack} caption='Back'>
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
				</Fragment>
			}
		</Card>
	)
}

export default ServiceLocation