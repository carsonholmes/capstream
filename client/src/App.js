import React from 'react'
import {BrowserRouter as Router} from 'react-router-dom'
import AppContextProvider from './AppContext'
import AppContentRouter from './components/AppContentRouter/AppContentRouter'
import './App.css'
import '../src/components/controls/buttons/button.css'

const App = () => {

  return (
      <Router>
        <div className='app'>
          <AppContextProvider>
            <AppContentRouter></AppContentRouter>
          </AppContextProvider>
        </div>
      </Router>
  );
}

export default App;
