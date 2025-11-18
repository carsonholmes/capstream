import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/attribute/`

export const ATTRIBUTE_TYPE_NUMBER = 1
export const ATTRIBUTE_TYPE_TEXT = 2
export const ATTRIBUTE_TYPE_CUSTOM_DROPDOWN = 3

class AttributeCDO {

    loadData = (data, callback) => {
        util.putJSON(servicesURL + 'load', data, callback);
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

    loadValues = (data, callback) => {
        //data {idAttribute}
        util.putJSON(servicesURL + 'load', data, callback);
    }

    saveValue = (data, callback) => {
       //data {idAttributeValue, idAttribute, attrValue, idSuggestor}
        util.putJSON(servicesURL + 'update', data, callback);
    }

    addValue = (data, callback) => {
       //data {idAttribute, attrValue, idSuggestor}
       util.putJSON(servicesURL + 'add', data, callback);
    }

    deleteValue = (data, callback) => {
        //data {idAttributeValue}
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    getEmptyRow = () => {
        const newRow = { idAttribute: null}  //verifyCode omitted
        return newRow;
    }

    getId = () => {
        return 'idAttribute';
    }

};

export default AttributeCDO;