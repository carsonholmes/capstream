import React, { Fragment } from 'react'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'

const SectionTitle = (props) => {
    return (
		<Fragment>
			<h3 className='section-heading'>Title:</h3>
			<section className='title-section'>
				<div className='maintain-entity-title'>{props.entityTitle}</div>
				<IconButton styleName='no-caption edit-icon' src={icons.editBlueIcon}
					tooltip='Edit Title' onClick={props.onClick}></IconButton>
			</section>
		</Fragment>
    )
}

export default SectionTitle