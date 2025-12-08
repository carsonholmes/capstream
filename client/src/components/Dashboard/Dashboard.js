import React from 'react'
import { AppContext } from '../../AppContext'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import './Dashboard.css'

const Dashboard = () => {
  const { appContext, setAppContext } = React.useContext(AppContext)

  const go = (target) => {
    // Prefer a router function if your app provides one on context:
    if (typeof appContext?.navigate === 'function') {
      appContext.navigate(target)
      return
    }
    // Fallback: raise an intent on context; outer shell can react to this.
    const next = { ...appContext, route: target }
    setAppContext(next)
  }

  return (
    <ContentContainer>
      <br></br>
      <div className={`Dashboard ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`}>
        <Card cardHeading='Dashboard'>
          Coming Soon
          {/* <div className='kpi-grid'>
            <div className='kpi'>
              <div className='kpi-label'>YTD Cash Flow</div>
              <div className='kpi-value'>$0</div>
              <div className='kpi-helper'>Distributions − calls (YTD)</div>
            </div>
            <div className='kpi'>
              <div className='kpi-label'>Next Expected Distribution</div>
              <div className='kpi-value'>—</div>
              <div className='kpi-helper'>Based on active positions’ cadence</div>
            </div>
            <div className='kpi'>
              <div className='kpi-label'>Variance Alerts</div>
              <div className='kpi-value'>0</div>
              <div className='kpi-helper'>vs. OM targets / latest update</div>
            </div>
          </div> */}
          <hr />
          <Card cardHeading='Recent Activity'>
            Coming Soon{/* <div className='empty-panel'>No recent activity yet.</div> */}
          </Card>
          <Card cardHeading='Upcoming'>
            Coming Soon{/* <div className='empty-panel'>No upcoming items.</div> */}
          </Card>
        </Card>
      </div>
    </ContentContainer>
  )
}

export default Dashboard
