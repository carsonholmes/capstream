import dalUser from '../dal/dalUser.js'
import dalUserSession from '../dal/dalUserSession.js'
import dalResetPasswordSession from '../dal/dalResetPasswordSession.js'
import dalEntity from '../dal/dalEntity.js'
import dalPerson from '../dal/dalPerson.js'
import dalEmail from '../dal/dalEmail.js'
import dalDB from '../dal/dalDB.js'
import bcrypt from 'bcryptjs'
import emailer, {GET_USER_NAME, FORGOT_PASSWORD} from "../shared/emailer.js"
import verifyCode from '../shared/verifyCode.js'
import dalNotification from '../dal/dalNotification.js'

const SESSION_TIMEOUT_MINS = 240
const RESET_PASSWORD_SESSION_TIMEOUT_MINS = 20
const ENTITY_TYPE_USER = 1

export default {

    loadUser: function(data, callback ) {
        dalUser.selectUser( data, (errUser, resultUser) => {
            if (!errUser && resultUser && resultUser[0] && resultUser[0][0]) 
                dalPerson.selectPerson( data, (errPerson, resultPerson) => {
                    if (!errPerson && resultPerson && resultPerson[0] && resultPerson[0][0]) 
                        dalEntity.selectEntity( data, (errEntity, resultEntity) => {
                            if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0]) {
                                resultUser[0][0].personFirstName = resultPerson[0][0].personFirstName
                                resultUser[0][0].personLastName = resultPerson[0][0].personLastName
                                resultUser[0][0].entityTitle = resultEntity[0][0].entityTitle
                                resultUser[0][0].entityDesc = resultEntity[0][0].entityDesc
                                resultUser[0][0].entityType = resultEntity[0][0].entityType
                                delete resultUser[0][0].userSalt
                                delete resultUser[0][0].userPassword
                                callback( false, resultUser[0][0])
                            }
                            else callback( false, {error: errEntity})
                        })
                    else callback(false, {error: errPerson})
                })
            else callback(false, {error: errUser})
        })
    },

    signInUser: function(data, callback ) {
        let result = {'response': 'Invalid credentials', session: {}, error: {}}
        // get user data
        if (data.userNameOrEmail.indexOf('@') === -1) {
           let credentials = {...data}
            credentials.userName = data.userNameOrEmail
            dalUser.selectUserByUserName(credentials, (errUser, resultUser) => {
                if (!errUser && resultUser && resultUser[0] && resultUser[0][0]) {
                    this.validateLogin(credentials, resultUser[0][0], callback, result)
                }
                else {
                    result.error = errUser
                    callback(false, result);
                }
            });
        }
        else {
            let credentials = {...data}
            credentials.emailAddress = data.userNameOrEmail
            dalUser.selectUserByEmail(credentials, (errUser, resultUser) => {
                if (!errUser && resultUser && resultUser[0] && resultUser[0][0]) {
                    if (resultUser[0].length>1) {
                        result.response = 'Multiple accounts'
                        callback(false, result)
                    }
                    else this.validateLogin(credentials, resultUser[0][0], callback, result)
                }
                else {
                    result.error = errUser
                    callback(false, result);
                }
            });
        }
    },

    validateLogin: function(data, user, callback, result) {
        bcrypt.hash(data.userPassword, user.userSalt, (errHash, hash) => {
            if (hash === user.userPassword) {        
                // retrieve primary email and it's verification status
                dalEmail.selectEmail( {idEmail: user.userPrimaryEmail}, (errEmail, resultEmail) => {
                    if (!errEmail && resultEmail && resultEmail[0] && resultEmail[0][0]) {
                        result.response = 'Success'
                        result.session = JSON.parse(JSON.stringify(user))
                        result.session.emailAddress = resultEmail[0][0].emailAddress
                        result.session.emailVerified = resultEmail[0][0].emailVerified
                        delete result.session.userSalt
                        delete result.session.userPassword
                        delete result.session.userPrimaryEmail
                        // create user session
                        dalUserSession.insertUserSession( user, (errSession, resultSession) => {
                            if (!errSession && resultSession && resultSession[0] && resultSession[0][0]) {
                                result.session.idSession = resultSession[0][0].idSession
                                callback(false, result)
                            }
                            else {
                                console.log("Login Successful.  Error creating User Session.") 
                                console.table(errSession)
                                result.error = errSession
                                callback(false, result)
                            }
                        })
                    }
                    else {
                        console.log("Login Successful.  Error retrieving primary email.") 
                        console.table(errEmail)
                        result.error = errEmail
                        callback(false, result)
                    }
                })
            }
            else {
                result.error = errHash
                callback(false, result)
            }
        })
    },

    insertUser: function(data, callback ) {
        console.log("Insert User")
        dalDB.beginTransaction( (errBeginTransaction) => {
            if (!errBeginTransaction) {
                var space = ''
                if (data.personFirstName.length > 0 && data.personLastName.length > 0) space = ' '
                var entityData = {entityTitle: data.personFirstName + space + data.personLastName, 
                                  entityType: ENTITY_TYPE_USER
                                ,  //1 = User
                                  entityDesc: '' }  
                dalEntity.insertEntity( entityData, (errEntity, resultEntity) => {
                    if (!errEntity && resultEntity[0] && resultEntity[0][0] && resultEntity[0][0].idEntity) {
                        var personData = { idEntity: resultEntity[0][0].idEntity, 
                                            personFirstName: data.personFirstName, 
                                            personLastName: data.personLastName}
                        dalPerson.insertPerson( personData, (errPerson, resultPerson) => {
                            if (!errPerson) {
                                var emailData = { idEntity: resultEntity[0][0].idEntity, 
                                                emailAddress: data.emailAddress,
                                                emailVerifyCode: verifyCode.generateVerifyCode() }
                                dalEmail.insertEmail( emailData, (errEmail, resultEmail) => {
                                    if (!errEmail && resultEmail[0] && resultEmail[0][0] && resultEmail[0][0].idEmail) {
                                        var userData = { idEntity: resultEntity[0][0].idEntity, 
                                            userName: data.userName,
                                            userPassword: data.userPassword,
                                            userSalt: data.userSalt,
                                            userPrimaryEmail: resultEmail[0][0].idEmail}
                                        dalUser.insertUser( userData, (errUser, resultUser) => {
                                            if (!errUser) {
                                                let newNotificationData = dalNotification.getEmptyRow()
                                                newNotificationData.idEntity = userData.idEntity
                                                dalNotification.insertNotification( newNotificationData, (errNotification, resultNotification) => {
                                                    if (!errNotification) {
                                                        var sessionData = { idEntity: userData.idEntity }
                                                        dalUserSession.insertUserSession( sessionData, (errSession, resultSession) => {
                                                            if (!errSession && resultSession[0] && resultSession[0][0] && resultSession[0][0].idSession) {
                                                                dalDB.commitTransaction( (errCommitTransaction) => {
                                                                    if (!errCommitTransaction) {
                                                                        var newUserData = {idEntity: userData.idEntity,
                                                                                        userName: data.userName,
                                                                                        entityTitle: entityData.entityTitle,
                                                                                        emailAddress: data.emailAddress,
                                                                                        personFirstName: data.personFirstName,
                                                                                        personLastName: data.personLastName,
                                                                                        emailVerifyCode: emailData.emailVerifyCode,
                                                                                        idSession: resultSession[0][0].idSession}
                                                                        emailer.sendMail(newUserData, null, (resultEmail)=>{
                                                                            if (resultEmail.response==='Success') {
                                                                                delete newUserData.emailVerifyCode
                                                                                newUserData.response = resultEmail.response
                                                                                callback(false, newUserData)
                                                                            }
                                                                            else {
                                                                                callback(false, {error: resultEmail.response})
                                                                            }
                                                                        })
                                                                    }
                                                                    else callback( false, {error: errCommitTransaction})
                                                                })
                                                            }
                                                            else dalDB.rollbackTransaction( (e) => {callback( false, {error: errSession})})
                                                        })
                                                    }
                                                    else dalDB.rollbackTransaction( (e) => {callback( false, {error: errNotification})})
                                                })
                                            }
                                            else dalDB.rollbackTransaction( (e) => {callback( false, {error: errUser})})
                                        })
                                    }
                                    else dalDB.rollbackTransaction( (e) => {callback( false, {error: errEmail})})
                                })
                            }
                            else dalDB.rollbackTransaction( (e) => {callback( false, {error: errPerson})})
                        })
                    }
                    else dalDB.rollbackTransaction( (e) => {callback( false, {error: errEntity})})
                })            
            }
            else callback( false, {error: errBeginTransaction})
        })
    },

    checkUserName: function(data, callback) {
        dalUser.selectUserByUserName(data, (err, result) => {
            if (!err && result && result[0] && result[0][0])
                callback(false, result[0][0])
            else 
                if (!err) callback(false, {response: 'Unique'})
                else callback( false, {error: err})
        })
    },

    verifyEmail: function(user, callback) {
        let result = {response: 'Unverified', error: {} }
        dalUser.selectUser(user, (errUser, resultUser) => {
            if (!errUser && resultUser && resultUser[0] && resultUser[0][0]) {
                dalEmail.selectEmail( {idEmail: resultUser[0][0].userPrimaryEmail}, (errEmail, resultEmail) => {
                    if (!errEmail && resultEmail && resultEmail[0] && resultEmail[0][0]) {
                        if (user.emailVerifyCode === resultEmail[0][0].emailVerifyCode) {
                            resultEmail[0][0].emailVerified = true
                            dalEmail.updateEmail(resultEmail[0][0], (errUpdate, resultUpdate) => {
                                if (!errUpdate) {
                                    result.response = 'Verified'
                                    callback (false, result)
                                }
                                else {
                                    console.log('Updating email to verified failed.')
                                    console.log(err3)
                                    result.error = errUpdate
                                    callback (false, result)
                                }
                            })
                        }
                        else {
                            callback (false, {response: 'Invalid code'})
                        }
                    }
                    else {
                        result.error = errEmail
                        callback (false, result)
                    }
                })
            }
            else {
                result.error = errUser
                callback (false, result)
            }
        })
    },

    verifySession: function(user, callback) {
        let result = {response: 'Invalid', error: {} }
        dalUserSession.selectUserSession( user, (errSession, resultSession) => {
            if (!errSession && resultSession && resultSession[0] && resultSession[0][0]) {
                if (resultSession[0][resultSession[0].length-1].idEntity === user.idEntity &&  !resultSession.done) {
                    var dtNow = new Date()    
                    var utc = dtNow.getTime() - (dtNow.getTimezoneOffset() * 60000);
                    var dtUTC = new Date(utc)
                    var dtSession = new Date(resultSession[0][resultSession[0].length-1].dtStarted)
                    var msInMin = 60 * 1000
                    if (dtUTC - dtSession < SESSION_TIMEOUT_MINS * msInMin) result.response = 'Valid'
                    else result.response = 'Expired'
                }
            }
            result.error = errSession
            callback( false, result)
        })
    },

    resendEmail: function(user, callback) {
        dalUser.selectUser( user, (errUser, resultUser) => {
            if (!errUser && resultUser && resultUser[0] && resultUser[0][0]) {
                dalEmail.selectEmail( {idEmail: resultUser[0][0].userPrimaryEmail}, (errEmail, resultEmail) => {
                    if (!errEmail && resultEmail && resultEmail[0] && resultEmail[0][0]) {
                        resultEmail[0][0].emailVerifyCode = verifyCode.generateVerifyCode()
                        dalEmail.updateEmail(resultEmail[0][0], (errUpdate, resultUpdate) => {
                            if (!errUpdate) {
                                emailer.sendMail(resultEmail[0][0],null,(resultEmail)=>{
                                    if (resultEmail.response==='Success') {
                                        callback(false, resultEmail)
                                    }
                                    else {
                                        console.log("Error sending email. " + resultEmail.response)
                                        callback(false, resultEmail)
                                    }
                                })
                            }
                            else callback(false, {response: 'Error updating email', error: errUpdate})
                        })
                    }
                    else callback(false, {response: 'Error retrieving email', error: errEmail})
                })
            }
            else callback(false, {response: 'Error retrieving user', error: errUser})
        })
    },

    forgotPassword: function(data, callback) {
        const atSymbolPosition = data.userNameOrEmail.indexOf('@')
        if (atSymbolPosition === -1) {
            dalUser.selectUserByUserName({userName: data.userNameOrEmail}, (errUser,result) => {
                if (!errUser && result && result[0] && result[0][0])
                    dalEmail.selectEmailByEntity({idEntity: result[0][0].idEntity}, (errEmail, resultEmail) => {
                        if (!errEmail && resultEmail && resultEmail[0] && resultEmail[0][0])
                            this.sendResetEmail( {idEntity: result[0][0].idEntity, emailAddress: resultEmail[0][0].emailAddress}, callback )
                        else callback( false, {response: 'Error retrieving email address for user', error: errEmail})
                    })
                else callback( false, {response: 'Error retrieving user by userName', error: errUser} )
            })
        }
        else  {
            dalUser.selectUserByEmail({emailAddress: data.userNameOrEmail}, (errUser, result) => {
                if (!errUser && result && result[0])
                    if (result[0].length > 1)
                        //multiple accounts linked to email address so send user names instead
                        this.forgotUserName({emailAddress: data.userNameOrEmail}, callback)
                    else
                        this.sendResetEmail(result[0][0], callback)
                else callback( false, {response: 'Error retrieving user by email address', error: errUser} )
            })
        }
    },

    sendResetEmail: function(data, callback) {
        if (data.idEntity) {
            dalResetPasswordSession.insertResetPasswordSession({idEntity: data.idEntity}, (err, resultSession) => {
                if (!err && resultSession && resultSession[0] && resultSession[0][0]) {
                    emailer.sendMail( {emailAddress: data.emailAddress, idSession: resultSession[0][0].idSession}, 
                                      FORGOT_PASSWORD, (resultEmail) => {
                        if (resultEmail.response === 'Success') {
                            callback(false, resultEmail)
                        }
                        else {
                            console.log("Error sending email. " + resultEmail.response)
                            callback(false, resultEmail)
                        }
                    })
                }
            })
        }
        else callback(false, {response: 'User not found'})
    },

    forgotUserName: function(data, callback) {
        dalUser.selectUserByEmail(data, (errUser, result) => {
            if (!errUser && result && result[0] && result[0][0]) {
                /* send email with user name(s) */
                emailer.sendMail(result[0], GET_USER_NAME, (resultEmail) => {
                    if (resultEmail.response === 'Success') {
                        console.log(resultEmail.response)
                        callback(false, resultEmail)
                    }
                    else {
                        console.log('Error sending email. ' + resultEmail.response)
                        callback(true, resultEmail)
                    }
                })
            }
            else {
                if (!errUser) callback(false, {error: errUser})
                else callback(false, {response: 'User not found'})
             
            }
        })           
    },

    resetPassword: function(data, callback) {
        //expects {newPassword, idSession} in user
        //get idEntity from idSession
        var result = {response: 'Not set', error: {}}
        dalResetPasswordSession.selectResetPasswordSession(data, (errSession, resultSession) => {
            if (!errSession && resultSession && resultSession[0] && resultSession[0][0] && resultSession[0][0].idEntity) {
                //found user reset password session
                var dbDate = new Date(resultSession[0][0].dtStarted)
                if (dbDate.getTime() > Date.now() - (RESET_PASSWORD_SESSION_TIMEOUT_MINS*60*1000)) {
                    //session still active
                    dalUser.selectUser(resultSession[0][0], (errUser, resultUser) => {
                        if (!errUser && resultUser && resultUser[0] && resultUser[0][0])
                            bcrypt.hash(data.userPassword, resultUser[0][0].userSalt, (err2, hash) => {
                                resultUser[0][0].userPassword = hash
                                dalUser.updateUser( resultUser[0][0], (errUpdate, resultUpdate) => {
                                    if (!errUpdate) {
                                        result.response = 'Success'
                                        callback(false, result)
                                    }
                                    else {
                                        result.response = 'Problem updating user password. Password not updated.'
                                        result.error = errUpdate
                                        callback (false, result)
                                    }
                                })
                            })
                        else {
                            result.response = 'Problem retrieving user with idEntity.'
                            result.error = errUser
                            callback (false, result)
                        }
                    })
                }
                else {
                    result.response = 'Expired'
                    callback(false, result)
                }
            }
            else {
                result.response = 'Invalid link to reset password.'
                console.log(result.response) // this really shouldn't happen, prossible hacking attempt
                callback(false, result)
            }
        })
    },

    changePassword: function(data, callback) {
        //expecting user with {idEntity, currentPassword, userPassword}
        var result = {response: 'Not expected response', error: {}}
        dalUser.selectUser( data, (errUser, resultUser) => {
            if (!errUser && resultUser && resultUser[0] && resultUser[0][0]) {
                // success retrieving salt and password hash from DB for idEntity
                // encrypt current password to compare against hash
                bcrypt.hash(data.currentPassword, resultUser[0][0].userSalt, (errHash, hash) => {
                    if (hash === resultUser[0][0].userPassword) {
                        //matched current hash, so encrypt new password and store new hash
                        bcrypt.hash(data.userPassword, resultUser[0][0].userSalt, (errHashNew, hashNew) => {
                            resultUser[0][0].userPassword = hashNew
                            dalUser.updateUser( resultUser[0][0], (errUpdate, resultUpdate) => {
                                if (!errUpdate) result.response = 'Success'
                                else {
                                    result.response = 'Error updating user with new password.' 
                                    result.error = errUpdate
                                    console.table(result)
                                    
                                }
                                callback (null, result)
                            })
                        })
                    }
                    else {
                        result.response = 'Current password is not correct.'
                        callback(null, result)
                    }
                })
            }
            else {
                result.response = 'Error retrieving user from database.'
                result.error = errUser
                callback(null, result)
            }
        })           
    },

    updateUser: function(data, callback ) {
        console.log('data.userTimeZone', data.userTimeZone)
        dalUser.updateUserProfile(data, (errUser, resultUser) => {
            if (!errUser) dalPerson.updatePerson(data, (errPerson, resultPerson) => {
                if (!errPerson) dalEntity.updateEntity(data, (errEntity, resultEntity) => {
                    if (!errEntity) callback(false, {response: 'Success'})
                    else callback(false, {error: errEntity})
                })
                else callback(false, {error: errPerson})
            })
            else callback(false, {error: errUser})
        })    
    }

    // deleteUser: function(data, callback ) {
    //     dalUser.deleteUser( data, (err, result) => {
    //         callback(err, result);
    //     });            
    // }

};
