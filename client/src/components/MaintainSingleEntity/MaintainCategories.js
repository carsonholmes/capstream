import React, { Fragment } from 'react'
import EntityAttribute from '../EntityAttribute/EntityAttribute'
import CategorySelector from '../CategorySelector/CategorySelector'
import jsonFunctions from '../../shared/jsonFunctions'
import { ENTITY_SERVICE } from '../../cdos/EntityCDO'
import Card from '../Card/Card'

const MaintainCategories = (props) => {
    return (
        <Card cardHeading='Edit Categories' setRef={props.setRef}
			styleHeading='edit-entity-heading' styleName='edit-entity-card'>
            <p className='edit-entity-explanation'>
                Adding categories will enable your service to appear in search results.
            </p>
            <CategorySelector entityType={ENTITY_SERVICE} data={props.data} 
                            updateCategories={props.updateData}
                            saveCategories={props.saveData}
                            cancelCategories={props.handleClose}
                            dirty={!jsonFunctions.jsonEqual(props.data, props.originalData)}
                            categoryList={props.categoryList}
                            setCategoryList={props.setCategoryList}></CategorySelector>
            <EntityAttribute></EntityAttribute>
        </Card>
    )
}

export default MaintainCategories