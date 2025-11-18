// email.test.js

// Import the email function from email.js
import email from './email.js';

// Define a test function to call the email function
const testEmail = async () => {
  try {
    // Define test parameters for sending an email
    const testAddress = 'carson.holmes@gmail.com'; // Replace with a valid email for testing
    const testSubject = 'Test Email Subject';
    const testMessage = '<h1>This is a test email</h1><p>This is the body of the test email.</p>';

    // Call the email function
    email(testAddress, testSubject, testMessage);
  } catch (error) {
    console.error(`Test failed: ${error.message}`);
  }
};

// Run the test
testEmail();
