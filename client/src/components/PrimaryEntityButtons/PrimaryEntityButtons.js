import React from 'react'
import entityEditState from '../../shared/entityEditState'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
// import { ENTITY_SERVICE, ENTITY_ITEM } from '../../cdos/EntityCDO'

const PrimaryEntityButtons = (props) => {
    return (
        <div className='button-container'>
            {/* {props.entityType === ENTITY_SERVICE &&
                <IconButton styleName='edit-button' disabled={props.scheduleDisabled}
                    onClick={()=>props.onClick(entityEditState.SCHEDULE)} src={icons.eventsIcon}
                    caption='Schedule'></IconButton>} */}
            <IconButton styleName='edit-button' onClick={()=>props.onClick(entityEditState.CATEGORY)} 
                src={icons.categoryIcon} caption='Category'></IconButton>
            {/* {(props.entityType === ENTITY_SERVICE || props.entityType === ENTITY_ITEM) && 
                <IconButton styleName='edit-button' onClick={()=>props.onClick(entityEditState.OFFER)} 
                    src={icons.priceIcon} caption='Offer'></IconButton>} */}
            <IconButton styleName='edit-button' onClick={()=>props.onClick(entityEditState.BOOKING)} 
                src={icons.settingsIcon} caption='Booking'></IconButton>
            <IconButton styleName='edit-button' onClick={()=>props.onClick(entityEditState.MEDIA)} 
                src={icons.mediaIcon} caption='Media'></IconButton>
            {/* <IconButton styleName='edit-button' onClick={()=>props.onClick(entityEditState.CONTENT)} 
                src={icons.linkIcon} caption='Content'></IconButton> */}
            {/* <IconButton styleName='edit-button' onClick={()=>props.onClick(entityEditState.LOCATION)} 
                src={icons.locationIcon} caption='Location'></IconButton> */}
        </div>
    )
}

export default PrimaryEntityButtons
