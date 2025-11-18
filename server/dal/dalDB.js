import db from '../shared/db.js';

export default {
    beginTransaction: function (callback) {
        db.dbo.beginTransaction( (err) => {
            callback(err)
        })
    },

    commitTransaction: function (callback) {
        db.dbo.commit( (err) => {
            callback(err)
        })  
    },

    rollbackTransaction: function (callback) {
        db.dbo.rollback( (err) => {
            callback(err)
        })  
    }

}