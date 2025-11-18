import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/cart/`

class CartCDO {

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
        const newRow = { idUser: null,
                         idEntity: null, 
                         quantity: 0,
                         lastPrice: 0,
                         dirty: false}  //verifyCode omitted
        return newRow;
    }

    getId = () => {
        return 'idUser';
    }

};

export default CartCDO;