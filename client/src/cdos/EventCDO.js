import util from '../shared/util.js'
import config from '../config/appConfig.js'
var servicesURL = `${config.server.url}:${config.server.webServicesPort}/event/`

export const REPEAT_NEVER = 0
export const REPEAT_DAILY = 1
export const REPEAT_WEEKLY = 2
export const REPEAT_WEEKDAYS = 3
export const REPEAT_MONTHLY_ORDINAL = 4
export const REPEAT_MONTHLY_LAST = 5
export const REPEAT_MONTHLY_DATE = 6
export const REPEAT_YEARLY = 7
export const REPEAT_CUSTOM = 8
export const REPEAT_CUSTOM_SPECIFIC = 9

export const TYPE_AVAILABLE = 1
export const TYPE_UNAVAILABLE = 2 // (canceled repeat)
export const TYPE_BOOKED = 3

class EventCDO {

    loadData = (data, callback) => {
        //data {idEntity, idSession}
        util.putJSON(servicesURL + 'load', data, callback);
    }

    loadUserData = (data, callback) => {
        //data {idEntity, idSession}
        util.putJSON(servicesURL + 'load-user', data, callback);
    }

    loadServiceAvailability = (data, callback) => {
        //data {idEntity, idSession}
        util.putJSON(servicesURL + 'load-service-availability', data, callback);
    }

    saveData = (data, callback) => {
        //data {idEntity, idSession, idEmail, emailAddress, emailVerified}
        util.putJSON(servicesURL + 'update', data, callback);
    }

    saveBooking = (data, callback) => {
        //data {idEntity, idSession, idEmail, emailAddress, emailVerified}
        util.putJSON(servicesURL + 'update-booking', data, callback);
    }

    addData = (data, callback) => {
       //data {idEntity, idSession, idEmail, emailAddress, emailVerified}
       util.putJSON(servicesURL + 'add', data, callback);
    }

    deleteData = (data, callback) => {
        //data {idEntity, idSession, idEmail}
        util.putJSON(servicesURL + 'delete', data, callback);
    }

    loadChainEdit = (data, callback) => {
        //data {idEntity, idSession}
        util.putJSON(servicesURL + 'load-chain-edit', data, callback);
    }

    addChainEdit = (data, callback) => {
       //data {idEntity, idSession, idEmail, emailAddress, emailVerified}
       util.putJSON(servicesURL + 'add-chain-edit', data, callback);
    }

    deleteChainEdit = (data, callback) => {
        //data {idEntity, idSession, idEmail}
        util.putJSON(servicesURL + 'delete-chain-edit', data, callback);
    }

    cancelBookings = (data, callback) => {
        //data {idEntity, idSession, idEmail}
        util.putJSON(servicesURL + 'cancel-bookings', data, callback);
    }

    getEmptyRow = () => {
        var d = new Date();
        const newRow = { idEvent: null, 
                        idEntity: null,
                        eventType: 0, // see above constants for values
                        dtStart: d,
                        dtEnd: d,
                        allDay: false,
                        minTimeBlock: 0, // 0 = none, 1 = :15, 2 = :30, 3 = :45, 4 = 1:00, 5 = 1:30, 6 = 2:00, 7 = 3:00
                        repeatType: 0, // see above constants for values
                        repeatInterval: 1,  // default to every 1
                        repeatTimeFrame: REPEAT_WEEKLY,
                        repeatMonthlyType: REPEAT_MONTHLY_DATE,
                        repeatSun: false,
                        repeatMon: false,
                        repeatTue: false,
                        repeatWed: false,
                        repeatThu: false,
                        repeatFri: false,
                        repeatSat: false,
                        repeatEndType: 0,  //0 = never, 1 = end date, 2=occurences
                        repeatEnd: d,    // date time
                        repeatOccurences: 10,
                        allServices: true,
                        repeatGenerated: 0,
                        repeatUpdateOption: 0,  //0 = this event, 1 = this and following events, 2 = all events
                        servicesOffered: [],
                        eventChainEdits: [],
                        confirmed: 0} // 0 = unconfirmed, 1 = confirmed, 2 = declined
        return newRow;
    }

    getId = () => {
        return 'idEvent';
    }

};

export default EventCDO;