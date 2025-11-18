import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/suggestion/`

class SuggestionCDO {

    addData = (data, callback) => {
       //data {idEntity, suggestion}
       util.putJSON(servicesURL + 'add', data, callback);
    }

    getEmptyRow = () => {
        const newRow = { idSuggestion: null,
                         idEntity: null, 
                         suggestion: '',
                         dirty: false}
        return newRow;
    }

    getId = () => {
        return 'idSuggestion';
    }

};

export default SuggestionCDO;