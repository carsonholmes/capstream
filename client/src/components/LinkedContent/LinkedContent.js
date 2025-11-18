import React from 'react'
import './LinkedContent.css'
import EntityList from '../EntityList/EntityList'
// uses styling from View.css

const LinkedContent = (props) => {

    if (props.data.length > 0)
        return (
            <div className='linked-content-container'>
                <h2 className='sub-section-heading'>Linked Content:</h2>
                <EntityList data={props.data}></EntityList>
            </div>
        )
    else return ( <></> )
}

export default LinkedContent