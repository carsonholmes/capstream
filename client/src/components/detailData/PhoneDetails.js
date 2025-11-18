import React from 'react'
import TextBox from '../controls/TextBox/TextBox'

const PhoneDetails = (props) => {
    
    return (
        <>
             <TextBox id='userPhone' dataCol='userPhone' displayOnly={!props.isEditing} value={props.data.userName}
                placeholder='Phone Number' onChange={props.onChange} type='tel'></TextBox>       
        </>
    )
}

export default PhoneDetails
