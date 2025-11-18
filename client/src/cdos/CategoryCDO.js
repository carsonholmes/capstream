import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/category/`

class CategoryCDO {

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

    getEmptyRow = () => {
        const newRow = {idParent: null, 
                        idCategory: null, 
                        catDesc: 'Other', 
                        selected: false, 
                        expanded: false, 
                        children: []}
        return newRow;
    }

    getId = () => {
        return 'idCategory';
    }

};

export default CategoryCDO;