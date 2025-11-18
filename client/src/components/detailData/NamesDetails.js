import React from 'react'
import TextBox from '../controls/TextBox/TextBox'

const NamesDetails = (props) => {

    const checkUserName = () => {

    }
    
    return (
        <>
            <TextBox id='userName' dataCol='userName' displayOnly={!props.isEditing} value={props.data.userName}
                placeholder='User Name' onChange={props.onChange} onBlur={checkUserName}></TextBox>
            {/* {!isUserNameUnique && <div className='input-error'>That user name is unavailable.</div>} */}
            <TextBox id='personFirstName' dataCol='personFirstName' displayOnly={!props.isEditing} value={props.data.personFirstName}
                placeholder='First Name' onChange={props.onChange}></TextBox>
            <TextBox id='personLastName' dataCol='personLastName' displayOnly={!props.isEditing} value={props.data.personLastName}
                placeholder='Last Name' onChange={props.onChange}></TextBox>                
            <TextBox id='entityTitle' dataCol='entityTitle' displayOnly={!props.isEditing} value={props.data.entityTitle}
                placeholder='Display Name' onChange={props.onChange}></TextBox>
            <div className='input-policy'>This will be the name that other users see.</div>              
        </>
    )
}

export default NamesDetails