// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: data

import db from '../shared/db.js';

export default {
       
    insertMasterType: function(data, callback ) {
        var params = `("${data.table}","${data.column}","${data.value}","${data.code}")`
        db.dbo.query('CALL insertMasterType' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectMasterType: function(data, callback ) {
        var params = `("${data.idMasterType}")`
        db.dbo.query('CALL selectMasterType' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectMasterTypeByValue: function(data, callback ) {
        var params = `("${data.value}")`
        db.dbo.query('CALL selectMasterTypeByValue' + params, (err, result) => {
            callback (err, result)
        })
    },

    updateMasterType: function(data, callback ) {
        var params = `("${data.idMasterType}","${data.table}","${data.column}","${data.value}","${data.code}")`
        db.dbo.query('CALL updateMasterType' + params, (err, result) => {
            callback (err, result)
        })
    },

    deleteMasterType: function(data, callback ) {
        var params = `("${data.idMasterType}")`
        db.dbo.query('CALL deleteMasterType' + params, (err, result) => {
            callback (err, result)
        })
    }

};
