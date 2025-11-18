import React, {useState} from 'react'
import { AppContext } from '../../AppContext'
import './Menu.css'
import MenuLink from '../controls/MenuLink/MenuLink'
import icons from '../../shared/icons'
import { FEATURE_ITEMS, FEATURE_FEED, FEATURE_POSTS, FEATURE_CONTACTS, FEATURE_GROUPS, FEATURE_PLACES }
    from '../../shared/featureFlags'

const Menu = (props) => {

    const {appContext, setAppContext} = React.useContext(AppContext)
    const [showMenu, setShowMenu] = useState(false)

    const clickHome = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'home'
        setAppContext(newContext)
        setShowMenu(false)
    }

    const clickSignIn = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'signIn'
        setAppContext(newContext)
        setShowMenu(false)
    }

    const clickSignUp = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'signUp'
        setAppContext(newContext)
        setShowMenu(false)
    }

    const setHeight = () => {
        return {
            height: document.body.scrollHeight
        }
    }

    return (
        <>
            <div className='hamburger-container'>
                <img className='hamburger-icon' src={icons.hamburgerIcon} onClick={()=>setShowMenu(true)}
                    alt='Menuburger'/>
            </div>
            {showMenu && 
                <>
                    <nav className='menu' style={setHeight()} aria-label='primary navigation'>
                        <img className='close-x' onClick={()=>setShowMenu(false)} src={icons.closeIcon}
                            alt='Close'></img>
                        <MenuLink to='/' onClick={clickHome} src={icons.homeIcon}>Home</MenuLink>
                        <MenuLink to='/browse' onClick={()=>setShowMenu(false)} src={icons.browseIcon}>
                            Browse</MenuLink>
                        {/* <MenuLink to='/calendar' onClick={()=>setShowMenu(false)} src={icons.eventsIcon}>
                            Calendar</MenuLink> */}
                        {FEATURE_FEED &&
                            <MenuLink to='/feed' onClick={()=>setShowMenu(false)} src={icons.feedIcon}>
                                Feed</MenuLink>}
                        {/*<hr/>*/}
                        <MenuLink to='/maintain/services' onClick={()=>setShowMenu(false)}
                            src={icons.servicesIcon} disabled={!appContext.signedIn}>Services</MenuLink>
                        {FEATURE_ITEMS &&
                            <MenuLink to='/maintain/items' onClick={()=>setShowMenu(false)}
                                src={icons.itemsIcon} disabled={!appContext.signedIn}>
                                Items</MenuLink>}
                        {FEATURE_POSTS &&
                            <MenuLink to='/maintain/posts' onClick={()=>setShowMenu(false)}
                                src={icons.postIcon} disabled={!appContext.signedIn}>
                                Posts</MenuLink>}
                        {/*<hr/>*/}
                        {FEATURE_CONTACTS &&
                            <MenuLink to='/maintain/contacts' onClick={()=>setShowMenu(false)}
                                src={icons.contactsIcon} disabled={!appContext.signedIn}>
                                Contacts</MenuLink>}
                        {FEATURE_GROUPS &&
                            <MenuLink to='/maintain/groups' onClick={()=>setShowMenu(false)}
                                src={icons.groupsIcon} disabled={!appContext.signedIn}>
                                Groups</MenuLink>}
                        {FEATURE_PLACES &&
                            <MenuLink to='/maintain/places' onClick={()=>setShowMenu(false)}
                                src={icons.placesIcon} disabled={!appContext.signedIn}>
                                Places</MenuLink>}
                        {!appContext.signedIn &&
                            <>
                                <hr/>
                                <MenuLink onClick={clickSignIn} src={icons.signInIcon}>
                                    Sign In</MenuLink>
                                <MenuLink onClick={clickSignUp} src={icons.signUpIcon}>
                                    Sign Up</MenuLink>
                            </>
                        }
                    </nav>
                    <div className='hazy-div' onClick={()=>setShowMenu(false)}></div>
                </>
            }
        </>
    )
}

export default Menu