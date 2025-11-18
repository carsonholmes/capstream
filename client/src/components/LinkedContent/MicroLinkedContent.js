import React from 'react'
import EntityImage from '../EntityImage/EntityImage'
import { ENTITY_USER } from '../../cdos/EntityCDO'
import './LinkedContent.css'

const MicroLinkedContent = (props) => {
    return (
        <div className='micro-linked-content-container'>
            {props.data.map((row, index)=>{   //we already had the filename during selection, but are querying again in EntityImage - bad!
                if (!row.markedForDeletion)
                    return (
                        <EntityImage key={index} idEntity={row.idEntity} 
                            circular={row.entityType===ENTITY_USER} size='xxx-small'>
                        </EntityImage>)
                else return null
            })}     
        </div>
    )
}

export default MicroLinkedContent