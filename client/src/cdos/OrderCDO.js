import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/order/`

export const ORDER_NEW = 1

class OrderCDO {

    loadData = (data, callback) => {
        //data {}
        util.putJSON(servicesURL + 'load', data, callback);
    }

    saveData = (data, callback) => {
        //data {}
        util.putJSON(servicesURL + 'update', data, callback);
    }

    addData = (data, callback) => {
       //data {}
       util.putJSON(servicesURL + 'add', data, callback);
    }

    addOrderItem = (data, callback) => {
        //data {}
        util.putJSON(servicesURL + 'add-item', data, callback);
     }

    deleteData = (data, callback) => {
        //data {}
        util.putJSON(servicesURL + 'delete-item', data, callback);
    }

    removeData = (data, callback) => {
        //data {}
        util.putJSON(servicesURL + 'remove-item', data, callback);
    }

    deleteAll = (data, callback) => {
        //data {}
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    getEmptyRow = () => {
        const newRow = { idOrder: null,
                         cartItems: [],
                         dirty: false}
        return newRow;
    }

    getId = () => {
        return 'idUser';
    }

};

export default OrderCDO;