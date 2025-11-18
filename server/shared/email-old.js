import nodemailer from 'nodemailer';
import config from '../config.js'

// Create a transporter object using SMTP transport
const transporter = nodemailer.createTransport({
  host: config.smtp.host, // Replace with your SMTP server (e.g., smtp.gmail.com for Gmail)
  port: config.smtp.port, // Use port 465 for secure connection or 587 for non-secure
  secure: config.smtp.secure, // Set to true if you are using port 465
  auth: {
    user: config.smtp.user, // Replace with your email address
    pass: config.smtp.password, // Replace with your email password
  },
});

const htmlToPlainText = (html) => {
    if (!html) return '';
  
    // Replace <br> or <br/> tags with newline characters
    const textWithNewLines = html.replace(/<br\s*\/?>/gi, '\n');
  
    // Remove all remaining HTML tags
    const plainText = textWithNewLines.replace(/<\/?[^>]+(>|$)/g, '');
  
    return plainText.trim();
  }

const email = (address, subject, message) => {
    const mailOptions = {
        from: config.smtp.from,
        to: address,
        subject: subject, 
        text: htmlToPlainText(message), 
        html: message
      };
      
      // Send the email
      transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
          return console.log(`Error occurred: ${error.message}`);
        }
        console.log(`Email sent: ${info.response}`);
      });     
}

export default email;