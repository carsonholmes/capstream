import React from 'react'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'

const Feed = () => {
    return (
        <ContentContainer>
            <Card cardHeading='Feed'>
                Filter options:
                <div className='button-container'>
                    <IconButton styleName='edit-button' src={icons.allIcon} caption='All'></IconButton>
                    <IconButton styleName='edit-button' src={icons.itemsIcon} caption='Items'></IconButton>
                    <IconButton styleName='edit-button' src={icons.servicesIcon} caption='Services'></IconButton>
                    <IconButton styleName='edit-button' src={icons.eventsIcon} caption='Events'></IconButton>
                    <IconButton styleName='edit-button' src={icons.contactsIcon} caption='Contacts'></IconButton>
                    <IconButton styleName='edit-button' src={icons.groupsIcon} caption='Groups'></IconButton>
                    <IconButton styleName='edit-button' src={icons.placesIcon} caption='Places'></IconButton>
                </div>    
            </Card>
        </ContentContainer>
    )
}

export default Feed