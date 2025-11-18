import React, { Fragment, useState } from 'react'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'

const serviceLocations = ['Online', 'In person', 'Both online & in person']

const SectionServiceLocation = (props) => {

    const [expandedSummary, setExpandedSummary] = useState(false)

    if (expandedSummary === false)
        return (
            <section className='entity-section compressed-section'>
                <div className='compressed-summary'>
                    <h3 className='section-heading'>Delivered:</h3>
                    <div className='short-summary'>{serviceLocations[props.data.serviceLocation]}</div>
                </div>
                <div className='summary-button-container'>
                {props.data.serviceLocation > 0 &&
                    <Fragment>
                        <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
                            tooltip='Expand Summary' onClick={()=>setExpandedSummary(true)}></IconButton>
                    </Fragment>
                }
                <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                    tooltip='Edit Service Location' onClick={props.onClick}>
                </IconButton>
                </div>
            </section>
        )
    else
        return (
            <section className='entity-section expanded-section'>
                <h3 className='section-heading'>Delivered:</h3>
                <div className='expanded-summary'>
                    <div>{serviceLocations[props.data.serviceLocation]}</div>
                    <div>Postal code: {props.data.area.postalCode}</div>
                </div>
                <div className='summary-button-container'>
                    {props.data.serviceLocation > 0 &&
                        <Fragment>
                            <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
                                tooltip='Compress Summary' onClick={()=>setExpandedSummary(false)}></IconButton>
                        </Fragment>
                    }
                    <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                        tooltip='Edit Service Location' onClick={props.onClick}>
                    </IconButton>
                </div>
            </section>
        )
}

export default SectionServiceLocation

{/* <section className='entity-section'>
{expandedSummary === false ?
    <div className='compressed-summary'>
        <h3 className='section-heading'>Delivered:</h3>
        <div className='short-summary'>{serviceLocations[props.data.serviceLocation]}</div>
    </div> :
    <div className='expanded-summary'>
        <h3 className='section-heading'>Delivered:</h3>
        <div>{serviceLocations[props.data.serviceLocation]}</div>
        <div>Postal code: {props.data.area.postalCode}</div>
    </div>
}
<div className='summary-button-container'>
    {props.data.serviceLocation > 0 &&
        <Fragment>
            {expandedSummary === false ?
                <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
                    tooltip='Expand Summary' onClick={()=>setExpandedSummary(true)}></IconButton> :
                <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
                    tooltip='Compress Summary' onClick={()=>setExpandedSummary(false)}></IconButton>
            }
        </Fragment>
    }
    <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
        tooltip='Edit Service Location' onClick={props.onClick}>
    </IconButton>
</div>
</section> */}