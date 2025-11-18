import React, { Fragment, useState } from 'react'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'
import { formatText } from '../../shared/jsxFunctions'

const SectionDescription = (props) => {

    const [expandedSummary, setExpandedSummary] = useState(false)

    if (expandedSummary === false)
        return (
            <section className='entity-section compressed-section'>
                <div className='compressed-summary'>
                <h3 className='section-heading'>Description:</h3>
                    {props.data.length <= 0 ?
                        <span className='add-description text-align-left'>Click the edit icon to add a description.</span> :
                    <div className='short-summary summary-line-clamp compressed-description'>{formatText(props.data)}</div>}
                </div>
                <div className='summary-button-container'>
                    {props.data.length > 0 &&
                        <Fragment>
                            <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
                                tooltip='Expand Description' onClick={()=>setExpandedSummary(true)}></IconButton>
                        </Fragment>
                    }
                    <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                        tooltip='Edit Description' onClick={props.onClick}>
                    </IconButton>
                </div>
            </section>
        )
    else
        return (
            <section className='entity-section expanded-section'>
                    <h3 className='section-heading'>Description:</h3>
                    <div className='expanded-summary'>
                        <div className='text-align-left'>{formatText(props.data)}</div>
                    </div>
                <div className='summary-button-container'>
                    {props.data.length > 0 &&
                        <Fragment>
                            <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
                                tooltip='Compress Description' onClick={()=>setExpandedSummary(false)}></IconButton>
                        </Fragment>
                    }
                    <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                        tooltip='Edit Description' onClick={props.onClick}>
                    </IconButton>
                </div>
            </section>
        )
}

export default SectionDescription

               {/* <h3 className='section-heading'>Description:</h3>
                    {props.data.entityDesc.length <= 0 &&
                        <div className='value-and-edit-icon'>
                            <span className='add-description'>Click the edit icon to add a description</span>
                            <IconButton styleName='no-caption edit-icon' src={icons.editBlueIcon}
                                tooltip='Edit Description' onClick={()=>setEditSection(SECTION_DESCRIPTION)}>
                            </IconButton>
                        </div>}
                    {!isLongDesc && props.data.entityDesc &&
                        <div className='value-and-edit-icon'>
                            <section className='view-desc line-clamp'
                                ref={refDesc}>{formatText(props.data.entityDesc)}
                            </section>
                            <IconButton styleName='no-caption edit-icon' src={icons.editBlueIcon}
                                tooltip='Edit Description' onClick={()=>setEditSection(SECTION_DESCRIPTION)}>
                            </IconButton>
                        </div>}
                    {isLongDesc && !seeingMore &&
                        <Fragment>
                            <section className='view-desc line-clamp' ref={refDesc}>
                                {formatText(props.data.entityDesc)}</section>
                            <div className='see-more-less-and-edit-button'>
                            <button className='see-more-less' onClick={()=>setSeeingMore(true)}>
                                See more <img className='see-more-less' src={icons.seeMore} alt='see more'/>
                            </button>
                            <IconButton styleName='no-caption edit-icon' src={icons.editBlueIcon}
                                tooltip='Edit Description' onClick={()=>setEditSection(SECTION_DESCRIPTION)}>
                            </IconButton>
                            </div>
                        </Fragment>}
                    {isLongDesc && seeingMore &&
                        <Fragment>
                            <section className='view-desc' ref={refDesc}>
                                {formatText(props.data.entityDesc)}</section>
                            <div className='see-more-less-and-edit-button'>
                                <button className='see-more-less' onClick={()=>setSeeingMore(false)}>
                                    See less <img className='see-more-less' src={icons.seeLess} alt='see more'/>
                                </button>
                                <IconButton styleName='no-caption edit-icon' src={icons.editBlueIcon}
                                tooltip='Edit Description' onClick={()=>setEditSection(SECTION_DESCRIPTION)}>
                                </IconButton>
                            </div>
                        </Fragment>} */}