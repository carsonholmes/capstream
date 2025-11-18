import React from 'react'
import TextArea from '../controls/TextArea/TextArea'

const PersonalDetails = (props) => {
    
    return (
        <>
            <TextArea id='entityDesc' dataCol='entityDesc' displayOnly={!props.isEditing} value={props.data.entityDesc}
                placeholder='About' onChange={props.onChange}></TextArea>
        </>
    )
}

export default PersonalDetails