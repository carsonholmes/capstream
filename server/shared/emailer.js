import os from "os"
import nodemailer from 'nodemailer'
import config from '../config.js'
import fs from 'fs'

var hostname = os.hostname()

console.log("Email services configured")
var emailHTML = fs.readFileSync('./shared/email.html').toString();
var verifyEmailHTML = fs.readFileSync('./shared/verifyEmail.html').toString();
var forgotPasswordEmailHTML = fs.readFileSync('./shared/forgotPasswordEmail.html').toString();
console.log("Email template loaded")


var transporter = nodemailer.createTransport({
    host: config.smtp.host,
    port: config.smtp.port,
    secure: config.smtp.secure,
	auth: {
		user: config.smtp.user,
		pass: config.smtp.password
    }
})

const sameDate = (d1, d2) => {
	// are d1 and d2 the same date?
	if (d1 && d1.getFullYear)
		return (d1.getFullYear() === d2.getFullYear() && d1.getMonth() === d2.getMonth() &&
			d1.getDate() === d2.getDate())
	else return true
}

//email templates
const VERIFY_EMAIL = null
export const FORGOT_PASSWORD = 1
//const SUGGESTION = 2
export const GET_USER_NAME = 3
//const ADMIN_EMAILS = 'carson.holmes@gmail.com'


export default {

	formatDateAndTimeRange: function (data) {
		//assumes data has elements dtStart, dtEnd, timezoneOffset, timezone
		let dtServer = new Date()
		// console.log('formatDateAndTimeRange')
		// console.log(timezoneOffset)
		// console.log(dtServer.getTimezoneOffset())
		let start = new Date(new Date(data.dtStart).getTime() - 
			((data.timezoneOffset-dtServer.getTimezoneOffset())*60000))
		let end = new Date(new Date(data.dtEnd).getTime() - 
			((data.timezoneOffset-dtServer.getTimezoneOffset())*60000))
		let dateAndTime = start.toDateString()
		dateAndTime += ',  ' + start.toLocaleTimeString('en-US', {timeStyle: 'short'})
		dateAndTime += ' - '
		if (!sameDate(start, end)) dateAndTime += end.toDateString() + ',  '
		dateAndTime += end.toLocaleTimeString('en-US', {timeStyle: 'short'})
		dateAndTime += ' ' + data.timezone
		return dateAndTime	
	},

	sendMail: function ( data, template, callback ) {
		var mailOptions = {
			from: config.smtp.from,
			to: data.emailAddress,
			subject: '',
			text: '',           
			html: ''
		  }
		
		switch (template) {
			case VERIFY_EMAIL:
				mailOptions.subject = 'Verify Email Address',  //'Verify Email Address ✔'
				mailOptions.text = 'Thanks for registering with CapStream.  Please use this code to verify your email address: ' 
					+ data.emailVerifyCode,           
				mailOptions.html = emailHTML.replace('%EMAIL_BODY_DATA%',verifyEmailHTML.
					replace(/%VERIFY-CODE%/g, data.emailVerifyCode))
				break
			case FORGOT_PASSWORD:
				mailOptions.subject = 'Reset Password'			
				mailOptions.text = 'To reset your password, please click this link: ' + config.server.client + 
					'/' + 'reset-password' + '/' + data.idSession
				mailOptions.html = emailHTML.replace('%EMAIL_BODY_DATA%',forgotPasswordEmailHTML.
					replace(/%FORGOT_PASSWORD_LINK%/g, config.server.client + '/' + 'reset-password' + '/' +
						data.idSession))
				break
			case GET_USER_NAME:
				mailOptions.to = data[0].emailAddress
				mailOptions.subject = `CapStream User Name${(data.length>1) ? 's' : ''}`
				mailOptions.text = `The following CapStream user name${(data.length>1) ? 's were' : ' was'} found for this email address:\n`
				data.forEach(element => {
					mailOptions.text += `${element.userName}\n`
				});
				mailOptions.html = mailOptions.text.replace(/\n/g,'<br />')
				break
			
		}
		// send mail with defined transport object
		//console.table(mailOptions)
		transporter.sendMail(mailOptions, function (error, info) {
			var result = {}
			if (error) {
				result.response = 'Error: ' + error
			}
			else result.response = 'Success'
			console.log("Email result:")
			console.log(result.response)
			callback(result)
		})
	},
}
