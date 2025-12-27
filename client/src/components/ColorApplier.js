import React from 'react';
import { useContext } from 'react';
import { AppContext } from '../AppContext';  // Better to import the context directly

const ColorApplier = ({ children }) => {
  const { appContext, setAppContext } = useContext(AppContext);  // Destructure properly

  if (!appContext) {
    // Optionally show a loader or fallback UI while context initializes
    return <>{children}</>;  // Or a spinner
  }

  const clientColor = appContext.activeColor || '#4b8d96';

  return (
    <div className="color-theme-applier" style={{ '--client-color': clientColor }}>
      {children}
    </div>
  );
};

export default ColorApplier;