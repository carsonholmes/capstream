import React, { useState } from 'react';
import { AppContext } from '../../AppContext';
import ContentContainer from '../ContentContainer/ContentContainer';
import './Reporting.css';

// Dummy Data matching your structure
const dummyData = [
    {
        idProperty: 1,
        PropertyName: 'Oakwood Apartments',
        MonthlyCashflow: { Jan: 1000, Feb: 1200, Mar: 1100, Apr: 1000, May: 1000, Jun: 1000, Jul: 1000, Aug: 1000, Sep: 1000, Oct: 1000, Nov: 1000, Dec: 1000 },
        QuarterlyCashflow: { Q1: 3300, Q2: 3000, Q3: 3000, Q4: 3000 },
        AnnualCashflow: { Year2025: 12300, Year2026: 12500, Year2027: 13000, Year2028: 14000 }
    },
    {
        idProperty: 2,
        PropertyName: 'Sunset Condos',
        MonthlyCashflow: { Jan: 500, Feb: 500, Mar: 500, Apr: 500, May: 500, Jun: 500, Jul: 500, Aug: 500, Sep: 500, Oct: 500, Nov: 500, Dec: 500 },
        QuarterlyCashflow: { Q1: 1500, Q2: 1500, Q3: 1500, Q4: 1500 },
        AnnualCashflow: { Year2025: 6000, Year2026: 6000, Year2027: 6000, Year2028: 6000 }
    }
];

const Reporting = () => {
    const { appContext } = React.useContext(AppContext);
    const [view, setView] = useState('annual');

    // Helper to format currency
    const formatCurrency = (val) => new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(val || 0);

    // Configuration for dynamic mapping
    const getConfig = () => {
        if (view === 'monthly') return { 
            periods: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            dataKey: 'MonthlyCashflow',
            prefix: '' 
        };
        if (view === 'quarterly') return { 
            periods: ['Q1', 'Q2', 'Q3', 'Q4'],
            dataKey: 'QuarterlyCashflow',
            prefix: '' 
        };
        return { 
            periods: ['2025', '2026', '2027', '2028'],
            dataKey: 'AnnualCashflow',
            prefix: 'Year' // Matches 'Year2025' in your data
        };
    };

    const { periods, dataKey, prefix } = getConfig();

    // Calculate Column Totals (Vertical Sum)
    const getColumnTotal = (period) => {
        return dummyData.reduce((sum, prop) => sum + (prop[dataKey][prefix + period] || 0), 0);
    };

    // Calculate Row Totals (Horizontal Sum)
    const getRowTotal = (prop) => {
        return periods.reduce((sum, period) => sum + (prop[dataKey][prefix + period] || 0), 0);
    };

    // Grand Total (Bottom Right)
    const grandTotal = periods.reduce((sum, period) => sum + getColumnTotal(period), 0);

    return (
        <ContentContainer>
            <div className="reporting-container">
                <h2>{view.charAt(0).toUpperCase() + view.slice(1)} Cashflow</h2>
                
                <div className="radio-buttons">
                    {['monthly', 'quarterly', 'annual'].map((type) => (
                        <div key={type}>
                            <label>
                                <input
                                    type="radio"
                                    name="view"
                                    value={type}
                                    checked={view === type}
                                    onChange={(e) => setView(e.target.value)}
                                />
                                {type.charAt(0).toUpperCase() + type.slice(1)}
                            </label>
                        </div>
                    ))}
                </div>

                <div className="cashflow-grid" style={{ '--col-count': periods.length }}>
                    {/* Header Row */}
                    <div className="grid-cell header">Property</div>
                    {periods.map(p => <div key={p} className="grid-cell header">{p}</div>)}
                    <div className="grid-cell header total-col">Total</div>

                    {/* Dynamic Data Rows */}
                    {dummyData.map((prop) => (
                        <React.Fragment key={prop.idProperty}>
                            <div className="grid-cell prop-name">{prop.PropertyName}</div>
                            {periods.map((period) => (
                                <div key={period} className="grid-cell data-cell">
                                    {formatCurrency(prop[dataKey][prefix + period])}
                                </div>
                            ))}
                            <div className="grid-cell total-col row-total">
                                {formatCurrency(getRowTotal(prop))}
                            </div>
                        </React.Fragment>
                    ))}

                    {/* Footer Total Row */}
                    <div className="grid-cell footer">Total</div>
                    {periods.map((period) => (
                        <div key={period} className="grid-cell footer">
                            {formatCurrency(getColumnTotal(period))}
                        </div>
                    ))}
                    <div className="grid-cell footer total-col">
                        {formatCurrency(grandTotal)}
                    </div>
                </div>
            </div>
        </ContentContainer>
    );
};

export default Reporting;