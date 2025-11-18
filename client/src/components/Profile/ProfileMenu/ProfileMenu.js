import React, { useEffect } from 'react';
import './ProfileMenu.css';
import {AppContext, emptyContext} from '../../../AppContext'

function ProfileMenu({ setProfileMenuVisible }) {
  const {appContext, setAppContext} = React.useContext(AppContext);
    
  const handleMenuClick = () => {
    // Hide the menu after any option is clicked
    setProfileMenuVisible(false);
  };
    
    const redirectHome = () => { if (window.location.pathname !== '/') window.location.href = '/'}

   const handleSignOutClick = () => {
          var newContext = {...emptyContext};
          newContext.signingOut = true;
          newContext.authState = 'home'
          setAppContext(newContext);  //might need to delete from local storage...
          setProfileMenuVisible(false)
          redirectHome()
    }
  
      const handleSignInClick = () => {
          var newContext = JSON.parse(JSON.stringify(appContext))
          newContext.authState = 'signIn'
          setAppContext(newContext)
          setProfileMenuVisible(false);
      }
  
      const handleSignUpClick = () => {
          var newContext = JSON.parse(JSON.stringify(appContext))
          newContext.authState = 'signUp'
          setAppContext(newContext)
      }
  
      const handleCancelClick = () => {
          var newContext = JSON.parse(JSON.stringify(appContext))
          var oldAuthState = newContext.authState
          newContext.authState = 'home'
          setAppContext(newContext)
          if (oldAuthState === 'authBlock') redirectHome()
      }

      const handleClientsClick = () => {
          var newContext = JSON.parse(JSON.stringify(appContext))
          var oldAuthState = newContext.authState
          newContext.authState = 'clients'
          setAppContext(newContext)
          if (oldAuthState === 'authBlock') redirectHome()
      }
  
  const toggleDarkMode = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.darkMode = !appContext.darkMode;
        setAppContext(newContext)
        setProfileMenuVisible(false);
  };

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (!event.target.closest('.ProfileMenu') && !event.target.closest('.profile-icon')) {
        setProfileMenuVisible(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [setProfileMenuVisible]);

  return (
    <div className={`ProfileMenu ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`} onClick={handleMenuClick}>
      {appContext.idEntity === null && appContext.authState !== "signIn" && (
        <div className="ProfileMenu-item" onClick={handleSignInClick}>
          <i className="bi bi-box-arrow-in-right"></i>
          <span>Sign In</span>
        </div>
      )}
      {appContext.idEntity === null && appContext.authState === "signIn" && (
        <div className="ProfileMenu-item cancel" onClick={handleCancelClick}>
          <i className="bi bi-box-arrow-in-right"></i>
          <span className="cancel">Cancel Sign In</span>
        </div>
      )}
      {appContext.idEntity === null && appContext.authState !== "signUp" && (
        <div className="ProfileMenu-item" onClick={handleSignUpClick}>
          <i className="bi bi-person-plus"></i>
          <span>Sign Up</span>
        </div>
      )}
      {appContext.idEntity === null && appContext.authState === "signUp" && (
        <div className="ProfileMenu-item cancel" onClick={handleCancelClick}>
          <i className="bi bi-person-plus"></i>
          <span>Cancel Sign Up</span>
        </div>
      )}
      {appContext.idEntity !== null && (
        <div className="ProfileMenu-item" onClick={handleClientsClick}>
          <i className="bi bi-people"></i>
          <span>Clients</span>
        </div>
      )}
      <div className="ProfileMenu-item" onClick={toggleDarkMode}>
        <i className={`bi ${appContext.darkMode ? 'bi-sun' : 'bi-moon'}`}></i>
        <span>{appContext.darkMode ? 'Light Mode' : 'Dark Mode'}</span>
      </div>
      {appContext.idEntity !== null && (
        <>
          <hr className="ProfileMenu-divider" />
            <div className="ProfileMenu-item" onClick={handleSignOutClick}>
            <i className="bi bi-box-arrow-right"></i>
            <span>Sign Out</span>
          </div>
        </>
      )}
    </div>
  );
}

export default ProfileMenu;
