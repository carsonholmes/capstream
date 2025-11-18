import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/message/`

class MessageCDO {

    loadData = (data, callback) => {
        util.putJSON(servicesURL + 'load', data, callback);
    }

    loadThread = (data, callback) => {
        util.putJSON(servicesURL + 'load-thread', data, callback);
    }

    saveData = (data, callback) => {
        util.putJSON(servicesURL + 'update', data, callback);
    }

    addData = (data, callback) => {
       util.putJSON(servicesURL + 'add', data, callback);
    }

    deleteData = (data, callback) => {
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    getEmptyRow = () => {
        const newRow = { idMessage: null,
                         idThread: 0,
                         idSender: null,
                         idRecipient: null,
                         dtSent: null,
                         messageText: '',
                         dtViewed: null
                        }  
        return newRow;
    }

    getId = () => {
        return 'idMessage';
    }

};

export default MessageCDO;