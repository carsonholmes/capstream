// ** TEMPLATE (c) 2018-21 Unigrate, A Colorado Corporation **
// Table: email
import dalEmail from '../DAL/dalEmail.js';
import dalUser from '../dal/dalUser.js';
import emailer from '../shared/emailer.js';
import verifyCode from '../shared/verifyCode.js';

export default {
       
    selectEmailAll: function (callback) {
        dalEmail.selectEmailAll((err, data) => {
            callback(err, data);
        });            
    },

    loadEmail: function (data, callback) {
        dalEmail.selectEmailByEntity(data, (err, data) => {
            callback(err, data[0]);
        });            
    },

    testEmail: function (data, callback) {
        emailer.sendMail(data.data, data.template, (err, data) => {
            callback(err, 'email sent');
        });            
    },

    loadUserEmail: function (data, callback) {
        dalEmail.selectEmailByEntity(data, (errEmail, resultEmail) => {
            if (!errEmail && resultEmail && resultEmail[0])
                dalUser.selectUser({idEntity: data.idEntity}, (errEntity, resultEntity) => {
                    if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0]) {
                        let found = false;
                        for (let i=0; i<resultEmail.length && !found; i++) {
                            if (resultEmail[0][i].idEmail === resultEntity[0][0].userPrimaryEmail) {
                                found = true
                                resultEmail[0][i].primary = true
                            }
                        }
                        callback(false, resultEmail[0]);
                    }
                    else callback(false, {error: errEntity})
                })
            else callback(false, {error: errEmail})
        });            
    },

    insertEmail: function(data, callback ) {
        dalEmail.insertEmail(data, (err, result) => {
            callback(err,result)})          
    },
    
    updateEmail: function(data, callback ) { //assumes array of email addresses - ** TO DO ** bind updates to a transaction
        console.log('Update Email')
        for (let i = 0; i<data.length; i++) {
            console.table(data[i])
            if (data[i].new) {
                data[i].emailVerifyCode = verifyCode.generateVerifyCode()
                dalEmail.insertEmail(data[i], (errEmail, resultEmail) => {
                    if (!errEmail && resultEmail && resultEmail[0] && resultEmail[0][0])
                        if (data[i].primary) {
                            dalUser.selectUser({idEntity: data[i].idEntity}, (errUser, resultUser) => {
                                if (!errUser && resultUser && resultUser[0] && resultUser[0][0]) {
                                    resultUser[0][0].userPrimaryEmail = resultEmail[0][0].idEmail
                                    dalUser.updateUser(resultUser[0][0], (errUpdate, resultUpdate) => {
                                        if (errUpdate) console.log('Error updating primary email in user table.')
                                    })
                                }
                            })
                        }
                    else console.log('Error inserting new email address.')
                })}
            else dalEmail.updateEmail(data[i], (errEmail, resultEmail) => {
                if (data[i].primary && data[i].idEntity) {
                    dalUser.selectUser({idEntity: data[i].idEntity}, (errUser, resultUser) => {
                        if (!errUser && resultUser && resultUser[0] && resultUser[0][0]) {
                            if (resultUser[0][0].userPrimaryEmail !== data[i].idEmail) {
                                resultUser[0][0].userPrimaryEmail = resultEmail[0][0].idEmail
                                dalUser.updateUser(resultUser[0][0], (errUpdate, resultUpdate) => {
                                    if (errUpdate) console.log('Error updating primary email in user table.')
                                })
                            }
                        }
                    })
                }
            })
        }
        callback(false, {response: 'Success'})
    },

    deleteEmail: function(data, callback ) {
        dalEmail.deleteEmail(data, (err, result) => {
            callback(err, result);
        });            
    }

};
