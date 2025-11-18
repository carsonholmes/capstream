import React, {useState, useEffect, useRef, Fragment} from 'react'
import { AppContext } from '../../AppContext'
import ScaledImage from '../controls/ScaledImage/ScaledImage'
import EntityImageArray from '../EntityImage/EntityImageArray'
import FullPageImageModal from '../controls/FullPageImageModal/FullPageImageModal'
import mediaPath from '../../shared/mediaPath'
import {ENTITY_USER, ENTITY_PERSON, ENTITY_EVENT, ENTITY_SERVICE, ENTITY_ITEM, ENTITY_POST, ENTITY_GROUP, ENTITY_PLACE,
    ENTITY_TYPE_PLURAL, ENTITY_TYPE_LOWERCASE_PLURAL} from '../../cdos/EntityCDO'
import './View.css'
import LinkedContent from '../LinkedContent/LinkedContent'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'
import EntityList from '../EntityList/EntityList'
import CartCDO from '../../cdos/CartCDO'
import {formatText} from '../../shared/jsxFunctions'
import Booking from '../Calendar/Booking'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import EntityImage from '../EntityImage/EntityImage'
import HelpIcon from '../controls/HelpIcon/HelpIcon'
import {RATE_TIME_FRAMES} from '../../shared/serviceConstants'
import { formatTimeBlockValues, formatLeadTime } from '../../shared/timeFunctions'
const cdoCart = new CartCDO()
// uses styling from View.css

const OWNED_ENTITIES = [5, 4, 3]
// const CONDITION_DATA = [{caption: 'Mint', value: 1001, description: 'Brand-spanking new in original packaging from manufacturer.'},
//                         {caption: 'New', value: 1002, description: 'New, not used.  Packaging opened, trial usage only.'},
//                         {caption: 'Used', value: 1003, description: 'Used but still in working condition.'},
//                         {caption: 'Damaged', value: 1004, description: 'Damaged beyond normal usage or not working.'}]
// refactor the above array when we clean up reference data


const DisplayView = (props) => {

    const {appContext, setAppContext} = React.useContext(AppContext)
    const [lastImageIndex, setLastImageIndex] = useState(-1)
    const [displayFullScreen, setDisplayFullScreen] = useState(false)
    const [isLongDesc, setIsLongDesc] = useState(false)
    const [seeingMore, setSeeingMore] = useState(false)
    const [isBookingService, setIsBookingService] = useState(false)
    const refDesc = useRef()

    useEffect(()=>{
        if (props.currentImageIndex !== lastImageIndex) {
            setLastImageIndex(props.currentImageIndex)
        }
    },[props.currentImageIndex, lastImageIndex])
        
    useEffect(()=>{
        if (refDesc.current) setIsLongDesc(refDesc.current.clientHeight < refDesc.current.scrollHeight) // check to see if line-clamp is hiding lines
    },[props.data.entityDesc])

    const editEntity = () => {
        window.location.href = '/maintain/' + ENTITY_TYPE_LOWERCASE_PLURAL[props.data.entityType] + 
            '/' + props.idEntity
    }

    const addToCart = () => {
        // var shoppingCart = loadFromLocalStorage('shoppingCart' + appContext.idEntity)
        // if (!shoppingCart.items) shoppingCart = {items: []}
        // var alreadyInCart = false
        // for (let i=0; i<shoppingCart.items.length && !alreadyInCart; i++) {
        //     if (shoppingCart.items[i].idEntity === props.data.idEntity) {
        //         alreadyInCart = true
        //         shoppingCart.items[i].quantity++
        //     }
        // }
        // if (!alreadyInCart) shoppingCart.items.push({idEntity: props.data.idEntity, quantity: 1})
        // storeToLocalStorage('shoppingCart' + appContext.idEntity, shoppingCart)
        cdoCart.addData({ idEntity: props.data.idEntity, 
                            idUser: appContext.idEntity, 
                            idSession: appContext.idSession, 
                            idOffer: props.data.offer.idOffer}, cbAddedToCart)
        var newContext = {...appContext}
        if (newContext.cartQuantity) newContext.cartQuantity++
        else newContext.cartQuantity = 1
        setAppContext(newContext)
    }

    const cbAddedToCart = (error, result) => {
        
    }

    const bookService = () => {
        setIsBookingService(true)
    }

    const respondToPost = () => {
        
    }

    // const addContact = () => {
        
    // }

    const addToCalendar = () => {
        
    }

    const joinGroup = () => {
        
    }

    const checkAvailability = () => {
        
    }

    const displayButton = () => {
        if (!props.previewMode)
            if (props.isOwner === true) {
                return (
                    <IconButton styleName='edit-button view-action' src={icons.editIcon} caption='Edit'
                        onClick={editEntity}></IconButton>)
                }
            else if (props.isOwner !== null)
                switch (props.data.entityType) {
                    case ENTITY_ITEM: return (
                        <IconButton styleName='add-button view-action' src={icons.addIcon}
                            caption='Add to Cart'
                            onClick={addToCart}></IconButton>)
                    case ENTITY_SERVICE: return (
                        <IconButton styleName='add-button view-action' src={icons.addIcon}
                            caption='Book Service'
                            onClick={bookService}></IconButton>)
                    case ENTITY_POST: return (
                        <IconButton styleName='add-button view-action' src={icons.addIcon}
                            caption='Respond'
                            onClick={respondToPost}></IconButton>)
                    case ENTITY_USER:
                        if (appContext.idEntity !== props.data.idEntity)
                            return (
                                <IconButton styleName='save-button view-action' src={icons.messageIcon}
                                    onClick={()=>window.location.href='/messages/' + props.data.idEntity}
                                    caption='Message'></IconButton>)
                        else return ''
                    case ENTITY_EVENT: return (
                        <IconButton styleName='add-button view-action' src={icons.addIcon}
                            caption='Add to Calendar'
                            onClick={addToCalendar}></IconButton>)
                    case ENTITY_GROUP: return (
                        <IconButton styleName='add-button view-action' src={icons.addIcon}
                            caption='Join Group'
                            onClick={joinGroup}></IconButton>)
                    case ENTITY_PLACE: return (
                        <IconButton styleName='add-button view-action' src={icons.addIcon}
                            caption='Check Availability'
                            onClick={checkAvailability}></IconButton>)
                    default: return <></>
                }
        else return <></>
    }

    const displayPrice = (preferred) => {
        var price = preferred
        if (props.data.entityType === ENTITY_SERVICE) price += 'Rate: '
        else price += 'Price: '
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

    const selectOwnerLabel = () => {
        if (props.data.entityType === ENTITY_POST) return 'Poster:'
        if (props.data.entityType === ENTITY_ITEM) return 'Seller:'
        if (props.data.entityType === ENTITY_SERVICE) return 'Service provider:'
        if (props.data.entityType === ENTITY_EVENT) return 'Event creator:'
        if (props.data.entityType === ENTITY_PLACE) return 'Poster:'
    }

    if (isBookingService) {
        let serviceData = props.data
        serviceData.idProvider = props.ownerData.idEntity
        serviceData.providerTitle = props.ownerData.entityTitle
        return (<Booking serviceData={serviceData}></Booking>)
    }
    else 
        return (
        <ContentContainer>
            <Card styleName='view-card'>
                {displayButton()}
                <div className='view-grid'>
                    {props.currentImageIndex >= 0 && props.data.media.length > 0 && // primary image
                        <ScaledImage styleName='view-image' size='medium'
                            src={mediaPath(props.currentImageIndex, props.data.media, props.idEntity,
                                props.data.entityType)}
                            left={props.data.media[props.currentImageIndex].xOffset}
                            top={props.data.media[props.currentImageIndex].yOffset}
                            scale={props.data.media[props.currentImageIndex].scale}
                            circular={props.data.entityType===ENTITY_USER}
                            onClick={()=>setDisplayFullScreen(true)}>
                        </ScaledImage>
                    }
                    <label className='view-title'>{props.data.entityTitle}</label> {/* title */}
                    {props.currentImageIndex >= 0 && props.data.media.length > 1 && // media strip
                        <EntityImageArray setCurrentImageIndex={props.setCurrentImageIndex} size='xx-small'
                            idEntity={props.idEntity} circular={props.data.entityType===ENTITY_USER}
                            data={props.data.media} currentImageIndex={props.currentImageIndex}
                            styleName='view-media-strip'>
                        </EntityImageArray>
                    }
                    {(props.data.entityType === ENTITY_ITEM || props.data.entityType === ENTITY_SERVICE ||
                        props.data.entityType === ENTITY_EVENT) &&
                        <div className='view-price'>{displayPrice('')}</div>}
                    {props.data.offer.negotiable === 1 && props.data.offer.price > 0 &&
                        <div className='view-price view-preferred-price'>{displayPrice('Preferred ')}</div>}
                </div>
                <div className='view-content'>
                    {props.data.entityDesc && // description
                        <h2 className='sub-section-heading'>Description:</h2>}
                    {!isLongDesc && props.data.entityDesc &&
                        <section className='view-desc line-clamp'
                            ref={refDesc}>{formatText(props.data.entityDesc)}
                            </section>}
                    {isLongDesc && !seeingMore &&
                        <Fragment>
                            <section className='view-desc line-clamp' ref={refDesc}>
                                {formatText(props.data.entityDesc)}</section>
                            <button className='see-more-less' onClick={()=>setSeeingMore(true)}>
                                See more <img className='see-more-less' src={icons.seeMore} alt='see more'/>
                            </button>
                        </Fragment>}
                    {isLongDesc && seeingMore &&
                        <Fragment>
                            <section className='view-desc' ref={refDesc}>
                                {formatText(props.data.entityDesc)}</section>
                            <button className='see-more-less' onClick={()=>setSeeingMore(false)}>
                                See less <img className='see-more-less' src={icons.seeLess} alt='see more'/>
                            </button>
                        </Fragment>}
                    {props.ownerData && // owner info
                        (props.data.entityType !== ENTITY_USER && props.data.entityType !== ENTITY_PERSON) &&
                        <section className='owner'>
                            <h2 className='sub-section-heading'>{selectOwnerLabel()}</h2>
                            <div className='owner-info'>
                                <EntityImage idEntity={props.ownerData.idEntity}
                                    circular={true} size='x-small'
                                    onClick={()=>window.location.href='/view/' + props.ownerData.idEntity}
                                    entityType = {props.ownerData.entityType}>
                                </EntityImage>
                                <div className='owner-name'
                                    onClick={()=>window.location.href='/view/' + props.ownerData.idEntity}>
                                    {props.ownerData.entityTitle}</div>
                                {!props.isOwner &&
                                    <IconButton src={icons.messageIcon} caption='Message'
                                        onClick={()=>window.location.href='/messages/' + props.data.idEntity}
                                        styleName='save-button'></IconButton>}
                            </div>
                        </section>
                    }
                    {props.data.entityType === ENTITY_SERVICE && // booking details
                        <section className='display-view-booking-container'>
                            <h2 className='sub-section-heading'>Booking Details</h2>
                            <div className='display-view-booking-blocks'>
                                <HelpIcon styleName='display-view-help'>
                                    This is the shortest duration someone can book this service.</HelpIcon>
                                <span className='display-view-booking-label'>Minimum Time Block:</span>
                                <span className='display-view-booking-value'>
                                    {formatTimeBlockValues(props.data.offer.minTimeIncrement)}
                                </span>
                            </div>
                            {props.data.offer.maxTimeIncrement !== 0 &&
                                <div className='display-view-booking-blocks'>
                                    <HelpIcon styleName='display-view-help'>
                                        This is the longest duration someone can book this service.</HelpIcon>
                                <span className='display-view-booking-label'>Maximum Time Block:</span>
                                <span className='display-view-booking-value'>
                                {formatTimeBlockValues(props.data.offer.maxTimeIncrement)}</span>
                                </div>}
                            <div className='display-view-booking-blocks'>
                                <HelpIcon styleName='display-view-help'>
                                    You must book with at least this much notice before the appointment starts.
                                </HelpIcon>
                                <span className='display-view-booking-label'>Booking Lead Time:</span>
                                <span className='display-view-booking-value'>
                                    {formatLeadTime(props.data.offer.bookingLeadNumber,
                                        props.data.offer.bookingLeadType)}</span>
                            </div>
                            {props.data.offer.cancelLeadNumber !== 0 &&
                                <div className='display-view-booking-blocks'>
                                    <HelpIcon styleName='display-view-help'>
                                        You must cancel with at least this much notice to avoid being charged.
                                    </HelpIcon>
                                    <span className='display-view-booking-label'>Cancellation Lead Time:</span>
                                    <span className='display-view-booking-value'>
                                    {formatLeadTime(props.data.offer.cancelLeadNumber,
                                        props.data.offer.cancelLeadType)}</span>
                                </div>}
                            {props.data.offer.cancelLeadNumber && props.data.offer.cancelFee &&
                                <div className='display-view-booking-blocks'>
                                <HelpIcon styleName='display-view-help'>
                                    The cancellation fee is a percentage of the total price of the booked 
                                        appointment.
                                </HelpIcon>
                                <span className='display-view-booking-label'>Cancellation Fee:</span>
                                <span className='display-view-booking-value'>
                                    {props.data.offer.cancelFee}%</span>
                                </div>}
                            <div className='display-view-booking-blocks'>
                                <HelpIcon styleName='display-view-help'>
                                    The number of customers who can participate in each appointment.
                                </HelpIcon>
                                <span className='display-view-booking-label'>Customers per Time Block:</span>
                                <span className='display-view-booking-value'>
                                    {props.data.offer.quantity}</span>
                            </div>
                        </section>}
                    <LinkedContent data={props.data.content}></LinkedContent>
                    {OWNED_ENTITIES.map( (typeValue, index)=> {
                        return (
                            <Fragment key={index}>
                                {props.data.owned[typeValue] && props.data.owned[typeValue].length > 0 && 
                                    <Fragment>
                                        <h2 className='sub-section-heading'>
                                            {ENTITY_TYPE_PLURAL[typeValue] + ':'}</h2>
                                        <EntityList data={props.data.owned[typeValue]} hideLabel={true}>
                                        </EntityList>
                                    </Fragment>
                                }
                            </Fragment>)
                    })}
                    {displayFullScreen && 
                        <FullPageImageModal currentImageIndex={props.currentImageIndex}
                            src={mediaPath(props.currentImageIndex, props.data.media, props.idEntity,
                                props.data.entityType)} imageArrayLength={props.data.media.length}
                            setCurrentImageIndex={props.setCurrentImageIndex}
                            onClose={()=>setDisplayFullScreen(false)}>
                        </FullPageImageModal>}
                </div>
            </Card>
        </ContentContainer> 
    )
}

export default DisplayView