import React, { useState } from 'react';
import '../styles/CookieConsent.css';

function CookieConsent({ darkMode, onAccept, onDecline }) {
  return (
    <div className={`CookieConsent ${darkMode ? 'dark-mode' : 'light-mode'}`}>  
      <p>Incrementum uses cookies to enhance the user experience.</p>
      <div className="CookieConsent-buttons">
        <button className="decline-button" onClick={onDecline}><i className="bi bi-x"></i> Decline</button>
        <button className="accept-button" onClick={onAccept}><i className="bi bi-check"></i> Accept</button>
      </div>
    </div>
  );
}

export default CookieConsent;
