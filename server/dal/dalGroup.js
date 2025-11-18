// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: group

import db from '../shared/db.js';

export default {
       
    insertGroup: function(data, callback ) {
        var params = `("${data.idEntity}", ${data.groupType}, "${data.backgroundColor}")`
        db.dbo.query('CALL insertGroup' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectGroup: function(data, callback ) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL selectGroup' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectGroupsAll: function(callback ) {
        db.dbo.query('CALL selectGroupsAll', (err, result) => {
            callback (err, result)
        })
    },

    updateGroup: function(data, callback ) {
        var params = `("${data.idEntity}", ${data.groupType}, "${data.backgroundColor}")`
        db.dbo.query('CALL updateGroup' + params, (err, result) => {
            callback (err, result)
        })
    },

    deleteGroup: function(data, callback ) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL deleteGroup' + params, (err, result) => {
            callback (err, result)
        })
    }

};
