import bcrypt from 'bcryptjs'
import util from '../shared/util.js'
import config from '../config/appConfig.js'

let port = ""
if (config.server.webServicesPort !== 0) port = `:${config.server.webServicesPort}`
var servicesURL = `${config.server.url}${port}/user/`

const saltRounds = 13;

export const timeZoneData = [
    {caption: '', value: -1, gmtOffset: 0},
    {caption: 'Atlantic Time (Canada)', value: 1, gmtOffset: -240},
    {caption: 'Eastern Time (US & Canada)', value: 2, gmtOffset: -300},
    {caption: 'Central Time (US & Canada)', value: 3, gmtOffset: -360},
    {caption: 'Mountain Time (US & Canada)', value: 4, gmtOffset: -420},
    {caption: 'Pacific Time (US & Canada)', value: 5, gmtOffset: -480},
    {caption: 'Alaska', value: 6, gmtOffset: -540},
    {caption: 'Hawaii', value: 7, gmtOffset: -600},
    {caption: 'Taipei', value: 8, gmtOffset: 480}
]

class ProfileCDO {
//            credentials, signInResult - from signIn
    signIn = (data, callback) => {
        //                                                credentials, signInResult
        util.putJSON(servicesURL + 'sign-in', data, callback);
    } //callback returns (status, response data) to SignIn

    //            ({idEntity: appContext.idEntity, idSession: appContext.idSession}, populateProfile)
    loadData = (data, callback) => {
        //                                             ({idEntity, idSession}, populateProfile)
        util.putJSON(servicesURL + 'load', data, callback);
    }

    saveData = (data, callback) => {
        util.putJSON(servicesURL + 'update', data, callback);
    }

    addProfile = (data, callback) => {
        bcrypt.genSalt(saltRounds, (err, salt) => {
            bcrypt.hash(data.userPassword, salt, (err, hash) => {
                data.userPassword = hash
                data.userSalt = salt
                util.putJSON(servicesURL + 'add', data, callback);
            })
        })
    }

    validateUserName = (data, callback) => {
        util.putJSON(servicesURL + 'check-user-name', data, callback);
    }
    
    verifyEmail = (data, callback) => {
        util.putJSON(servicesURL + 'verify-email', data, callback);
    }
    
    validateSession = (data, callback) => {
        util.putJSON(servicesURL + 'verify-session', data, callback);
    }
    
    resendEmail = (data, callback) => {
        util.putJSON(servicesURL + 'resend-email', data, callback);
    }

    forgotPassword = (data, callback) => {
        util.putJSON(servicesURL + 'forgot-password', data, callback);
    }

    forgotUserName = (data, callback) => {
        util.putJSON(servicesURL + 'forgot-user-name', data, callback);
    }

    resetPassword = (data, callback) => {
        util.putJSON(servicesURL + 'reset-password', data, callback);
    }

    changePassword = (data, callback) => {
        util.putJSON(servicesURL + 'change-password', data, callback);
    }

    deleteProfile = (data, callback) => {
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    getEmptyRow = () => {
        const newRow = { idEntity: null, 
                         userName: '', 
                         userPassword: '', 
                         userSalt: null, 
                         personFirstName: '', 
                         personLastName: '', 
                         emailAddress: '',
                         entityTitle: '',
                         entityDesc: '',
                         userTimeZone: timeZoneData.findIndex(tz=>tz.caption=Intl.DateTimeFormat('en-US').resolvedOptions().timeZone) }  //may have a bug in Tawian
        return newRow;
    }



    getId = () => {
        return 'idEntity';
    }

};

export default ProfileCDO;