import React from 'react';
import './About.css';
import {AppContext} from '../../AppContext'

function About() {
  const {appContext, setAppContext} = React.useContext(AppContext);

  const CloseAbout = ()=> { 
      var newContext = JSON.parse(JSON.stringify(appContext))
      newContext.authState = 'home'
      setAppContext(newContext)
  }

  return (
    // <div className={`About ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`}>
      <div className="About-content">
        <h1>About CapStream.io</h1>
        <p>
          Welcome to <strong>CapStream.io</strong>, a streamlined platform for managing real estate
          investment data. Our mission is to eliminate the friction investors face when tracking
          properties, positions, cash activity, and quarterly updates. With CapStream.io, your
          portfolio data is organized, accessible, and actionable.
        </p>
        <h2>Our Vision</h2>
        <p>
          <strong>CapStream.io</strong> was built to bridge the gap between scattered spreadsheets and institutional-grade
          systems. We believe private investors deserve a clean, intuitive tool that provides
          clarity on performance, cash flows, and projections—without requiring IT departments or
          steep learning curves.
        </p>
        <h2>How It Works</h2>
        <p>
          The platform is designed with a <em>data-entry first</em> approach, making it easy to capture
          the essentials of each investment. From property acquisition details to cash activities and
          quarterly updates, CapStream.io organizes information in a structured way so you can focus
          on making informed decisions.
        </p>
        <h2>Key Features</h2>
          <p><strong>Properties & Positions</strong>:&nbsp; Track investment details, ownership, targets, and sponsor notes.</p>
          <p><strong>Cash Activity</strong>:&nbsp; Record distributions, capital calls, sales proceeds, and more with simple entries.</p>
          <p><strong>Updates</strong>:&nbsp; Capture periodic updates, revised projections, and supporting attachments.</p>
          <p><strong>Attachments</strong>:&nbsp; Store offering memorandums, update reports, and cash statements in one place.</p>
          <p><strong>Dashboard (Coming Soon)</strong>:&nbsp; High-level KPIs like YTD cash flow, upcoming distributions, and performance alerts.</p>
        <h2>Contact Us</h2>
        <p>
          Questions or feedback? Reach out to us at{" "}
          <a href="mailto:support@capstream.io">support@capstream.io</a>. Your insights are essential
          in helping us make <strong>CapStream.io</strong> the go-to solution for investment tracking.
        </p>
      </div>
    // </div>
  );
}

export default About;
