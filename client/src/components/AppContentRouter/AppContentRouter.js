import React, {useState, useEffect} from 'react'
import { Routes, Route } from 'react-router-dom'
import {AppContext} from '../../AppContext'
import Home from '../Home/Home'
import About from '../About/About'
import Dashboard from '../Dashboard/Dashboard'
import Reporting from '../Reporting/Reporting'
import PropertiesAndPositions from '../PropertiesAndPositions/PropertiesAndPositions'
import Updates from '../Updates/Updates'
import CashActivity from '../CashActivity/CashActivity'
import Clients from '../Clients/Clients'
import SignIn from '../Profile/SignIn/SignIn'
import SignUp from '../Profile/SignUp/SignUp'
import VerifyEmail from '../Profile/SignUp/VerifyEmail'
import ForgotPassword from '../Profile/ForgotPassword/ForgotPassword'
import ChangePassword from '../Profile/ChangePassword/ChangePassword'
import ResetPassword from '../Profile/ResetPassword/ResetPassword'
import Profile from '../Profile/Profile'
import Browse from '../Browse/Browse'
import AppHeader from '../AppHeader/AppHeader'
import AppFooter from '../AppFooter/AppFooter'
import { loadFromSessionStorage, storeToSessionStorage, loadFromLocalStorage} from '../../shared/storage'
import ClientBanner from '../ClientBanner/ClientBanner'

// import ConfirmBookings from '../Calendar/ConfirmBookings'
  
const AppContentRouter = (props) => {
    const {appContext, setAppContext} = React.useContext(AppContext)
    const [searchCriteria, setSearchCriteria] = useState({searchValue: null})
    const [passedLock, setPassedLock] = useState(false)
    
    useEffect(()=>{
        if (!searchCriteria.searchValue) {
            var cachedCriteria = loadFromSessionStorage('searchCriteria')
            if (cachedCriteria.searchValue) setSearchCriteria(cachedCriteria)
        }
    }, [searchCriteria])

    const newSearch = (newSearchCriteria) => {
        storeToSessionStorage('searchCriteria', newSearchCriteria)
        setSearchCriteria(newSearchCriteria)
    }

    const resetSigningOut = () => {
        if (window.location.pathname.length === 1) {
            var newContext = appContext
            newContext.signingOut = false
            setAppContext(newContext)
        }
    }

    const scrollToTop = () => {
        window.scrollTo(0, 0)
    }

    const mainContent = () => {
        switch (appContext.authState) {
            case 'verifyEmail': {
                setTimeout(scrollToTop, 1);
                return <VerifyEmail />;
                }
            case 'forgotPassword': {
                setTimeout(scrollToTop, 1);
                return <ForgotPassword />;
                }
            case 'signIn':
            case 'authBlock': {
                setTimeout(scrollToTop, 1);
                return <SignIn />;
                }
            case 'signUp': {
                setTimeout(scrollToTop, 1);
                return <SignUp />;
                }
            case 'clients': {
                setTimeout(scrollToTop, 1);
                return <Clients />;
                }
            case 'reporting':
                if (appContext.signedIn) {
                    if (appContext.activeClient && appContext.activeClientName !== "") {
                        return <>
                            <ClientBanner/>
                            <Reporting/>
                        </>
                    }
                    else return <Clients/>
                }
                else 
                    return (
                        <Home/>
                        // <Routes>
                        //     <Route
                        //         path="/"
                        //         element={
                        //         <>
                        //             {resetSigningOut()}
                        //             <Home clearSearch={newSearch} />
                        //         </>
                        //         }
                        //     />
                        //     <Route path="/assets" element={"What is up"} />
                        //     <Route path="/browse" element={<Browse />} />
                        //     <Route path="/change-password" element={<ChangePassword />} />
                        //     {/* <Route path="/confirm-bookings" element={<ConfirmBookings />} /> */}
                        //     <Route path="/profile" element={<Profile />} />
                        //     <Route path="/reset-password" element={<ResetPassword />} />
                        //     {/* catch-all */}
                        //     <Route path="*" element={"Page not found."} />
                        // </Routes>
                    );
            case "about":
                return (
                    <About />
                )
            case "positions":
                if (appContext.activeClient && appContext.activeClientName !== "") 
                    return (
                        <>
                            <ClientBanner/>
                            <PropertiesAndPositions />
                        </>)
                else return <Clients/>
            case "updates":
                if (appContext.activeClient && appContext.activeClientName !== "") 
                    return (
                        <>
                            <ClientBanner/>
                            <Updates />
                        </>)
                else return <Clients/>
            case "cash-activity":
                if (appContext.activeClient && appContext.activeClientName !== "") 
                    return (
                        <>
                            <ClientBanner/>
                            <CashActivity />
                        </>)
                else return <Clients/>
            default:
                return 'Page not found.';
        }
    };
    return (
        <div className={`app ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`}>
            <AppHeader setSearchCriteria={newSearch} searchCriteria={searchCriteria}></AppHeader>
                {mainContent()}
            <AppFooter></AppFooter>
        </div>
    )

}

export default AppContentRouter