import React, {Fragment, useEffect, useState} from 'react'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
import DisplayView from '../View/DisplayView'
import Button from '../controls/buttons/Button'
import {ENTITY_TYPE} from '../../cdos/EntityCDO'
import './EntityPreview.css'

const EntityPreview = (props) => {
    
    const [currentImageIndex, setCurrentImageIndex] = useState(-1)
    
    useEffect(() => {
        let index = 0
        while (index < props.data.media.length && props.data.media[index].markedForDeletion) index++
        if (index === props.data.media.length) index = -1  // if at the end, all must be marked for deletion so set to -1 to avoid display
        setCurrentImageIndex(index)
    }, [props.data.media])
    
    return (
        <Fragment>
            <IconButton styleName='return-to-entity' onClick={()=>props.setMode('create')} src={icons.previousIcon}
                caption={'Return to ' + ENTITY_TYPE[props.entityType]}></IconButton>
            <DisplayView data={props.data} 
                idEntity={props.idEntity}
                currentImageIndex={currentImageIndex}
                previewMode={true} 
                setCurrentImageIndex={setCurrentImageIndex}>
            </DisplayView>
            <Button styleName='primary medium reverse-gradient' onClick={props.saveData}>
                {`${props.create ? 'Submit' : 'Save'} ${ENTITY_TYPE[props.entityType]}`}</Button>
        </Fragment>
    )
}

export default EntityPreview