import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/media/`

class MediaCDO {

    loadData = (data, callback) => {
        //data {idEntity, idSession}
        util.putJSON(servicesURL + 'load', data, callback);
    }

    saveData = (data, callback) => {
        //data {idEntity, idSession, idmedia, mediaAddress, mediaVerified}
        util.putJSON(servicesURL + 'update', data, callback);
    }

    saveDataAll = (data, callback) => {
        //data {idEntity, idSession, idmedia, mediaAddress, mediaVerified}
        util.putJSON(servicesURL + 'update-all', data, callback);
    }

    uploadFile = (data, cbUploading, cbComplete) => {
        //data {idEntity, idUser, idSession, file}
        util.putFile(servicesURL + 'upload', data, cbUploading, cbComplete);
     }

    addData = (data, callback) => {
       console.table(data)
       //data {idEntity, idUser, idSession, file}
       util.putJSON(servicesURL + 'add', data, callback);
    }

    deleteData = (data, callback) => {
        //data {idEntity, idSession, idmedia}
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    getEmptyRow = () => {
        const newRow = { idMedia: null,
                         idEntity: null,
                         idType: null,
                         idUser: null,
                         fileName: null,
                         dtCreated: null,
                         sortOrder: null,
                         xOffset: 0.0,
                         yOffset: 0.0,
                         new: true }
        return newRow;
    }

    getId = () => {
        return 'idMedia';
    }

};

export default MediaCDO;