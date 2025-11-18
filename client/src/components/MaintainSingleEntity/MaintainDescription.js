import React from 'react'
import icons from '../../shared/icons'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import TextArea from '../controls/TextArea/TextArea'
import {ENTITY_TYPE, ENTITY_TYPE_LOWERCASE} from '../../cdos/EntityCDO'

const MaintainDescription = (props) => {
    return (
        <Card cardHeading={`Edit ${ENTITY_TYPE[props.data.entityType]}`} styleHeading='edit-entity-heading'
            styleName='edit-entity-card' setRef={props.setRef}>
            <p className='edit-entity-explanation'>
                Please enter a detailed description of your {ENTITY_TYPE_LOWERCASE[props.data.entityType]}.</p>
            <TextArea id='entityDesc' dataCol='entityDesc' styleName='entity-create' placeholder='Description'
                value={props.data.entityDesc} onChange={props.updateData}></TextArea>
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

export default MaintainDescription