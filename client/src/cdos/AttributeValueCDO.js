import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/attribute-value/`

class AttributeValueCDO {

    loadData = (data, callback) => {
        //data {idAttribute}
        util.putJSON(servicesURL + 'load', data, callback);
    }

    saveData = (data, callback) => {
       //data {idAttributeValue, idAttribute, attrValue, idSuggestor}
        util.putJSON(servicesURL + 'update', data, callback);
    }

    addData = (data, callback) => {
       //data {idAttribute, attrValue, idSuggestor}
       util.putJSON(servicesURL + 'add', data, callback);
    }

    deleteData = (data, callback) => {
        //data {idAttributeValue}
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    getEmptyRow = () => {
        const newRow = { idAttributeValue: null }  //verifyCode omitted
        return newRow;
    }

    getId = () => {
        return 'idAttributeValue';
    }

};

export default AttributeValueCDO;