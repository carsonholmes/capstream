import React, {useState, Fragment} from 'react'
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
import {ENTITY_TYPE, ENTITY_POST, ENTITY_SERVICE, ENTITY_TYPE_PLURAL} from '../../cdos/EntityCDO'
import './MaintainSingleEntity.css'
import MediaCDO from '../../cdos/MediaCDO'
// import CheckBox from '../controls/CheckBox/CheckBox'
// import HelpIcon from '../controls/HelpIcon/HelpIcon'
// import generateDropdownHelp from '../../shared/helper'
import EntityAttribute from '../EntityAttribute/EntityAttribute'
import BookingSettings from './BookingSettings'
import ServiceRateAndPayment from './ServiceRateAndPayment'
//import CreateAvailability from '../MaintainEvent/MaintainEvent'
//import AdvancedAvailability from '../MaintainEvent/AdvancedAvailability'

const cdo = new MediaCDO()
// const CONDITION_DATA = [{caption: 'Mint', value: 1001, description: 'Brand-spanking new in original packaging from manufacturer.'},
//                         {caption: 'New', value: 1002, description: 'New, not used.  Packaging opened, trial usage only.'},
//                         {caption: 'Used', value: 1003, description: 'Used but still in working condition.'},
//                         {caption: 'Damaged', value: 1004, description: 'Damaged beyond normal usage or not working.'}]

const MaintainSingleEntity = (props) => {

    const [editState, setEditState] = useState(entityEditState.MAIN)
    
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
        setEditState(entityEditState.MAIN)
    }

    const cancelMedia = () => {
        setEditState(entityEditState.MAIN)
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
        setEditState(entityEditState.MAIN)
        // var newData = {...props.data}
        // var newContent = [...props.data.content]
        // newData.content = newContent
        // props.setData(newData)
    }

    const cancelContent = () => {
        setEditState(entityEditState.MAIN)
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

    const saveCategories = () => {
        setEditState(entityEditState.MAIN)
        // var newData = {...props.data}
        // var newCategory = [...props.data.category]
        // newData.category = newCategory
        // props.setData(newData)
    }

    const cancelCategories = () => {
        setEditState(entityEditState.MAIN)
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
        setEditState(entityEditState.MAIN)
    }

    const cancelOffer = () => {
        setEditState(entityEditState.MAIN)
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

    const validateSave = () => {
        if (props.data.entityTitle) {
            props.saveData()
        }
        else alert(ENTITY_TYPE_PLURAL[props.data.entityType] + ' must have a title to save.')
    }

    const editPart = () => {
        switch (editState) {
            case entityEditState.MAIN: {
                return (
                    <Card cardHeading={props.cardHeading} styleHeading='maintain-single-entity-heading'>
                        <div className='maintain-single-buttons'>
                            <IconButton styleName='no-caption' tooltip='Preview' 
                                disabled={(!props.dirty && !props.data.idEntity)}
                                onClick={()=>props.setMode('preview')}
                                src={((!props.dirty && !props.data.idEntity) ? icons.previewDisabledIcon :
                                    icons.previewGreenIcon)}>
                            </IconButton>
                            <IconButton styleName={'no-caption'} tooltip='Save'
                                disabled={!props.dirty} onClick={validateSave}
                                src={(!props.dirty ? icons.saveDisabledIcon : icons.saveGreenIcon)}
                                >
                            </IconButton>
                            <IconButton styleName={'no-caption'} tooltip='Close'
                                src={icons.closeGreenIcon} onClick={cancelEdit}>
                            </IconButton>
                            
                        </div>
                        {props.entityType === ENTITY_POST && 
                            <RadioButtons data={[{caption: 'Seeking', value: true},
                                                 {caption: 'Offering', value: false}]} 
                                dataCol = 'seeking' 
                                value={props.data.seeking}
                                onChange={updateData}
                                name='seekingOrOffering'>
                            </RadioButtons>}
                        <TitleAndDescription data={props.data} updateData={updateData}></TitleAndDescription>
                        {props.entityType === ENTITY_SERVICE &&
                            <ServiceRateAndPayment data={props.data.rate} updateRate={updateRate}></ServiceRateAndPayment>
                        }
                        {props.data.media.length>0 && 
                            <div className='micro-included'>
                                <label className='micro-included'>Media:</label>
                                <EntityImageArray 
                                    data={props.data.media} 
                                    size='xxx-small'
                                    notSelectable={true}
                                    idEntity={props.data.idEntity}
                                    currentImageIndex={props.data.media.length-1}>
                                </EntityImageArray>
                            </div>}
                        {props.data.content.length>0 &&
                            <div className='micro-included'>
                                <label className='micro-included'>Content:</label>
                                <MicroLinkedContent
                                    data={props.data.content} 
                                    size='xxx-small'>
                                </MicroLinkedContent> 
                            </div>}
                        {props.data.category.length === 0 && 
                        <div className='info-banner'>Please select categories to appear in search results.</div>}
                        <PrimaryEntityButtons onClick={setEditState} entityType={props.entityType}
                            scheduleDisabled={!props.data.scheduledByAppointment}></PrimaryEntityButtons>
                        {/* props.entityType===ENTITY_ITEM &&
                            <Fragment>
                                <HelpIcon styleName='dropdown-help-icon'>{generateDropdownHelp(CONDITION_DATA)}</HelpIcon>
                                <Dropdown id='conditionDropdown' dataCol='condition'
                                    containerStyle='condition-dropdown'
                                    placeholder='Condition'
                                    data={CONDITION_DATA}
                                    value={props.data.condition}
                                    onChange={updateData}>
                                </Dropdown>
                            </Fragment>
                        props.data.category.length>0 */}
                        <EntityAttribute data={props.data}></EntityAttribute>
                        <br />
                        <IconButton styleName='primary medium-small reverse-gradient' 
                            disabled={(!props.dirty && !props.data.idEntity)} src={icons.previewIcon}
                            onClick={()=>props.setMode('preview')} caption='Preview'>
                        </IconButton>
                        <IconButton styleName={'primary medium-small reverse-gradient'}
                            disabled={!props.dirty} src={icons.saveIcon}
                            onClick={validateSave} caption={`${props.create ? 'Submit' : 'Save'}`}>
                        </IconButton>
                        <IconButton styleName={'primary medium-small sign-cancel'}
                            src={icons.closeIcon}
                            onClick={cancelEdit} caption={`Cancel`}>
                        </IconButton>
                    </Card>
                )
            }
            // case entityEditState.ADVANCEDSCHEDULE: {
            //     return (
            //         <>
            //             {backToMain()}
            //             <div className='entity-sub-header'>Advanced Availibility Options</div>
            //             <AdvancedAvailability></AdvancedAvailability>
            //         </>
            //     )
            // }
            case entityEditState.OFFER: {
                return (
                    <>
                        <div className='entity-sub-header'>Set Offer Details</div>
                        <Offer data={props.data} 
                            updateOffer={updateOffer}
                            saveOffer={saveOffer}
                            cancelOffer={cancelOffer}
                            dirty={!jsonFunctions.jsonEqual(props.data.offer, props.originalData.offer)}></Offer>
                    </>
                )
            }
            case entityEditState.MEDIA: {
                return (
                    <>
                        <div className='entity-sub-header'>Add & Edit Media</div>
                        <EditEntityImage data={props.data.media} 
                            updateMedia={updateMedia}
                            saveMedia={saveMedia}
                            deleteMedia={deleteMedia}
                            cancelMedia={cancelMedia}
                            idEntity={props.data.idEntity}
                            entityType={props.data.entityType}
                            dirty={!jsonFunctions.jsonEqual(props.data.media, props.originalData.media)}>
                        </EditEntityImage>
                    </>
                )
            }
            case entityEditState.CONTENT: {
                return (
                    <>
                        <div className='entity-sub-header'>Select Content to Link</div>
                        <SelectLinkedContent data={props.data.content} 
                            updateContent={updateContent}
                            saveContent={saveContent}
                            cancelContent={cancelContent}
                            dirty={!jsonFunctions.jsonEqual(props.data.content, props.originalData.content)}>
                        </SelectLinkedContent>
                    </>
                )
            }
            case entityEditState.CATEGORY: {
                return (
                    <>
                        <div className='entity-sub-header'>Select One or More Categories</div>
                        <CategorySelector entityType={props.data.entityType} data={props.data.category} 
                            updateCategories={updateCategories}
                            saveCategories={saveCategories}
                            cancelCategories={cancelCategories}
                            dirty={!jsonFunctions.jsonEqual(props.data.category, props.originalData.category)}></CategorySelector>
                    </>
                )
            }
            case entityEditState.LOCATION: {
                return (
                    <>
                        {backToMain()}
                        <div className='entity-sub-header'>Supply a Location or Area</div>
                        <LocationSelector></LocationSelector>
                    </>
                )
            }
            case entityEditState.BOOKING: {
                return (
                    <Fragment>
                        <div className='entity-sub-header'>Booking Settings</div>
                        <BookingSettings id='offered' updateOffer={updateOffer}
                            data={props.data.offer} saveOffer={saveOffer} cancelOffer={cancelOffer}
                            dirty={!jsonFunctions.jsonEqual(props.data.offer, props.originalData.offer)}>
                        </BookingSettings>
                    </Fragment>
                )
            }
            default: {
                return <></>
            }
        }
    }

    const backToMain = () => {
        return (
            <IconButton styleName='return-to-entity' 
                onClick={()=>setEditState(entityEditState.MAIN)} 
                src={icons.previousIcon} caption={`Return to ${ENTITY_TYPE[props.entityType]}`}>
            </IconButton>)
    }

    return ( editPart() )
}

export default MaintainSingleEntity