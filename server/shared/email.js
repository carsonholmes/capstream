// email.js
import { EmailClient } from "@azure/communication-email";
import config from "../config.js";

const client = new EmailClient(config.azureEmail.connectionString);

const htmlToPlainText = (html) => {
  if (!html) return "";

  const textWithNewLines = html.replace(/<br\s*\/?>/gi, "\n");
  const plainText = textWithNewLines.replace(/<\/?[^>]+(>|$)/g, "");

  return plainText.trim();
};

const email = async (address, subject, message) => {
  const emailMessage = {
    senderAddress: config.azureEmail.senderAddress,
    content: {
      subject,
      plainText: htmlToPlainText(message),
      html: message,
    },
    recipients: {
      to: [{ address }],
    },
  };

  // Optional reply-to (so users can reply to support@capstream.io)
  if (config.azureEmail.replyTo) {
    emailMessage.replyTo = [{ address: config.azureEmail.replyTo }];
  }

  try {
    const poller = await client.beginSend(emailMessage);
    const result = await poller.pollUntilDone();

    if (!result || result.status !== "Succeeded") {
      console.error("Email not sent successfully. Status:", result?.status, result);
    } else {
      console.log("Email sent. Message ID:", result.id);
    }
  } catch (err) {
    console.error("Error sending email via Azure Communication Services:", err);
    throw err;
  }
};

export default email;