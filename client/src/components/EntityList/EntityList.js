import React, {Fragment} from 'react'
import EntityImage from '../EntityImage/EntityImage'
import CheckBox from '../controls/CheckBox/CheckBox'
import {ENTITY_TYPE, ENTITY_USER} from '../../cdos/EntityCDO'
import './EntityList.css'

const EntityList = (props) => {

    const dynamicColumnStyle = () => {
        if (props.selectable) return ('entity-list-container four-columns')
        if (props.hideLabel) return ('entity-list-container two-columns')
        else return ('entity-list-container')
    }

    if (props.data && props.data[0])
        return (
            <div className={dynamicColumnStyle()}>
                {props.data.map((row, index)=>{
                        if (!row.markedForDeletion) 
                            return (
                                <Fragment key={row.idEntity}>    
                                    {props.selectable && 
                                        <CheckBox styleName='entity-list-select'
                                            onChange={()=>props.updateSelection(index)}
                                            checked={props.selectedData.indexOf(index) >= 0}>
                                        </CheckBox>
                                    }
                                    <EntityImage styleName='entity-list' idEntity={row.idEntity} 
                                        circular={row.entityType===ENTITY_USER} size='x-small'
                                        onClick={()=>window.location.href='/view/' + row.idEntity}
                                        entityType = {row.entityType}>
                                    </EntityImage>
                                    {!props.hideLabel && 
                                        <div className='entity-list-entity-type'>{ENTITY_TYPE[row.entityType]}:</div> }
                                    <a className='entity-list-entity-title' href={'/view/' + row.idEntity}>{row.entityTitle}</a>
                                </Fragment>
                            )
                        else return null
                })}
            </div>
        )
    else return <></>
}

export default EntityList
