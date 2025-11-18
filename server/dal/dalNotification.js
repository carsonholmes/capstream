// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: notification
import db from '../shared/db.js';

export default {

    insertNotification: function(data, callback ) {
        if (data.serviceBeingBookedEmail) data.serviceBeingBookedEmail = 1
        else data.serviceBeingBookedEmail = 0
        if (data.serviceBeingBookedText) data.serviceBeingBookedText = 1
        else data.serviceBeingBookedText = 0
        if (data.bookingRequestSubmittedEmail) data.bookingRequestSubmittedEmail = 1
        else data.bookingRequestSubmittedEmail = 0
        if (data.bookingRequestSubmittedText) data.bookingRequestSubmittedText = 1
        else data.bookingRequestSubmittedText = 0
        if (data.bookingRequestConfirmedEmail) data.bookingRequestConfirmedEmail = 1
        else data.bookingRequestConfirmedEmail = 0
        if (data.bookingRequestConfirmedText) data.bookingRequestConfirmedText = 1
        else data.bookingRequestConfirmedText = 0
        if (data.bookingCancelEmail) data.bookingCancelEmail = 1
        else data.bookingCancelEmail = 0
        if (data.bookingCancelText) data.bookingCancelText = 1
        else data.bookingCancelText = 0
        if (data.reminderProviderApptEmail) data.reminderProviderApptEmail = 1
        else data.reminderProviderApptEmail = 0
        if (data.reminderProviderApptText) data.reminderProviderApptText = 1
        else data.reminderProviderApptText = 0
        if (data.reminderConsumerApptEmail) data.reminderConsumerApptEmail = 1
        else data.reminderConsumerApptEmail = 0
        if (data.reminderConsumerApptText) data.reminderConsumerApptText = 1
        else data.reminderConsumerApptText = 0
        var params = `("${data.idEntity}",` +
            `b'${data.serviceBeingBookedEmail}',` +
            `b'${data.serviceBeingBookedText}',` +
            `b'${data.bookingRequestSubmittedEmail}',` +
            `b'${data.bookingRequestSubmittedText}',` +
            `b'${data.bookingRequestConfirmedEmail}',` +
            `b'${data.bookingRequestConfirmedText}',` +
            `b'${data.bookingCancelEmail}',` +
            `b'${data.bookingCancelText}',` +
            `b'${data.reminderProviderApptEmail}',` +
            `b'${data.reminderProviderApptText}',` +
            `b'${data.reminderConsumerApptEmail}',` +
            `b'${data.reminderConsumerApptText}')`
        db.dbo.query('CALL insertNotification' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectNotification: function(data, callback) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL selectNotification' + params, (err, result) => {
            callback (err, result)
        })
    },

    updateNotification: function(data, callback ) {
        if (data.serviceBeingBookedEmail) data.serviceBeingBookedEmail = 1
        else data.serviceBeingBookedEmail = 0
        if (data.serviceBeingBookedText) data.serviceBeingBookedText = 1
        else data.serviceBeingBookedText = 0
        if (data.bookingRequestSubmittedEmail) data.bookingRequestSubmittedEmail = 1
        else data.bookingRequestSubmittedEmail = 0
        if (data.bookingRequestSubmittedText) data.bookingRequestSubmittedText = 1
        else data.bookingRequestSubmittedText = 0
        if (data.bookingRequestConfirmedEmail) data.bookingRequestConfirmedEmail = 1
        else data.bookingRequestConfirmedEmail = 0
        if (data.bookingRequestConfirmedText) data.bookingRequestConfirmedText = 1
        else data.bookingRequestConfirmedText = 0
        if (data.bookingCancelEmail) data.bookingCancelEmail = 1
        else data.bookingCancelEmail = 0
        if (data.bookingCancelText) data.bookingCancelText = 1
        else data.bookingCancelText = 0
        if (data.reminderProviderApptEmail) data.reminderProviderApptEmail = 1
        else data.reminderProviderApptEmail = 0
        if (data.reminderProviderApptText) data.reminderProviderApptText = 1
        else data.reminderProviderApptText = 0
        if (data.reminderConsumerApptEmail) data.reminderConsumerApptEmail = 1
        else data.reminderConsumerApptEmail = 0
        if (data.reminderConsumerApptText) data.reminderConsumerApptText = 1
        else data.reminderConsumerApptText = 0
        var params = `("${data.idNotification}",` +
            `b'${data.serviceBeingBookedEmail}',` +
            `b'${data.serviceBeingBookedText}',` +
            `b'${data.bookingRequestSubmittedEmail}',` +
            `b'${data.bookingRequestSubmittedText}',` +
            `b'${data.bookingRequestConfirmedEmail}',` +
            `b'${data.bookingRequestConfirmedText}',` +
            `b'${data.bookingCancelEmail}',` +
            `b'${data.bookingCancelText}',` +
            `b'${data.reminderProviderApptEmail}',` +
            `b'${data.reminderProviderApptText}',` +
            `b'${data.reminderConsumerApptEmail}',` +
            `b'${data.reminderConsumerApptText}')`
        db.dbo.query('CALL updateNotification' + params, (err, result) => {
            callback (err, result)
        })
    },

    deleteNotification: function(data, callback ) {
        var params = `("${data.idNotification}")`
        db.dbo.query('CALL deleteNotification' + params, (err, result) => {
            callback (err, result)
        })
    },

    getEmptyRow: function() {
        const newRow = { idNotification: null,
                         idEntity: null,  // user
                         serviceBeingBookedEmail: true,
                         serviceBeingBookedText: true,
                         bookingRequestSubmittedEmail: true,
                         bookingRequestSubmittedText: true,
                         bookingRequestConfirmedEmail: true,
                         bookingRequestConfirmedText: true,
                         bookingCancelEmail: true,
                         bookingCancelText: true,
                         reminderProviderApptEmail: true,
                         reminderProviderApptText: true,
                         reminderConsumerApptEmail: true,
                         reminderConsumerApptText: true,
                         dirty: false}  
        return newRow;
    }

};