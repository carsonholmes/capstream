import ProfileCDO from './ProfileCDO';
import EmailCDO from './EmailCDO'; 
import NotificationCDO from './NotificationCDO';

class SelectCDO {
    getCDO = (cardHeading) => {
        if (cardHeading === 'Names' || cardHeading === 'Avatar' || cardHeading === 'Personal' || cardHeading === 'Time Zone') 
            { return new ProfileCDO() }
        if (cardHeading === 'Email') { return new EmailCDO() }
        if (cardHeading === 'Notifications') { return new NotificationCDO() }
    }
}

export default SelectCDO