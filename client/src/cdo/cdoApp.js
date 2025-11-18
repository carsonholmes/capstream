import util from '../shared/util.js';
import config from '../config.js';

var servicesURL = `${config.server.url}:${config.server.webServicesPort}/app/`;

class cdoApp {
    addApp = (data, callback) => {
        util.putJSON(servicesURL + 'add', data, callback);
    }

    loadApp = (data, callback) => {
        util.putJSON(servicesURL + 'load', data, callback);
    }

    loadAppByCode = (data, callback) => {
        util.putJSON(servicesURL + 'load-by-code', data, callback);
    }

    loadAppsByUser = (data, callback) => {
        util.putJSON(servicesURL + 'load-by-user', data, callback);
    }

    updateApp = (data, callback) => {
        util.putJSON(servicesURL + 'update', data, callback);
    }

    deleteApp = (data, callback) => {
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    getEmptyRow = () => {
        const newRow = {
            idEntity: null, //id of app
            idUser: '',
            rootDirectory: "c:\\dev\\factory\\template",
            appName: "",
            appUrl: '',
            cloneUrl: '',
            version: 0,
            messages: [],
            imageFiles: [],
            newImageFiles: [],
            removeImageFiles: [],
            goals: "",
            technology: "React-Node-Express-MySQL",
            model: "gpt-4o",
            apiKey: config.apiKey,
            additionalInstructions: "",
            layers: [
                { name: "UI", selected: true},
                { name: "Mid", selected: false},
                { name: "Data", selected: false}
            ],
            fixErrors: false,
            prevFixErrors: false,
            errorText: '',
            prevErrorText: '',
            idModifyCode: false,
            changeSummary: '',
            generatingCode: false,    
            timezoneOffset: new Date().getTimezoneOffset(),
            timezone: Intl.DateTimeFormat().resolvedOptions().timeZone
        };
        return newRow;
    }

    getStartLayer = (app) => {
        let startLayer = false
        if (app.layers[0].selected) startLayer = "UI"
        if (app.layers[1].selected) startLayer = "BPL"
        if (app.layers[2].selected) startLayer = "DB"
        return startLayer
    }
}

const cdo = new cdoApp();
export default cdo;