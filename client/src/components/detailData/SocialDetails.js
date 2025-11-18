import React from 'react'
import TextBox from '../controls/TextBox/TextBox'

const SocialDetails = (props) => {
    
    return (
        <>
            <TextBox id='userFacebook' dataCol='userFacebook' displayOnly={!props.isEditing} value={props.data.userName}
                placeholder='Facebook' onChange={props.onChange}></TextBox>
            <TextBox id='userTwitter' dataCol='userTwitter' displayOnly={!props.isEditing} value={props.data.userName}
                placeholder='Twitter' onChange={props.onChange}></TextBox>     
        </>
    )
}

export default SocialDetails
