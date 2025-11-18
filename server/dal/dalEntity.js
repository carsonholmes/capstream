// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: entity

import db from '../shared/db.js';

const ENTITY_USER = 1
const ENTITY_PERSON = 2
const ENTITY_POST = 3
const ENTITY_ITEM = 4
const ENTITY_SERVICE = 5
const ENTITY_EVENT = 6
const ENTITY_PLACE = 7
const ENTITY_GROUP = 8

export default {
       
    insertEntity: function(data, callback ) {
        var params = `("${data.entityTitle}", "${data.entityDesc}", "${data.entityType}")`
        db.dbo.query('CALL insertEntity ' + params, (err, result) => {
            callback(err, result);
        });            
    },

    selectEntity: function(data, callback ) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL selectEntity ' + params, (err, result) => {
            callback(err, result);
        });            
    },

    selectEntityBySearch: function(data, callback ) {
        var params = `("${data.searchValue}")`
        db.dbo.query('CALL selectEntityBySearch ' + params, (err, result) => {
            callback(err, result);
        });            
    },

    selectEntityByEntityType: function(data, callback ) {
        var params = `("${data.entityType}")`
        db.dbo.query('CALL selectEntityByEntityType ' + params, (err, result) => {
            callback(err, result);
        });            
    },
    
    selectEntityByOwner: function(data, callback ) {
        var params = `("${data.idUser}","${data.entityType}")`
        db.dbo.query('CALL selectEntityByOwner ' + params, (err, result) => {
            callback(err, result);
        });            
    },
    
    updateEntity: function(data, callback ) {
        var params = `("${data.idEntity}","${data.entityTitle}", "${data.entityDesc}")`
        db.dbo.query('CALL updateEntity ' + params, (err, result) => {
            callback(err, result);
        });            
    },

    deleteEntity: function(data, callback ) {
        var params = `("${data.idEntity}")`
        db.dbo.query('CALL deleteEntity ' + params, (err, result) => {
            callback(err, result);
        });            
    }

};
