import React, { Fragment } from 'react'
import icons from '../../shared/icons'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import {ENTITY_TYPE, ENTITY_TYPE_PLURAL, ENTITY_TYPE_LOWERCASE} from '../../cdos/EntityCDO'
import TextBox from '../controls/TextBox/TextBox'

const MaintainTitle = (props) => {

    const validateTitle = () => {
        if (props.data.entityTitle) {
            return true
        }
        else {
            alert(ENTITY_TYPE_PLURAL[props.data.entityType] + ' must have a title to save.')
            return false
        }
    }

	return (
		<Card cardHeading={`${props.action} ${ENTITY_TYPE[props.data.entityType]}`} setRef={props.setRef}
			styleHeading='edit-entity-heading'
			styleName='edit-entity-card'>
			<p className='edit-entity-explanation'>
				Please {props.action === 'Create' ? 'enter' : 'edit'} the title of your {ENTITY_TYPE_LOWERCASE[props.data.entityType]}.
			</p>
			<TextBox id='entityTitle' dataCol='entityTitle' placeholder='Title'
				value={props.data.entityTitle} onChange={props.updateData}></TextBox>
			<br />
			{props.action === 'Create' ?
				<Fragment>
					<IconButton styleName='primary medium-small' 
						src={icons.nextIcon} disabled={props.data.entityTitle.length === 0}
						onClick={props.handleNext} caption='Next'>
					</IconButton>
					<IconButton styleName={'primary medium-small'}
						src={icons.closeIcon}
						onClick={props.handleClose} caption='Close'>
					</IconButton>
				</Fragment> :
				<Fragment> {/* action = Edit */}
					<IconButton styleName={'primary medium-small'}
						disabled={!props.dirty} src={icons.saveIcon}
						onClick={()=>props.saveData(validateTitle)} caption='Save'>
					</IconButton>
					<IconButton styleName={'primary medium-small'}
						src={icons.closeIcon}
						onClick={props.handleClose} caption='Close'>
					</IconButton>
				</Fragment>
			}
		</Card>
	)
}

export default MaintainTitle