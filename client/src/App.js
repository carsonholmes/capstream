import React from 'react'
import {BrowserRouter as Router} from 'react-router-dom'
import AppContextProvider from './AppContext'
import AppContentRouter from './components/AppContentRouter/AppContentRouter'
import ColorApplier from './components/ColorApplier'
import './App.css'
import '../src/components/controls/buttons/button.css'

const App = () => {
  return (
      <Router>
        <div className='app'>
          <AppContextProvider>
            <ColorApplier>
                <AppContentRouter />
            </ColorApplier>
          </AppContextProvider>
        </div>
      </Router>
  );
}

export default App;
