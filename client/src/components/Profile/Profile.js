import React, {useState, useContext} from 'react'
import { AppContext } from '../../AppContext'
import AuthFrame from '../AuthFrame/AuthFrame'
import NavLink from '../controls/NavLink/NavLink'
import DataCard from '../DataCard/DataCard'
import Card from '../Card/Card'
import MaintainEntityImages from '../MaintainEntityImages/MaintainEntityImages'
import ContentContainer from '../ContentContainer/ContentContainer'
import { ENTITY_USER } from '../../cdos/EntityCDO'
    
const Profile = () => {
    
    const {appContext} = useContext(AppContext)
    const [isEditingAvatar, setIsEditingAvatar] = useState(false) 

    return (
        <AuthFrame profile={true} mandatory={true}>
            {isEditingAvatar ? 
                <ContentContainer>
                    <Card cardHeading='Edit Avatar'>
                        <MaintainEntityImages closeEdit={()=>setIsEditingAvatar(false)}
                            idEntity={appContext.idEntity} entityType={ENTITY_USER} circular={true}></MaintainEntityImages> 
                    </Card>
                </ContentContainer>
                :
                <ContentContainer contentHeading='Profile'>
                    <DataCard cardHeading='Names'>
                    </DataCard>
                    <DataCard cardHeading='Avatar' setIsEditingAvatar={setIsEditingAvatar}>
                    </DataCard>
                    <DataCard cardHeading='Personal'>
                    </DataCard>
                    <DataCard cardHeading='Email' multiple={true}>
                    </DataCard>
                    <DataCard cardHeading='Time Zone'></DataCard>
                    {/* <DataCard  cardHeading='Phone' multiple={true}>
                    </DataCard> 
                    <DataCard cardHeading='Settings'>
                    </DataCard> */}
                    <DataCard cardHeading='Notifications'>
                    </DataCard>
                    <Card cardHeading='Security'>
                        <NavLink to='/change-password'>Change Password</NavLink>
                    </Card> 
                    {/* <DataCard cardHeading='Location' multiple={true}>
                    </DataCard>
                    <DataCard cardHeading='Social Media' multiple={true}>
                    </DataCard>
                    <DataCard cardHeading='Transactions'>
                        <NavLink styleName='page-link'>View transaction history</NavLink>
                    </DataCard> */}
                </ContentContainer>
            }
        </AuthFrame>
    )
}

export default Profile
