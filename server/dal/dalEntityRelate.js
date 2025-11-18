// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: data

import db from '../shared/db.js';

export default {
       
    insertEntityRelate: function(data, callback ) {
        var params = `("${data.idEntity}","${data.idRelated}","${data.relateType}")`
        db.dbo.query('CALL insertEntityRelate' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectEntityRelate: function(data, callback ) {
        var params = `("${data.idEntity}","${data.relateType}")`
        db.dbo.query('CALL selectEntityRelate' + params, (err, result) => {
            callback (err, result)
        })
    },

    verifyEntityRelate: function(data, callback ) {
        var params = `("${data.idEntity}","${data.idRelated}")`
        db.dbo.query('CALL verifyEntityRelate' + params, (err, result) => {
            callback (err, result)
        })
    },

    deleteEntityRelate: function(data, callback ) {
        var params = `("${data.idEntity}","${data.idRelated}")`
        db.dbo.query('CALL deleteEntityRelate' + params, (err, result) => {
            callback (err, result)
        })
    },

    deleteEntityRelateAll: function(data, callback ) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL deleteEntityRelateAll' + params, (err, result) => {
            callback (err, result)
        })
    }

};
