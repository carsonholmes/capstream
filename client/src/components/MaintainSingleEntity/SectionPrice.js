import React, { useState } from 'react'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'
import { ENTITY_SERVICE } from '../../cdos/EntityCDO'
import { RATE_TIME_FRAMES } from '../../shared/serviceConstants'

const SectionPrice = (props) => {

    const [expandedSummary, setExpandedSummary] = useState(false)

    const displayPrice = (preferred) => {
        var price = preferred
        if (props.data.offer.negotiable && preferred === '') price += 'Negotiable'
        else {
            if (props.data.offer.price === 0) price += 'Free'
            else {
                if (props.data.offer.price % 1 === 0) price +=
                    Intl.NumberFormat('en-US', {style: 'currency', currency: 'USD', maximumFractionDigits: 0})
                        .format(props.data.offer.price) + ' ' +
                            RATE_TIME_FRAMES[props.data.offer.rateType].caption
                else price += Intl.NumberFormat('en-US', {style: 'currency', currency: 'USD'})
                    .format(props.data.offer.price) + ' ' + RATE_TIME_FRAMES[props.data.offer.rateType].caption
            }
        }
        return price
    }

    if (expandedSummary === false)
        return (
            <section className='entity-section compressed-section'>
                <h3 className='section-heading'>
                    {props.data.entityType === ENTITY_SERVICE ? 'Rate:' : 'Price:'}</h3>
                <div className='compressed-summary'>
                    <div className='short-summary'>{displayPrice('')}</div>
                </div> 
                <div className='summary-button-container'>
                    <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
                        tooltip='Expand Summary' onClick={()=>setExpandedSummary(true)}></IconButton>
                    <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                        tooltip='Edit Rate' onClick={props.onClick}>
                    </IconButton>
                </div>
            </section>
        )
    else
        return (
            <section className='entity-section expanded-section'>
                <h3 className='section-heading'>{props.data.entityType === ENTITY_SERVICE ? 'Rate:' : 'Price:'}</h3>
                <div className='expanded-summary'>
                    <div className='view-price'>{displayPrice('')}<br />
                        {props.data.rate.handlePayment ?
                            <span className='maintain-fairhub-handles'>FairHub handles the paymentttttttttttttttttttttttttt ttttttttttttttt.</span> :
                            <span className='maintain-fairhub-handles'>FairHub doesn't handle the paymenttttttttttttttttttttt ttttttttttttttttttttt.</span>}
                    </div>
                </div>
                <div className='summary-button-container'>
                    <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
                        tooltip='Compress Summary' onClick={()=>setExpandedSummary(false)}></IconButton>
                    <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                        tooltip='Edit Rate' onClick={props.onClick}>
                    </IconButton>
                </div>
            </section>
        )

    // return (
    //     <section className='entity-section'>
    //         {expandedSummary === false ?
    //             <div className='compressed-summary'>
    //                 <h3 className='section-heading'>{props.data.entityType === ENTITY_SERVICE ? 'Rate:' : 'Price:'}</h3>
    //                 <div className='short-summary'>{displayPrice('')}</div>
    //             </div> :
    //             <div className='expanded-summary'>
    //                 <h3 className='section-heading'>{props.data.entityType === ENTITY_SERVICE ? 'Rate:' : 'Price:'}</h3>
    //                 <div className='view-price'>{displayPrice('')}<br />
    //                     {props.data.rate.handlePayment ?
    //                         <span className='maintain-fairhub-handles'>FairHub handles the payment.</span> :
    //                         <span className='maintain-fairhub-handles'>FairHub doesn't handle the payment.</span>}
    //                 </div>
    //             </div>
    //         }
    //         <div className='summary-button-container'>
    //             {expandedSummary === false ?
    //                 <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
    //                     tooltip='Expand Summary' onClick={()=>setExpandedSummary(true)}></IconButton> :
    //                 <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
    //                     tooltip='Compress Summary' onClick={()=>setExpandedSummary(false)}></IconButton>
    //             }
    //             <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
    //                 tooltip='Edit Rate' onClick={props.onClick}>
    //             </IconButton>
    //         </div>
    //     </section>
    // )
}

export default SectionPrice