import React, { useState, useEffect } from 'react'
// export const AppContext = React.createContext()
export const emptyContext = {
    signedIn: false,
    signingOut: false,
    authState: 'home',  //state of authentication workflow
    idEntity: null,
    avatarRefresh: false,
    userName: null,
    personFirstName: "",
    personLastName: "",
    emailAddress: null,
    emailVerified: null,
    idSession: null,
    darkMode: false,
    activeClient: null,
    activeClientName: null,
    activeColor: '#4b8d96',
}

export const AppContext = React.createContext({
  appContext: emptyContext,
  setAppContext: () => {}
})

const AppContextProvider = (props) => {
    const [appContext, setAppContext] = useState(() => {
        const localData = localStorage.getItem('appContext')  //tries to get appContext from local storage
        return localData ? JSON.parse(localData) : emptyContext  //if it finds it use that, otherwise empty
    })
    useEffect(() => {
        localStorage.setItem('appContext', JSON.stringify(appContext))  // * to do * - determine way to encrypt / decrypt this
    }, [appContext])

    return (
        <AppContext.Provider value={{ appContext, setAppContext }}>
            {props.children}
        </AppContext.Provider>
    )
}

export default AppContextProvider