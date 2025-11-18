// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: person

import db from '../shared/db.js';

export default {
       
    insertPerson: function(data, callback ) {
        var params = `("${data.idEntity}","${data.personFirstName}","${data.personLastName}")`
        db.dbo.query('CALL insertPerson' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectPerson: function(data, callback ) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL selectPerson' + params, (err, result) => {
            callback (err, result)
        })
    },

    updatePerson: function(data, callback ) {
        var params = `("${data.idEntity}","${data.personFirstName}","${data.personLastName}")`
        db.dbo.query('CALL updatePerson' + params, (err, result) => {
            callback (err, result)
        })
    },

    deletePerson: function(data, callback ) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL deletePerson' + params, (err, result) => {
            callback (err, result)
        })
    }

};
