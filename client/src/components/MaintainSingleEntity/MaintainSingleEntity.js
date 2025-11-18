import React, { Fragment, useCallback, useEffect, useRef, useState } from 'react'
import TitleAndDescription from '../TitleAndDescription/TitleAndDescription'
import PrimaryEntityButtons from '../PrimaryEntityButtons/PrimaryEntityButtons'
import EditEntityImage from '../EditEntityImage/EditEntityImage'
import SelectLinkedContent from '../LinkedContent/SelectLinkedContent'
import CategorySelector from '../CategorySelector/CategorySelector'
import LocationSelector from '../LocationSelector/LocationSelector'
import Card from '../Card/Card'
import Offer from '../Offer/Offer'
import EntityImageArray from '../EntityImage/EntityImageArray'
import MicroLinkedContent from '../LinkedContent/MicroLinkedContent'
import RadioButtons from '../controls/RadioButtons/RadioButtons'
// import Dropdown from '../controls/Dropdown/Dropdown'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
import jsonFunctions from '../../shared/jsonFunctions'
import entityEditState from '../../shared/entityEditState'
import {SECTION_NONE, SECTION_TITLE, SECTION_MEDIA, SECTION_RATE, SECTION_SERVICE_LOCATION, 
    SECTION_DESCRIPTION, SECTION_CATEGORIES, SECTION_CANCELLATION_POLICY, 
    SECTION_DEPOSIT_REQUIREMENTS, SECTION_BOOKING_SETTINGS, SECTION_TIME_BLOCK_OPTIONS} 
    from '../../shared/entityEditSection'
import {ENTITY_TYPE, ENTITY_POST, ENTITY_SERVICE, ENTITY_TYPE_PLURAL,
    ENTITY_USER, ENTITY_ITEM, ENTITY_EVENT, ENTITY_PERSON,
    DEPOSIT_NOT_REQUIRED, DEPOSIT_UPON_BOOKING, DEPOSIT_UPON_CANCEL_LEAD, DEPOSIT_BEFORE_SERVICE, ENTITY_TYPE_LOWERCASE} from '../../cdos/EntityCDO'
import {LEAD_TYPES_SINGULAR, LEAD_TYPES_PLURAL, START_TIME_OPTIONS} from '../../shared/serviceConstants'
import './MaintainSingleEntity.css'
import MediaCDO from '../../cdos/MediaCDO'
// import CheckBox from '../controls/CheckBox/CheckBox'
// import HelpIcon from '../controls/HelpIcon/HelpIcon'
// import generateDropdownHelp from '../../shared/helper'
import EntityAttribute from '../EntityAttribute/EntityAttribute'
import BookingSettings from './BookingSettings'
import ServiceRateAndPayment from './ServiceRateAndPayment'
import ScaledImage from '../controls/ScaledImage/ScaledImage'
import mediaPath from '../../shared/mediaPath'
import { formatText } from '../../shared/jsxFunctions'
import HelpIcon from '../controls/HelpIcon/HelpIcon'
import { formatLeadTime, formatTimeBlockValues } from '../../shared/timeFunctions'
import addAnImage from '../../assets/images/AddAnImage.png'
import MaintainDescription from './MaintainDescription'
import MaintainTitle from './MaintainTitle'
import DepositRequirements from '../MaintainSingleEntity/DepositRequirements'
import CancellationPolicy from './CancellationPolicy'
import ServiceLocation from './ServiceLocation'
import MaintainCategories from './MaintainCategories'
import TimeBlockOptions from './TimeBlockOptions'
import SectionTitle from './SectionTitle'
import SectionPrice from './SectionPrice'
import SectionServiceLocation from './SectionServiceLocation'
import SectionDescription from './SectionDescription'

// uses styling from View.css

const cdo = new MediaCDO()
// const CONDITION_DATA = [{caption: 'Mint', value: 1001, description: 'Brand-spanking new in original packaging from manufacturer.'},
//                         {caption: 'New', value: 1002, description: 'New, not used.  Packaging opened, trial usage only.'},
//                         {caption: 'Used', value: 1003, description: 'Used but still in working condition.'},
//                         {caption: 'Damaged', value: 1004, description: 'Damaged beyond normal usage or not working.'}]

const MaintainSingleEntity = (props) => {

    const [editSection, setEditSection] = useState(SECTION_NONE)
    const [isLongDesc, setIsLongDesc] = useState(false)
    const [seeingMore, setSeeingMore] = useState(false)
    const refDesc = useRef()
    const refCard = useRef()
    const [summaryFlags, setSummaryFlags] = useState([
        {id: SECTION_RATE, expanded: false},
        {id: SECTION_SERVICE_LOCATION, expanded: false},
        {id: SECTION_DESCRIPTION, expanded: false},
        {id: SECTION_CATEGORIES, expanded: false},
        {id: SECTION_CANCELLATION_POLICY, expanded: false},
        {id: SECTION_DEPOSIT_REQUIREMENTS, expanded: false},
        {id: SECTION_BOOKING_SETTINGS, expanded: false},
        {id: SECTION_TIME_BLOCK_OPTIONS, expanded: false}
    ])

    useEffect(()=>{
        console.log('useEffect')
        if (refDesc.current) setIsLongDesc(refDesc.current.clientHeight < refDesc.current.scrollHeight) // check to see if line-clamp is hiding lines
    },[editSection])

    const updateData = (dataCol, newValue) => {
        let newData = {...props.data}
        newData[dataCol] = newValue
        props.updateData(dataCol, newValue)
    }

    // *** MEDIA FUNCTIONS ***
    const updateMedia = (mediaData) => {
        var newData = {...props.data}
        newData.media = jsonFunctions.deepCopy(mediaData)
        props.setData(newData)
    }

    const saveMedia = () => {
        setEditSection(SECTION_NONE)
    }

    const cancelMedia = () => {
        setEditSection(SECTION_NONE)
        var newData = {...props.data}
        for (var i = 0; i<newData.media.length; i++) {
            if (newData.media[i].newUpload ) {
                cdo.deleteData(newData.media[i], cbDeleteUpload)
            }
        }
        newData.media = jsonFunctions.deepCopy(props.originalData.media)
        props.setData(newData)
    }

    const cbDeleteUpload = (error, dbData) => {
        // nothing to do here
        if (!(!error && dbData && !dbData.error)) alert('Error removing media from server.')
    }

    const deleteMedia = (index) => {
        var newData = jsonFunctions.deepCopy(props.data)
        if (newData.media[index].newUpload) {
            cdo.deleteData(newData.media[index], cbDeleteUpload)
            newData.media.splice(index,1)
        }
        else {
            var newMedia = jsonFunctions.deepCopy(props.data.media[index])
            newMedia.markedForDeletion = true
            newData.media[index] = newMedia
        }
        props.setData(newData)
    }

    // *** CONTENT FUNCTIONS ***
    const updateContent = (entity) => {
        var newData = jsonFunctions.deepCopy(props.data)
        let found = -1
        for (let i=0; i<newData.content.length; i++) {
            if (newData.content[i].idEntity === entity.idEntity) {
                found = i
            }
        }
        if (found >=0 ) 
            if (newData.content[found].new) newData.content.splice(found,1)
            else if (newData.content[found].markedForDeletion) 
                    newData.content[found].markedForDeletion = false
                else newData.content[found].markedForDeletion = true
        else {
                entity.new = true
                newData.content.push(entity)
        }
        props.setData(newData)
    }

    const saveContent = () => {
        setEditSection(SECTION_NONE)
        // var newData = {...props.data}
        // var newContent = [...props.data.content]
        // newData.content = newContent
        // props.setData(newData)
    }

    const cancelContent = () => {
        setEditSection(SECTION_NONE)
        var newData = {...props.data}
        newData.content = [...jsonFunctions.deepCopy(props.originalData.content)]
        props.setData(newData)
    }

    // Category Functions
    const updateCategories = (idCategory) => {
        var newData = jsonFunctions.deepCopy(props.data)
        let found = -1
        for (let i=0; i<newData.category.length; i++) {
            if (newData.category[i].idCategory === idCategory) {
                found = i
            }
        }
        if (found >=0 ) {
            if (newData.category[found].new) newData.category.splice(found,1)
            else if (newData.category[found].markedForDeletion) 
                newData.category[found].markedForDeletion = false
            else newData.category[found].markedForDeletion = true
        }
        else {
            let category = {idCategory: idCategory,
                            new: true,
                            markedForDeletion: false}
            newData.category.push(category)
        }
        props.setData(newData)
    }

    const cancelCategories = () => {
        setEditSection(SECTION_NONE)
        var newData = {...props.data}
        newData.category = [...jsonFunctions.deepCopy(props.originalData.category)]
        props.setData(newData)
    }

    // Rate Functions
    const updateRate = (rateData) => {
        var newData = {...props.data}
        newData.rate = {...rateData}
        props.setData(newData)
    }
    
    // Offer Functions
    const updateOffer = (offerData) => {
        var newData = {...props.data}
        newData.offer = {...offerData}
        props.setData(newData)
    }

    const saveOffer = () => {
        setEditSection(SECTION_NONE)
    }

    const cancelOffer = () => {
        setEditSection(SECTION_NONE)
        var newData = {...props.data}
        newData.offer = jsonFunctions.deepCopy(props.originalData.offer)
        props.setData(newData)
    }

    const cancelEdit = () => {
        if (props.data.media.length>0) {
            for (var i = 0; i<props.data.media.length; i++) {
                if (props.data.media[i].new) cdo.deleteData(props.data.media[i], cbDeleteUpload)
            }
        }
        props.cancelEdit()
    }

    // const validateSaveTitle = () => {
    //     if (props.data.entityTitle) {
    //         props.saveData()
    //         setEditSection(SECTION_NONE)
    //     }
    //     else alert(ENTITY_TYPE_PLURAL[props.data.entityType] + ' must have a title to save.')
    // }

    const validateSave = () => {
        props.saveData()
        setEditSection(SECTION_NONE)
    }

    const saveData = (validateFunction) => {
        if (!validateFunction || validateFunction()) {
            props.saveData()
            setEditSection(SECTION_NONE)
        }
    }

    const handleClose = () => {
        if (props.data.entityTitle.length > 0) props.saveData()
        setEditSection(SECTION_NONE)
    }

    const setRef = (ref) => {
        refCard.current = ref
        window.scroll({
            top: window.scrollY + refCard.current.getBoundingClientRect().top - 28,
            behavior: 'smooth'
        })
    }

    const summarizeDepositRequirements = () => {
        if (props.data.offer.depositRequired===DEPOSIT_NOT_REQUIRED) return (
            <Fragment><div className='entity-summary'>None</div></Fragment>
        )
        let depositDue = ''
        if (props.data.offer.depositRequired === DEPOSIT_UPON_BOOKING) depositDue = 'due upon booking'
        else if (props.data.offer.depositRequired === DEPOSIT_UPON_CANCEL_LEAD) depositDue = 'due before cancellation lead-time'
        else if (props.data.offer.depositRequired === DEPOSIT_BEFORE_SERVICE) depositDue = 'due before service is rendered'
        return (
            <div className='entity-summary'>
                {props.data.offer.depositAmountType === 0 ?
                    <div className='text-align-left'>${props.data.offer.depositAmount}</div> :
                    <div className='text-align-left'>{props.data.offer.depositAmount}% of service fee</div>}
                <div>{depositDue}</div>
            </div>
        )
    }

    const summarizeCancellationPolicy = () => {
        if (!props.data.offer.cancelPolicyOn) return (
            <div><div className='entity-summary'>None</div></div>
        )
        else {
            let fee = ''
            let leadTypeOptions = []
            if (props.data.offer.cancelLeadNumber === 1) leadTypeOptions = LEAD_TYPES_SINGULAR
		    else leadTypeOptions = LEAD_TYPES_PLURAL
            if (props.data.offer.cancelFeeType === 0) fee += '$' + props.data.offer.cancelFee
            else fee += props.data.offer.cancelFee + '% of service fee'
            return  (
                <div className='entity-summary'>
                    <div className='text-align-left'>{fee}</div>
                    <div>with {props.data.offer.cancelLeadNumber} {leadTypeOptions[props.data.offer.cancelLeadType].caption} lead time</div>
                </div>
            )
        }
    }

    const summarizeTimeBlockOptions = () => {
        let maxBlock
        if (props.data.offer.maxTimeIncrement !== 0) maxBlock = <div className='text-align-left'>Maximum time-block: {formatTimeBlockValues(props.data.offer.maxTimeIncrement)}</div>
        return (
            <div className='entity-summary'>
                <div className='text-align-left'>Minimum time-block: {formatTimeBlockValues(props.data.offer.minTimeIncrement)}</div>
                {maxBlock}
                <div className='text-align-left'>Start time options: {START_TIME_OPTIONS[START_TIME_OPTIONS.findIndex(e=>e.value===props.data.offer.startTimeIncrement)].caption}</div>
            </div>
        )
    }

    const summarizeBookingSettings = () => {

        return (
            <div className='entity-summary'>
                <div className='text-align-left'>Confirm booking requests: {props.data.offer.confirmMethod === 0 ? 'Manually' : 'Automatically'}</div>
                {props.data.offer.bookingLeadNumber > 0 &&
                    <div className='text-align-left'>Booking lead-time: {formatLeadTime(props.data.offer.bookingLeadNumber,
                        props.data.offer.bookingLeadType)}</div>}
                <div className='text-align-left'>Customers per time-block: {props.data.offer.quantity}</div>
            </div>
        )
    }

    const getSelectedCategories = useCallback(() => {
        let selectedCategories = ''
        for (let category of props.data.category) {
            let index = props.categoryList.findIndex(cat => cat.idCategory === category.idCategory)
            if (selectedCategories === '') selectedCategories = props.categoryList[index].catDesc
            else selectedCategories += ', ' + props.categoryList[index].catDesc
        }
        return selectedCategories
    },[props.categoryList, props.data.category])

    const findSummaryFlagIndex = (section) => {
        return summaryFlags.findIndex(flag=>flag.id===section)
    }

    const expandSummary = (section) => {
        let newSummaryFlags = [...summaryFlags]
        newSummaryFlags[findSummaryFlagIndex(section)].expanded = true
        setSummaryFlags(newSummaryFlags)
    }

    const compressSummary = (section) => {
        let newSummaryFlags = [...summaryFlags]
        newSummaryFlags[findSummaryFlagIndex(section)].expanded = false
        setSummaryFlags(newSummaryFlags)
    }

    switch (editSection) {
        case SECTION_NONE: {
            return (
                <Card cardHeading={props.cardHeading} styleHeading='edit-entity-heading'
                    styleName='maintain-entity-card'>
                    <div className='maintain-entity-buttons'>
                        <IconButton styleName='no-caption' tooltip='Preview' 
                            disabled={(!props.dirty && !props.data.idEntity)}
                            onClick={()=>props.setMode('preview')}
                            src={((!props.dirty && !props.data.idEntity) ? icons.previewDisabledIcon :
                                icons.previewGreenIcon)}>
                        </IconButton>
                        <IconButton styleName='no-caption' tooltip='Close'
                            src={icons.closeGreenIcon} onClick={cancelEdit}>
                        </IconButton>
                    </div>
                    <SectionTitle entityTitle={props.data.entityTitle} onClick={()=>setEditSection(SECTION_TITLE)}>
                    </SectionTitle>
                    {props.data.offer.offerType === 0 &&
                        <div className='deactivated-notice'>
                            This {ENTITY_TYPE_LOWERCASE[props.data.entityType]} is deactivated and will not be seen by other users.
                        </div>
                    }
                    {/* Primary Image */}
                    {props.currentImageIndex >= 0 && props.data.media.length > 0 ?
                        <ScaledImage styleName='view-image maintain-entity-image' size='large'
                            src={mediaPath(props.currentImageIndex, props.data.media, props.data.idEntity,
                                props.data.entityType)}
                            left={props.data.media[props.currentImageIndex].xOffset}
                            top={props.data.media[props.currentImageIndex].yOffset}
                            scale={props.data.media[props.currentImageIndex].scale}
                            circular={props.data.entityType===ENTITY_USER}
                            onClick={()=>setEditSection(SECTION_MEDIA)}>
                        </ScaledImage> :
                        <ScaledImage styleName='view-image' size='large' left={0} top={0} scale={1}
                            src={addAnImage} onClick={()=>setEditSection(SECTION_MEDIA)}>
                        </ScaledImage>
                    }
                    {/* Media Strip */}
                    {props.currentImageIndex >= 0 && props.data.media.length > 1 &&
                        <EntityImageArray setCurrentImageIndex={props.setCurrentImageIndex} size='xx-small'
                        idEntity={props.data.idEntity} circular={props.data.entityType===ENTITY_USER}
                        data={props.data.media} currentImageIndex={props.currentImageIndex}
                        styleName='view-media-strip'>
                        </EntityImageArray>
                    }
                    {/* Price/Rate */}
                    {(props.data.entityType === ENTITY_ITEM || props.data.entityType === ENTITY_SERVICE ||
                        props.data.entityType === ENTITY_EVENT) &&
                        <SectionPrice onClick={()=>setEditSection(SECTION_RATE)}
                            data={props.data}></SectionPrice>
                    }
                    {/* Service Location */}
                    {props.data.entityType === ENTITY_SERVICE &&
                        <SectionServiceLocation data={props.data.offer}
                            onClick={()=>setEditSection(SECTION_SERVICE_LOCATION)}>
                        </SectionServiceLocation>
                    }
                    {/* Description */}
                    {(props.data.entityType === ENTITY_ITEM || props.data.entityType === ENTITY_SERVICE ||
                        props.data.entityType === ENTITY_EVENT) &&
                        <SectionDescription data={props.data.entityDesc}
                            onClick={()=>setEditSection(SECTION_DESCRIPTION)}></SectionDescription>
                    }
                    {/* Categories */} {console.log(props.data.category)}
                    {(props.data.entityType === ENTITY_ITEM || props.data.entityType === ENTITY_SERVICE ||
                        props.data.entityType === ENTITY_EVENT) &&
                        <section className='entity-section'>
                            {summaryFlags[findSummaryFlagIndex(SECTION_CATEGORIES)].expanded === false ?
                                <div className='compressed-summary'>
                                    <h3 className='section-heading'>Categories:</h3>
                                    {props.categoryList.length <= 0 ?
                                        <span className='add-description text-align-left'>Click the edit icon to add categories.</span> :
                                    <div className='short-summary summary-line-clamp compressed-description'>{getSelectedCategories()}</div>}
                                </div> :
                                <div className='expanded-summary'>
                                    <h3 className='section-heading'>Categories:</h3>
                                    <div className='text-align-left'>{getSelectedCategories()}</div>
                                </div>
                            }
                            <div className='summary-button-container'>
                                {props.categoryList.length > 0 &&
                                    <Fragment>
                                        {summaryFlags[findSummaryFlagIndex(SECTION_CATEGORIES)].expanded === false ?
                                            <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
                                                tooltip='Expand Categories' onClick={()=>expandSummary(SECTION_CATEGORIES)}></IconButton> :
                                            <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
                                                tooltip='Compress Categories' onClick={()=>compressSummary(SECTION_CATEGORIES)}></IconButton>
                                        }
                                    </Fragment>
                                }
                                <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                                    tooltip='Edit Categories' onClick={()=>setEditSection(SECTION_CATEGORIES)}>
                                </IconButton>
                            </div>
                        </section>
                    }
                    {/* Cancellation Policy */}
                    {props.data.entityType === ENTITY_SERVICE &&
                        <section className='entity-section'>
                            {summaryFlags[findSummaryFlagIndex(SECTION_CANCELLATION_POLICY)].expanded === false ?
                                <div className='compressed-summary'>
                                    <h3 className='section-heading'>Cancellation Policy:</h3>
                                    {props.data.offer.cancelPolicyOn ?
                                    <div className='short-summary'> On</div> :
                                    <div className='short-summary'> None</div>
                                    }
                                </div> :
                                <div className='expanded-summary'>
                                    <h3 className='section-heading'>Cancellation Policy:</h3>
                                    <div>{summarizeCancellationPolicy()}</div>
                                </div>
                            }
                            <div className='summary-button-container'>
                                {props.data.offer.cancelPolicyOn &&
                                    <Fragment>
                                        {summaryFlags[findSummaryFlagIndex(SECTION_CANCELLATION_POLICY)].expanded === false ?
                                            <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
                                                tooltip='Expand Summary' onClick={()=>expandSummary(SECTION_CANCELLATION_POLICY)}></IconButton> :
                                            <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
                                                tooltip='Compress Summary' onClick={()=>compressSummary(SECTION_CANCELLATION_POLICY)}></IconButton>
                                        }
                                    </Fragment>
                                }
                                <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                                    tooltip={props.data.offer.cancelPolicyOn ? 'Edit Cancellation Policy' :
                                        'Add Cancellation Policy'} onClick={()=>setEditSection(SECTION_CANCELLATION_POLICY)}>
                                </IconButton>
                            </div>
                        </section>
                    }
                    {props.data.entityType === ENTITY_SERVICE &&
                        <section className='entity-section'> {/* Deposit Requirements */}
                            {summaryFlags[findSummaryFlagIndex(SECTION_DEPOSIT_REQUIREMENTS)].expanded === false ?
                                <div className='compressed-summary'>
                                    <h3 className='section-heading'>Deposit:</h3>
                                    {props.data.offer.depositRequired > 0 ?
                                    <div className='short-summary'> Required</div> :
                                    <div className='short-summary'> None</div>
                                    }
                                </div> :
                                <div className='expanded-summary'>
                                    <h3 className='section-heading'>Deposit:</h3>
                                    <div>{summarizeDepositRequirements()}</div>
                                </div>
                            }
                            <div className='summary-button-container'>
                                {props.data.offer.depositRequired > 0 &&
                                    <Fragment>
                                        {summaryFlags[findSummaryFlagIndex(SECTION_DEPOSIT_REQUIREMENTS)].expanded === false ?
                                            <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
                                                tooltip='Expand Summary' onClick={()=>expandSummary(SECTION_DEPOSIT_REQUIREMENTS)}></IconButton> :
                                            <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
                                                tooltip='Compress Summary' onClick={()=>compressSummary(SECTION_DEPOSIT_REQUIREMENTS)}></IconButton>
                                        }
                                    </Fragment>
                                }
                                <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                                    tooltip={props.data.offer.depositRequired > 0 ? 'Edit Deposit Requirements' :
                                        'Add Deposit Requirements'} onClick={()=>setEditSection(SECTION_DEPOSIT_REQUIREMENTS)}>
                                </IconButton>
                            </div>
                        </section>
                    }
                    {props.data.entityType === ENTITY_SERVICE &&
                        <section className='entity-section'> {/* Booking Settings */}
                            {summaryFlags[findSummaryFlagIndex(SECTION_BOOKING_SETTINGS)].expanded === false ?
                                <div className='compressed-summary'>
                                    <h3 className='section-heading'>Booking Settings:</h3>
                                    <div className='short-summary'>Expand for summary</div>
                                </div> :
                                <div className='expanded-summary'>
                                    <h3 className='section-heading'>Booking Settings:</h3>
                                    <div>{summarizeBookingSettings()}</div>
                                </div>
                            }
                            <div className='summary-button-container'>
                                {summaryFlags[findSummaryFlagIndex(SECTION_BOOKING_SETTINGS)].expanded === false ?
                                    <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
                                        tooltip='Expand Summary' onClick={()=>expandSummary(SECTION_BOOKING_SETTINGS)}></IconButton> :
                                    <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
                                        tooltip='Compress Summary' onClick={()=>compressSummary(SECTION_BOOKING_SETTINGS)}></IconButton>
                                }
                                <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                                    tooltip='Edit Booking Settings' onClick={()=>setEditSection(SECTION_BOOKING_SETTINGS)}>
                                </IconButton>
                            </div>
                        </section>
                    }
                    {props.data.entityType === ENTITY_SERVICE &&
                        <section className='entity-section'> {/* Time-Block Options */}
                            {summaryFlags[findSummaryFlagIndex(SECTION_TIME_BLOCK_OPTIONS)].expanded === false ?
                                <div className='compressed-summary'>
                                    <h3 className='section-heading'>Time-Block Options:</h3>
                                    <div className='short-summary'>Expand for summary</div>
                                </div> :
                                <div className='expanded-summary'>
                                    <h3 className='section-heading'>Time-Block Options:</h3>
                                    <div>{summarizeTimeBlockOptions()}</div>
                                </div>
                            }
                            <div className='summary-button-container'>
                                {summaryFlags[findSummaryFlagIndex(SECTION_TIME_BLOCK_OPTIONS)].expanded === false ?
                                    <IconButton styleName='no-caption expand-compress summary-button' src={icons.downBlueIcon}
                                        tooltip='Expand Summary' onClick={()=>expandSummary(SECTION_TIME_BLOCK_OPTIONS)}></IconButton> :
                                    <IconButton styleName='no-caption expand-compress summary-button' src={icons.upBlueIcon}
                                        tooltip='Compress Summary' onClick={()=>compressSummary(SECTION_TIME_BLOCK_OPTIONS)}></IconButton>
                                }
                                <IconButton styleName='no-caption edit-icon summary-button' src={icons.editBlueIcon}
                                    tooltip='Edit Time-Block Options' onClick={()=>setEditSection(SECTION_TIME_BLOCK_OPTIONS)}>
                                </IconButton>
                            </div>
                        </section>
                    }
                    <br />
                    <div className='view-content'>
                        <IconButton styleName='primary medium-small' 
                            disabled={(!props.dirty && !props.data.idEntity)} src={icons.previewIcon}
                            onClick={()=>props.setMode('preview')} caption='Preview'>
                        </IconButton>
                        <IconButton styleName='primary medium-small'
                            src={icons.closeIcon}
                            onClick={cancelEdit} caption='Close'>
                        </IconButton>
                    </div>
                </Card>
            )
        }
        case SECTION_TITLE: {
            return (
                <MaintainTitle data={props.data} action='Edit' setRef={setRef}
                    saveData={saveData} updateData={updateData}
                    handleClose={handleClose} dirty={props.dirty}
                    originalData={props.originalData}></MaintainTitle>
            )
        }
        case SECTION_MEDIA: {
            return (
                <Card cardHeading={`Edit ${ENTITY_TYPE[props.data.entityType]}`} styleHeading='edit-entity-heading'
                    styleName='edit-entity-card' setRef={setRef}>
                    <p className='edit-entity-explanation'>Add & Edit Media</p>
                    <EditEntityImage data={props.data.media} 
                        updateMedia={updateMedia}
                        saveMedia={saveMedia}
                        deleteMedia={deleteMedia}
                        cancelMedia={cancelMedia}
                        idEntity={props.data.idEntity}
                        entityType={props.data.entityType}
                        dirty={!jsonFunctions.jsonEqual(props.data.media, props.originalData.media)}>
                    </EditEntityImage>
                </Card>
            )
        }
        case SECTION_RATE: {
            return (
                <ServiceRateAndPayment data={props.data.rate} updateData={updateRate}
                    action='Edit' saveData={saveData} handleClose={handleClose}
                    originalData={props.originalData} setRef={setRef}>
                </ServiceRateAndPayment>
            )
        }
        case SECTION_SERVICE_LOCATION: {
            return (
                <ServiceLocation data={props.data.offer} updateData={updateOffer}
                    action='Edit' saveData={saveData} handleClose={handleClose}
                    originalData={props.originalData} setRef={setRef}>
                </ServiceLocation>
            )
        }
        case SECTION_DESCRIPTION: {
            return (
                <MaintainDescription data={props.data} originalData={props.originalData}
                    saveData={saveData} updateData={updateData}
                    handleClose={handleClose} setRef={setRef}></MaintainDescription>
            )
        }
        case SECTION_CATEGORIES: {
            return (
                <MaintainCategories data={props.data.category}
                    originalData={props.originalData.category}
                    updateData={updateCategories} handleClose={handleClose}
                    saveData={saveData} setRef={setRef}
                    categoryList={props.categoryList}
                    setCategoryList={props.setCategoryList}></MaintainCategories>
            )
        }
        case SECTION_DEPOSIT_REQUIREMENTS: {
            return (
                <DepositRequirements data={props.data.offer} originalData={props.originalData.offer}
                    updateData={updateOffer} handleClose={handleClose}
                    saveData={saveData} setRef={setRef}
                    cancelPolicyOn={props.data.offer.cancelPolicyOn}></DepositRequirements>
            )
        }
        case SECTION_CANCELLATION_POLICY: {
            return (
                <CancellationPolicy data={props.data.offer} originalData={props.originalData.offer}
                    updateData={updateOffer} handleClose={handleClose}
                    saveData={saveData} setRef={setRef}></CancellationPolicy>
            )
        }
        case SECTION_BOOKING_SETTINGS: {
            return (
                <BookingSettings data={props.data.offer} originalData={props.originalData.offer}
                    updateData={updateOffer} handleClose={handleClose}
                    saveData={saveData} setRef={setRef}></BookingSettings>
            )
        }
        case SECTION_TIME_BLOCK_OPTIONS: {
            return (
                <TimeBlockOptions data={props.data.offer} originalData={props.originalData.offer}
                    updateData={updateOffer} handleClose={handleClose}
                    saveData={saveData} setRef={setRef}></TimeBlockOptions>
            )
        }
        default: {
            return <></>
        }
    }
    //         case entityEditState.OFFER: {
    //             return (
    //                 <>
    //                     <div className='entity-sub-header'>Set Offer Details</div>
    //                     <Offer data={props.data} 
    //                         updateOffer={updateOffer}
    //                         saveOffer={saveOffer}
    //                         cancelOffer={cancelOffer}
    //                         dirty={!jsonFunctions.jsonEqual(props.data.offer, props.originalData.offer)}></Offer>
    //                 </>
    //             )
    //         }
    //         case entityEditState.MEDIA: {
    //             return (
    //                 <Card cardHeading={`Edit ${ENTITY_TYPE[props.data.entityType]}`} styleHeading='edit-entity-heading'>
    //                     <div className='entity-sub-header'>Add & Edit Media</div>
    //                     <EditEntityImage data={props.data.media} 
    //                         updateMedia={updateMedia}
    //                         saveMedia={saveMedia}
    //                         deleteMedia={deleteMedia}
    //                         cancelMedia={cancelMedia}
    //                         idEntity={props.data.idEntity}
    //                         entityType={props.data.entityType}
    //                         dirty={!jsonFunctions.jsonEqual(props.data.media, props.originalData.media)}>
    //                     </EditEntityImage>
    //                 </Card>
    //             )
    //         }
    //         case entityEditState.CONTENT: {
    //             return (
    //                 <>
    //                     <div className='entity-sub-header'>Select Content to Link</div>
    //                     <SelectLinkedContent data={props.data.content} 
    //                         updateContent={updateContent}
    //                         saveContent={saveContent}
    //                         cancelContent={cancelContent}
    //                         dirty={!jsonFunctions.jsonEqual(props.data.content, props.originalData.content)}>
    //                     </SelectLinkedContent>
    //                 </>
    //             )
    //         }
    //         case entityEditState.CATEGORY: {
    //             return (
    //                 <>
    //                     <div className='entity-sub-header'>Select One or More Categories</div>
    //                     <CategorySelector entityType={props.data.entityType} data={props.data.category} 
    //                         updateCategories={updateCategories}
    //                         saveCategories={saveCategories}
    //                         cancelCategories={cancelCategories}
    //                         dirty={!jsonFunctions.jsonEqual(props.data.category, props.originalData.category)}></CategorySelector>
    //                 </>
    //             )
    //         }
    //         case entityEditState.LOCATION: {
    //             return (
    //                 <>
    //                     {backToMain()}
    //                     <div className='entity-sub-header'>Supply a Location or Area</div>
    //                     <LocationSelector></LocationSelector>
    //                 </>
    //             )
    //         }
    //         case entityEditState.BOOKING: {
    //             return (
    //                 <Fragment>
    //                     <div className='entity-sub-header'>Booking Settings</div>
    //                     <BookingSettings id='offered' updateOffer={updateOffer}
    //                         data={props.data.offer} saveOffer={saveOffer} cancelOffer={cancelOffer}
    //                         dirty={!jsonFunctions.jsonEqual(props.data.offer, props.originalData.offer)}>
    //                     </BookingSettings>
    //                 </Fragment>
    //             )
    //         }
    //         default: {
    //             return <></>
    //         }
    //     }
    // }

}

export default MaintainSingleEntity