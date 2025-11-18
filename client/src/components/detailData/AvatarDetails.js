import React from 'react'
import EntityImage from '../EntityImage/EntityImage'

const AvatarDetails = (props) => {

   return (
            <div className='profile-avatar-container'>
                <EntityImage styleName='edit-profile-preview' idEntity={props.data.idEntity} 
                    circular={true} size='large'
                    fullScreenAble={true}>
                </EntityImage>
            </div>
    )
}

export default AvatarDetails
