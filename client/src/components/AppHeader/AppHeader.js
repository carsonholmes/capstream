import React, {useState} from 'react'
import {AppContext} from '../../AppContext'
import './AppHeader.css'
import AppMenu from '../AppMenu/AppMenu'
import ProfileMenu from '../Profile/ProfileMenu/ProfileMenu'
import logo from '../../assets/images/capstream-icon.png'

const AppHeader = (props) => {

    const {appContext, setAppContext} = React.useContext(AppContext);
    const [profileMenuVisible, setProfileMenuVisible] = useState(false);
    const [appMenuVisible, setAppMenuVisible] = useState(false);
  
    const goHome = () => {
        window.location.href='/'
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'home'
        setAppContext(newContext)
    }
  

    const toggleProfileMenu = () => {
        setProfileMenuVisible(!profileMenuVisible);
    };

    const toggleAppMenu = () => {
        setAppMenuVisible(!appMenuVisible);
    };

    return (
        <header className='app-header'>
            <i className="bi bi-list hamburger-icon" onClick={toggleAppMenu}></i>
            <div className='app-title-container'>
                <img className='header-logo' src={logo} alt='logo' onClick={goHome}></img>
                CapStream.io
            </div>
            {appContext.signedIn ?
                <div className="profile-circle" onClick={toggleProfileMenu}> 
                    {appContext.personFirstName?.charAt(0)}{appContext.personLastName?.charAt(0)}
                </div> :
                <i className="bi bi-person profile-icon" onClick={toggleProfileMenu}></i>
            }
            {appMenuVisible && <AppMenu setAppMenuVisible={setAppMenuVisible}/>}
            {profileMenuVisible && <ProfileMenu setProfileMenuVisible={setProfileMenuVisible}/>}            
        </header>
    )
}

export default AppHeader