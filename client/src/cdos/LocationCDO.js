import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/location/`

class LocationCDO {

    loadCountries = (callback) => {
        util.getJSON(servicesURL + 'active-country', callback);
    }

    loadProvinces = (data, callback) => {
        util.putJSON(servicesURL + 'province-by-country', data, callback);
    }

    // loadData = (data, callback) => {
    //     //data {}
    //     util.putJSON(servicesURL + 'load', data, callback);
    // }

    // saveData = (data, callback) => {
    //     //data {}
    //     util.putJSON(servicesURL + 'update', data, callback);
    // }

    // addData = (data, callback) => {
    //    //data {}
    //    util.putJSON(servicesURL + 'add', data, callback);
    // }

    // deleteData = (data, callback) => {
    //     //data {}
    //     util.putJSON(servicesURL + 'delete-item', data, callback);
    // }

    // removeData = (data, callback) => {
    //     //data {}
    //     util.putJSON(servicesURL + 'remove-item', data, callback);
    // }

    // deleteAll = (data, callback) => {
    //     //data {}
    //     util.putJSON(servicesURL + 'delete', data, callback);
    // }

    getEmptyRow = () => {
        const newRow = { idLocation: null,
                         addressLine1: '',
                         addressLine2: '',
                         city: '',
                         idProvince: -1,
                         idCountry: -1,
                         postalCode: '',
                         dirty: false}
        return newRow;
    }

    // getId = () => {
    //     return 'idUser';
    // }

};

export default LocationCDO;