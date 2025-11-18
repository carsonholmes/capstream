// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: user-session

import db from '../shared/db.js';

export default {

    insertUserSession: function( data, callback) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL insertUserSession' + params, (err, data) => {
            callback (err, data)
        })
    },

    selectUserSession: function(data, callback ) {
        var params = `("${data.idSession}")`
        db.dbo.query('CALL selectUserSession' + params, (err, data) => {
            callback (err, data)
        })
    },

    updateUserSession: function(user, callback ) {
        var params = `("${data.idSession}","${data.idEntity}","${data.done}")`
        db.dbo.query('CALL updateUserSession ' + params, (err, result) => {
            callback(err, result);
        });            
    },

    deleteUserSession: function(user, callback ) {
        var params = `("${data.idSession}")`
        db.dbo.query('CALL deleteUserSession' + params, (err, data) => {
            callback (err, data)
        })
    }

};
