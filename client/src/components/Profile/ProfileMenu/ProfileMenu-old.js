import React, {useState, useEffect, useRef} from 'react'
import {AppContext, emptyContext} from '../../../AppContext'
import Button from '../../controls/buttons/Button'
import MenuLink from '../../controls/MenuLink/MenuLink'
import EntityImage from '../../EntityImage/EntityImage'
import icons from '../../../shared/icons'
import './ProfileMenu.css'
//uses styling from Menu.css

const ProfileMenu = (props) => {
    const {appContext, setAppContext} = React.useContext(AppContext)
    const [showProfileMenu, setShowProfileMenu] = useState(false)
    const [avatarSize, setAvatarSize] = useState('x-small')
    const avatarContainer = useRef()
    // const [tipVisibility, setTipVisibility] = useState('hidden')

    useEffect(() => {
        const handleResize = () => {
            var newSize = avatarSize
            if (window.innerWidth >= 815) newSize = 'x-small'
            else newSize = 'xx-small'
            if (newSize !== avatarSize) {
                setAvatarSize( newSize )
            }
        }
        window.addEventListener("load", handleResize, true);
        window.addEventListener("resize", handleResize, true);
    });

    /**  THIS IS SIGN OUT **/
    const signOut = () => {
        setShowProfileMenu(false)
        var newContext = {...emptyContext};
        newContext.signingOut = true;
        setAppContext(newContext);  //might need to delete from local storage...
        //window.location.pathname = '../';   // redirect to home page to avoid AuthFrame on current page potentially, which will redirect to sign-in
    }

    const clickSignIn = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'signIn'
        setAppContext(newContext)
    }

    const clickSignUp = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        newContext.authState = 'signUp'
        setAppContext(newContext)
    }

    const clickCancel = () => {
        var newContext = JSON.parse(JSON.stringify(appContext))
        var oldAuthState = newContext.authState
        newContext.authState = 'home'
        setAppContext(newContext)
        if (oldAuthState === 'authBlock') redirectHome()
    }

    const redirectHome = () => { if (window.location.pathname !== '/') window.location.href = '/'}

    const setHeight = () => {
        return {
            height: document.body.scrollHeight
        }
    }

    return (
        <>
            <div ref={avatarContainer} className={props.styleName ? `avatar-container ${props.styleName}` :
                'avatar-container'}>
                {!appContext.signedIn && appContext.authState === 'home' &&
                    <Button styleName='primary sign-in' onClick={clickSignIn}>Sign In</Button>}
                {!appContext.signedIn && appContext.authState === 'home' &&
                    window.location.pathname.length === 1 &&   //length = 1 is '/' = home
                        <Button styleName='primary sign-in' onClick={clickSignUp}>Sign Up</Button>}
                {!appContext.signedIn && appContext.authState !== 'home' &&
                    <Button styleName='primary sign-cancel' onClick={clickCancel}>Cancel</Button>}
                {appContext.signedIn && !appContext.avatarRefresh && 
                    <EntityImage idEntity={appContext.idEntity} size={avatarSize}
                    onClick={()=>setShowProfileMenu(true)}  circular={true} alt='avatar'></EntityImage>}      
                {/* {appContext.signedIn && appContext.authState === 'home' && appContext.cartQuantity > 0 &&
                    <div className='cart-container'><span className='tooltip' style={{visibility: tipVisibility}}>
                        View Cart</span><img className='cart' src={cart} alt='cart' onClick={()=>{window.location.href='/view-cart'}}
                            onMouseOver={()=>setTipVisibility('visible')}
                            onMouseLeave={()=>setTipVisibility('hidden')}></img>
                        <div className='quantity-circle' onMouseOver={()=>setTipVisibility('visible')}
                            onMouseLeave={()=>setTipVisibility('hidden')} onClick={()=>{window.location.href='/view-cart'}}>
                                {appContext.cartQuantity}</div>
                    </div>} */}
            </div>
            {showProfileMenu &&
                <>
                    <nav className='menu profile-menu' style={setHeight()} aria-label='profile navigation'>
                        <img className='close-x left-x' onClick={()=>setShowProfileMenu(false)}
                            src={icons.closeIcon} alt='Profile avatar'></img>
                        <MenuLink to='/profile' onClick={()=>setShowProfileMenu(false)}
                            src={icons.profileIcon}>Profile</MenuLink>
                        <MenuLink to={'/view/' + appContext.idEntity} onClick={()=>setShowProfileMenu(false)}
                            src={icons.previewIcon} disabled={!appContext.signedIn}>My Public Page</MenuLink>
                        <MenuLink to='/availability' onClick={()=>setShowProfileMenu(false)}
                            src={icons.eventsIcon}>Calendar</MenuLink>
                        {/* <MenuLink to='/confirm-bookings' onClick={()=>setShowProfileMenu(false)}
                            src={icons.eventsIcon}>My Bookings (as provider)</MenuLink> */}
                        <MenuLink to='/confirm-bookings' onClick={()=>setShowProfileMenu(false)}
                            src={icons.eventsIcon}>My Bookings (as a customer)</MenuLink>
                        <MenuLink to={'/messages/'} onClick={()=>setShowProfileMenu(false)}
                            src={icons.messageIcon} disabled={!appContext.signedIn}>Messages</MenuLink>
                        <MenuLink to='/change-password' onClick={()=>setShowProfileMenu(false)}
                            src={icons.passwordIcon}>Change Password</MenuLink>
                        <MenuLink onClick={signOut} src={icons.signOutIcon}>Sign Out</MenuLink>
                    </nav>
                    <div className='hazy-div' onClick={()=>setShowProfileMenu(false)}></div>
                </>
            }
        </>
    )
}

export default ProfileMenu