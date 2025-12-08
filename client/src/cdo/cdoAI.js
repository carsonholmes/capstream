import util from '../shared/util.js';
import config from '../config.js';

var servicesURL = `${config.server.url}:${config.server.webServicesPort}/`
if (config.server.url === "https://data.capstream.io") {
  servicesURL = "https://data.capstream.io/"
    }
servicesURL += "ai/"

class cdoAI {
    ask = (data, callback) => {
        util.putJSON(servicesURL + 'ask', data, callback);
    }

    refactor = (data, callback) => {
        //data {idEntity, idSession, searchCriteria}
        util.putJSON(servicesURL + 'refactor', data, callback);
    }

    undo = (data, callback) => {
        //data {idEntity, idSession, undoSteps}
        util.putJSON(servicesURL + 'undo', data, callback);
    }

    search = (data, callback) => {
        //data {idEntity, idSession, searchQuery}
        util.putJSON(servicesURL + 'search', data, callback);
    }

    launch = (data, callback) => {
        //data {idEntity, idSession, searchQuery}
        util.putJSON(servicesURL + 'launch', data, callback);
    }
    
    genLogo = (data, callback) => {
        //data {appName, goals, additionalArtInstructions}
        util.putJSON(servicesURL + 'generate-logo', data, callback);
    }
    
    initApp = (data, callback) => {
        //data {appName, goals, additionalArtInstructions}
        util.putJSON(servicesURL + 'init-app', data, callback);
    }
    
};

const cdo = new cdoAI();
export default cdo;