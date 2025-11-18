// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: user 

import db from '../shared/db.js';

export default { 
 
    insertUser: function( data, callback) {
        var params = `("${data.idEntity}","${data.userName}","${data.userPassword}","${data.userSalt}","${data.userPrimaryEmail}", 7)`
        db.dbo.query('CALL insertUser' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectUser: function(data, callback ) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL selectUser' + params, (err, result) => {
            callback (err, result)
        })
    },

    selectUserByUserName: function(data, callback ) {
        var params = `("${data.userName}")`
        db.dbo.query('CALL selectUserByUserName' + params, (err, result) => {
            callback (err, result)
        })
    },         

    // extended user SP to include join to email
    selectUserByEmail: function(data, callback ) {
        var params = `("${data.emailAddress}")`
        db.dbo.query('CALL selectUserByEmail' + params, (err, result) => {
            callback (err, result)
        })
    },         

    updateUser: function(data, callback ) {
        var params = `("${data.idEntity}","${data.userName}","${data.userPassword}","${data.userSalt}","${data.userPrimaryEmail}", ${data.userTimeZone} )`
        db.dbo.query('CALL updateUser ' + params, (err, result) => {
            callback(err, result);
        });            
    },

    updateUserProfile: function(data, callback ) {
        var params = `("${data.idEntity}","${data.userName}","${data.userTimeZone}")`
        db.dbo.query('CALL updateUserProfile ' + params, (err, result) => {
            callback(err, result);
        });            
    },

    updateUserPrimaryEmail: function(data, callback ) {
        var params = `("${data.idEntity}","${data.userPrimaryEmail}")`
        db.dbo.query('CALL updateUserPrimaryEmail ' + params, (err, result) => {
            callback(err, result);
        });
    },

    deleteUser: function(data, callback ) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL deleteUser' + params, (err, result) => {
            callback (err, result)
        })
    }

};
