import util from '../shared/util.js'
import config from '../config/appConfig.js'
let port = ""
if (config.server.webServicesPort !== 0) port = `:${config.server.webServicesPort}`
var servicesURL = `${config.server.url}${port}/user/`

class EmailCDO {

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
    
    send = (data, callback) => {
        //data {idEntity, idSession, idEmail}
        util.putJSON(servicesURL + 'test', data, callback);
    }
    
    deleteData = (data, callback) => {
        //data {idEntity, idSession, idEmail}
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    getEmptyRow = () => {
        const newRow = { idEmail: null,
                         idEntity: null, 
                         emailAddress: '',
                         emailVerified: false,
                         dirty: false}  //verifyCode omitted
        return newRow;
    }

    getId = () => {
        return 'idEmail';
    }

};

export default EmailCDO;