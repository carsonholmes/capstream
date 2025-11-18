// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: user-session

import db from '../shared/db.js';

export default {

    insertResetPasswordSession: function( data, callback) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL insertResetPasswordSession' + params, (err, data) => {
            callback (err, data)
        })
    },

    selectResetPasswordSession: function(data, callback ) {
        var params = `("${data.idSession}")`
        db.dbo.query('CALL selectResetPasswordSession' + params, (err, data) => {
            callback (err, data)
        })
    },

    deleteResetPasswordSession: function(user, callback ) {
        var params = `("${data.idSession}")`
        db.dbo.query('CALL deleteResetPasswordSession' + params, (err, data) => {
            callback (err, data)
        })
    }

};
