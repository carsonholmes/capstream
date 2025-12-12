import React, {useState, useEffect} from 'react'
import './Home.css'
import {AppContext} from '../../AppContext'
import Button from '../controls/buttons/Button'
import ContentContainer from '../ContentContainer/ContentContainer'

const Home = (props) => {
    
    const {appContext, setAppContext} = React.useContext(AppContext)
    const [pageLoaded, setPageLoaded] = useState(false)

    useEffect(()=> {
        if (!pageLoaded) {
            setPageLoaded(true)
        }
    }, [props, pageLoaded])

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

    return (
        <ContentContainer>
            <div className={`home ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`}>
                <h1 className='home'>Welcome to CapStream.io</h1>
                <h2>Sign In or Sign Up to access CapStream functionality.</h2>
                <div className='home-button-container'>
                    <Button styleName='primary sign-in home' onClick={clickSignIn}>Sign In</Button>
                    <Button styleName='primary sign-in home' onClick={clickSignUp}>Sign Up</Button>
                </div>
            </div>
        </ContentContainer>
    )
}

export default Home