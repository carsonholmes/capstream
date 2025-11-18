import React from 'react'
import NamesDetails from '../detailData/NamesDetails'
import AvatarDetails from '../detailData/AvatarDetails'
import EmailDetails from '../detailData/EmailDetails'
import PhoneDetails from '../detailData/PhoneDetails'
import LocationDetails from '../detailData/LocationDetails'
import SocialDetails from '../detailData/SocialDetails'
import PersonalDetails from '../detailData/PersonalDetails'
import NotificationDetails from '../detailData/NotificationDetails'
import TimeZoneDetails from '../detailData/TimeZoneDetails'

const CardDetails = (props) => {

    switch (props.cardHeading) {
        case 'Names': {
            return (<NamesDetails isEditing={props.isEditing} data={props.data} onChange={props.onChange}
                save={props.save} setValid={props.setValid}></NamesDetails>)
        }
        case 'Avatar': {
            return (<AvatarDetails isEditing={props.isEditing} data={props.data} onChange={props.onChange}
                save={props.save} setValid={props.setValid}></AvatarDetails>)
        }
        case 'Personal': {
            return (<PersonalDetails isEditing={props.isEditing} data={props.data} onChange={props.onChange}
                save={props.save} setValid={props.setValid}></PersonalDetails>)
        }
        case 'Email': {
            return (<EmailDetails isEditing={props.isEditing} data={props.data} onChange={props.onChange}
                row={props.row} index={props.index} onSelect={props.onSelect}
                save={props.save} setValid={props.setValid} add={props.add} type='password'></EmailDetails>)
        }
        case 'Time Zone': {
            return (<TimeZoneDetails isEditing={props.isEditing} data={props.data} onChange={props.onChange}
                save={props.save} setValid={props.setValid}></TimeZoneDetails>)
        }
        case 'Phone': {
            return (<PhoneDetails isEditing={props.isEditing} data={props.data} onChange={props.onChange}
                save={props.save} setValid={props.setValid} type='tel'></PhoneDetails>)
        }
        case 'Notifications': {
            return (<NotificationDetails isEditing={props.isEditing} data={props.data} onChange={props.onChange}
                save={props.save} setValid={props.setValid}></NotificationDetails>)
        }
        case 'Location': {
            return (<LocationDetails isEditing={props.isEditing} data={props.data} onChange={props.onChange}
                save={props.save} setValid={props.setValid}></LocationDetails>)
        }
        case 'Social Media': {
            return (<SocialDetails isEditing={props.isEditing} data={props.data} onChange={props.onChange}
                save={props.save} setValid={props.setValid}></SocialDetails>)
        }
        default: return(<div>Card details not found.</div>)
        }
}

export default CardDetails
