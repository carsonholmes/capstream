// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: email

import db from '../shared/db.js';

export default {

    insertEmail: function(data, callback ) {
        var params = `("${data.idEntity}","${data.emailAddress}","${data.emailVerifyCode}")`
        db.dbo.query('CALL insertEmail' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectEmail: function(data, callback) {
        var params = `("${data.idEmail}")`
        db.dbo.query('CALL selectEmail' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectEmailByEntity: function(data, callback) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL selectEmailByEntity' + params, (err, result) => {
            callback (err, result)
        })
    },

    updateEmail: function(data, callback ) {
        var params = `("${data.idEmail}","${data.emailAddress}",${data.emailVerified},"${data.emailVerifyCode}")`
        db.dbo.query('CALL updateEmail' + params, (err, result) => {
            callback (err, result)
        })
    },

    deleteEmail: function(data, callback ) {
        var params = `("${data.idEmail}")`
        db.dbo.query('CALL deleteEmail' + params, (err, result) => {
            callback (err, result)
        })
    }

};