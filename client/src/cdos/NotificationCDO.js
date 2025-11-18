import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/notification/`

class NotificationCDO {

    loadData = (data, callback) => {
        //data {idEntity, idSession}
        util.putJSON(servicesURL + 'load', data, callback);
    }

    saveData = (data, callback) => {
        //data {idEntity, idSession, idEmail, emailAddress, emailVerified}
        util.putJSON(servicesURL + 'update', data, callback);
    }

    addData = (data, callback) => {
       //data {idEntity, idSession, idEmail, emailAddress, emailVerified}
       util.putJSON(servicesURL + 'add', data, callback);
    }

    deleteData = (data, callback) => {
        //data {idEntity, idSession, idEmail}
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    getEmptyRow = () => {
        const newRow = { idNotification: null,
                         idEntity: null,  // user
                         serviceBeingBookedEmail: true,
                         serviceBeingBookedText: true,
                         bookingRequestSubmittedEmail: true,
                         bookingRequestSubmittedText: true,
                         bookingRequestConfirmedEmail: true,
                         bookingRequestConfirmedText: true,
                         bookingCancelEmail: true,
                         bookingCancelText: true,
                         reminderProviderApptEmail: true,
                         reminderProviderApptText: true,
                         reminderConsumerApptEmail: true,
                         reminderConsumerApptText: true,
                         dirty: false}  
        return newRow;
    }

    getId = () => {
        return 'idNotification';
    }

};

export default NotificationCDO;