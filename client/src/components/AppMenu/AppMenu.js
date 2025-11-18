import React, { useEffect } from 'react';
import './AppMenu.css';
import {AppContext} from '../../AppContext'

function AppMenu({ darkMode, setAppMenuVisible }) {
  const {appContext, setAppContext} = React.useContext(AppContext);
    
  const handleMenuClick = (menuOption) => {
      var newContext = JSON.parse(JSON.stringify(appContext))
      newContext.authState = menuOption
      setAppContext(newContext)
      setAppMenuVisible(false);
  };

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (!event.target.closest('.AppMenu') && !event.target.closest('.hamburger-icon')) {
        setAppMenuVisible(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [setAppMenuVisible]);

  return (
    <div className={`AppMenu ${darkMode ? 'dark-mode' : 'light-mode'}`}>
      <div className="AppMenu-item" onClick={() => handleMenuClick('home')}>
        <i className="bi bi-house"></i>
        <span>Home</span>
      </div>
      {appContext.signedIn &&
        <>
          <div className="AppMenu-item" onClick={() => handleMenuClick('positions')}>
            <i className="bi bi-building"></i>
            <span>Positions</span>
          </div>
          <div className="AppMenu-item" onClick={() => handleMenuClick('updates')}>
            <i className="bi bi-pencil-square"></i>
            <span>Updates</span>
          </div>
          <div className="AppMenu-item" onClick={() => handleMenuClick('cash-activity')}>
            <i className="bi bi-cash-coin"></i>
            <span>Cash Activity</span>
          </div>
        </>
      }
      <hr className="ProfileMenu-divider" />
      <div className="AppMenu-item" onClick={() => handleMenuClick('about')}>
        <i className="bi bi-info-circle"></i>
        <span>About</span>
      </div>
    </div>
  );

}

export default AppMenu;
