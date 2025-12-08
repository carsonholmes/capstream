import util from '../shared/util.js';
import config from '../config.js';

var servicesURL = `${config.server.url}:${config.server.webServicesPort}/`
if (config.server.url === "https://data.capstream.io") {
  servicesURL = "https://data.capstream.io/"
    }
servicesURL += "session/"

class cdoSession {
    create = (data, callback) => {
        util.putJSON(servicesURL + 'create', data, callback);
    }
    
    update = (data, callback) => {
        util.putJSON(servicesURL + 'update', data, callback);
    }

    getLocation = (callback) => {
        util.getJSON('https://ipapi.co/json/', callback)
    }
};

const cdo = new cdoSession();
export default cdo;
