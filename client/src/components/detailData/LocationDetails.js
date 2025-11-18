import React from 'react'
import TextBox from '../controls/TextBox/TextBox'

const LocationDetails = (props) => {
    
    return (
        <>
            <TextBox id='userShippingAddress' dataCol='userShippingAddress' displayOnly={!props.isEditing} value={props.data.userName}
                placeholder='Shipping Address' onChange={props.onChange}></TextBox>
            <TextBox id='userBillingAddress' dataCol='userBillingAddress' displayOnly={!props.isEditing} value={props.data.userName}
                placeholder='Billing Address' onChange={props.onChange}></TextBox>     
        </>
    )
}

export default LocationDetails
