import React, {Fragment, useCallback, useContext, useEffect, useRef, useState} from 'react'
import { AppContext } from '../../AppContext'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
import './MaintainEvent.css'
import EventCDO, { REPEAT_NEVER, REPEAT_DAILY, REPEAT_WEEKLY, REPEAT_WEEKDAYS, REPEAT_MONTHLY_ORDINAL,
    REPEAT_MONTHLY_LAST, REPEAT_MONTHLY_DATE, REPEAT_YEARLY, REPEAT_CUSTOM, REPEAT_CUSTOM_SPECIFIC, TYPE_BOOKED }
    from '../../cdos/EventCDO'
import Modal from '../controls/Modal/Modal'
import Select from '../controls/Select/Select'
import CheckBox from '../controls/CheckBox/CheckBox'
import DatePicker from '../controls/DatePicker/DatePicker'
import CustomRepeat from './CustomRepeat'
import RepeatUpdateOptions from './RepeatUpdateOptions'
import CheckBoxList from '../controls/CheckBoxList/CheckBoxList'
import TileSelect from '../controls/TileSelect/TileSelect'
import HelpIcon from '../controls/HelpIcon/HelpIcon'
import { formatDuration, formatTimeBlockValues, formatLeadTime, sameDate, dateWithoutTime, formulateRepeatEventsForSingleEvent }
    from '../../shared/timeFunctions'
import { START_TIME_OPTIONS } from '../../shared/serviceConstants'
const cdo = new EventCDO()

const ACTION_DELETE = 1
const ACTION_SAVE = 2
const AVAILABILITY = 1
const BOOKING = 2
const MS_DAY = 24*60*60*1000

const MaintainEvent = (props) => {

    const {appContext} = useContext(AppContext);
    const [duration, setDuration] = useState(0)
    const [repeatOptions, setRepeatOptions] = useState([])
    const [saveDisabled, setSaveDisabled] = useState(false)
    const [deleteDisabled, setDeleteDisabled] = useState(true)
    const [confirmCancel, setConfirmCancel] = useState(false)
    const [confirmDelete, setConfirmDelete] = useState(false)
    const allWeekdaysChecked = useRef(false)
    const allDaysOfWeekChecked = useRef(false)
    const oneDayOfWeekChecked = useRef(false)
    const [confirmRepeatGenerated, setConfirmRepeatGenerated] = useState(false)
    const [repeatGeneratedAction, setRepeatGeneratedAction] = useState(0)
    const [endDateAlert, setEndDateAlert] = useState(false)
    const [endTimeAlert, setEndTimeAlert] = useState(false)
    const [displayOverlapModal, setDisplayOverlapModal] = useState(false)
    const firstTimeScroll = useRef(false)

    // initial window scroll
    useEffect(() => {
        if (!firstTimeScroll.current) {
            window.scrollTo({top: props.scrollDistance})
            firstTimeScroll.current = true
        }
    }, [])
    
    const calcDuration = useCallback(() => {
        let startRow = props.timeArray.findIndex((timeRow) => (timeRow.value === props.data.startTime))
        let endTimeRow = props.timeArray.findIndex((timeRow) => (timeRow.value === props.data.endTime))
        let newDuration = endTimeRow - startRow
        let dStart = dateWithoutTime(props.data.dtStart)
        let dEnd = dateWithoutTime(props.data.dtEnd)
        if (!sameDate(props.data.dtStart, props.data.dtEnd)) 
            if (newDuration >= 0) newDuration +=
                (props.timeArray.length * (Math.floor((dEnd.valueOf() -
                    dStart.valueOf()) / MS_DAY)))
            else  newDuration +=
                (props.timeArray.length * (Math.floor((dEnd.valueOf() -
                    dStart.valueOf()) / MS_DAY)))
        return newDuration
    }, [props.timeArray, props.data])

    // set event duration
    useEffect(() => {
        setDuration(calcDuration())
    }, [props.data.startTime, props.data.endTime, props.data.dtEnd, calcDuration]);

    // manage disablement of Save & Delete buttons
    useEffect(() => {
        if (!props.data.new) {
            if (!props.dirty) setSaveDisabled(true)
            else setSaveDisabled(false)
            setDeleteDisabled(false)
        }
        else setDeleteDisabled(true)
    }, [props.data, props.dirty, props.data.startTime, props.data.endTime, props.data.dtEnd]);

    const availabilityStartIndex = useRef()
    const availabilityEndIndex = useRef()
    const previousDayStartAdjustment = useRef()
    
    // calculate indices for timeArray & availability slices, and store as references
    const calculateTimeIndices = () => {
        let dStart = dateWithoutTime(props.availabilityEvent.dtStart)
        let dEnd = dateWithoutTime(props.availabilityEvent.dtEnd)
        // find the timeArray index of the availability (event) start time
        availabilityStartIndex.current =
            props.timeArray.findIndex(timeString=>timeString.value===props.availabilityEvent.startTime)
        availabilityEndIndex.current = 
            props.timeArray.findIndex(timeString=>timeString.value===props.availabilityEvent.endTime)
        // however, end time can be the same day or one or more days in the future, so add any extra days
        if (!sameDate(props.availabilityEvent.dtEnd,props.viewDate)) availabilityEndIndex.current +=
                (props.timeArray.length * (props.availabilityEvent.dtEnd.valueOf() - 
                    dateWithoutTime(props.viewDate).valueOf()) / MS_DAY)// find the timeArray index of the availability (event) end time
        // original from start arary // let availabilityEndIndex = 
        //     props.timeArray.findIndex(timeString=>timeString.value===props.availabilityEvent.endTime) +
        //         (props.timeArray.length * (Math.floor((dEnd.valueOf() - 
        //             dateWithoutTime(props.viewDate).valueOf()) / MS_DAY)))
        // if the availability (event) start date is prior to the current dailyView view date, make availabilityStartIndex 0
        if (dStart.valueOf() < dateWithoutTime(props.viewDate).valueOf()) {
            availabilityStartIndex.current = 0
        }
        // if the availability event begins on a previous day, previousDayStartAdjustment
        // is the number of availability slices that exist prior to the current view date 
        previousDayStartAdjustment.current = (dateWithoutTime(props.viewDate).valueOf() - 
            props.availabilityEvent.dtStart.valueOf()) / (15*60*1000)
        // if the availability event begins on the current view date,
        // the previousDayStartAdjustment will be negative, therefore set it to 0
        if (previousDayStartAdjustment.current < 0) previousDayStartAdjustment.current = 0
    }
    useEffect(() => {
        calculateTimeIndices()
    }, [props.availabilityEvent, props.data.startTime, props.viewDate])
    

    const calcDayOrdinal = useCallback(() => {
        let date = props.data.dtStart.getDate()
        if (date / 7 <= 1) return 'first'
        else if (date / 7 > 1 && date / 7 <= 2) return 'second'
        else if (date / 7 > 2 && date / 7 <= 3) return 'third'
        else if (date / 7 > 3 && date / 7 <= 4) return 'fourth'
    }, [props.data])

    const getDateOrdinal = (num) => {
        const lastDigit = num % 10
        let suffix = 'th'
        if (num < 4 || num > 20) {
            if (lastDigit === 1) suffix = 'st'
            else if (lastDigit === 2) suffix = 'nd'
            else if (lastDigit === 3) suffix = 'rd'
        }
        return num + suffix
    }

    // build repeatOptions array
    useEffect(() => {
        let newRepeatOptions = [
            {caption: 'never', value: REPEAT_NEVER},
            {caption: 'daily', value: REPEAT_DAILY},
            {caption: `weekly on ${props.data.dtStart.toLocaleDateString('en-US', {weekday: 'long'})}`,
                value: REPEAT_WEEKLY},
            {caption: 'every weekday (Mon thru Fri)', value: REPEAT_WEEKDAYS},
            {caption: `monthly on the ${calcDayOrdinal()} ${props.data.dtStart.toLocaleDateString('en-US', {weekday: 'long'})}`,
                value: REPEAT_MONTHLY_ORDINAL},
            {caption: `monthly on the last ${props.data.dtStart.toLocaleDateString('en-US', {weekday: 'long'})}`,
                value: REPEAT_MONTHLY_LAST},
            {caption: `monthly on the ${getDateOrdinal(props.data.dtStart.getDate())}`,
                value: REPEAT_MONTHLY_DATE},
            {caption: `yearly on ${props.data.dtStart.toLocaleDateString('en-US',{month: 'short'})} ${getDateOrdinal(props.data.dtStart.getDate())}`,
                value: REPEAT_YEARLY},
            {caption: 'custom...', value: REPEAT_CUSTOM},
        ]
        let spliced = 0
        if (props.data.dtStart.getDay() === 0 || props.data.dtStart.getDay() === 6) {
            newRepeatOptions.splice(REPEAT_WEEKDAYS,1)
            spliced++
        }
        if (props.data.dtStart.getDate() > 28) {
            newRepeatOptions.splice(REPEAT_MONTHLY_ORDINAL - spliced,1)
            spliced++
        }
        if (props.lastDateOfMonth - props.data.dtStart.getDate() > 6) {
            newRepeatOptions.splice(REPEAT_MONTHLY_LAST - spliced,1)
            spliced++
        }
        setRepeatOptions(newRepeatOptions)
    }, [props.data, calcDayOrdinal, props.lastDateOfMonth]);
    
    const toggleAllDay = () => {
        if (!props.data.allDay) { //checking "all day"
            let newEndDate = new Date(props.data.dtEnd.getFullYear(), props.data.dtEnd.getMonth(),
                props.data.dtEnd.getDate() + 1, 0, 0)
            changeStartTime(props.timeArray[0].value)
            changeEndTime(props.timeArray[0].value)
            props.updateData('dtEnd', newEndDate)
        }
        else { // unchecking "all day"
            if (props.originalData.allDay) { // original data is "all day: true"
                changeStartTime(props.timeArray[36].value) // set to 9:00 am
                changeEndTime(props.timeArray[68].value) // set to 5:00 pm
                props.updateData('dtEnd', props.originalData.dtStart)//set dtEnd to originalData dtStart
            }
            else { // original data is "all day: false"
                changeStartTime(props.originalData.startTime)
                changeEndTime(props.originalData.endTime)
                props.updateData('dtEnd', props.originalData.dtEnd) //set dtEnd to originalData dtEnd
            }
        }
        props.updateData('allDay', !props.data.allDay) // toggle "all day" boolean
    }

    const getHours = (sTime) => {
        let colon = sTime.indexOf(':')
        let hours = parseInt(sTime.substring(0,colon))
        if (sTime.indexOf('a') > 0 && hours === 12) hours = 0
        if (sTime.indexOf('p') > 0 && hours !== 12) hours += 12
        return hours
    }

    const getMins = (sTime) => {
        let colon = sTime.indexOf(':')
        return parseInt(sTime.substring(colon+1,colon+3))
    }

    const prepEventForNotification = (event) => {
        event.idUser = appContext.idEntity
        if (event.eventType !== TYPE_BOOKED) event.idEntity = appContext.idEntity
        else {
            event.idEntity = props.serviceData.idProvider
            event.providerTitle = props.serviceData.providerTitle
            event.serviceTitle = props.serviceData.entityTitle
            event.consumerTitle = appContext.entityTitle
            props.updateData('consumerTitle', event.consumerTitle)  //needed in Calendar for assembling bookedConsumers
            event.confirmMethod = props.serviceData.offer.confirmMethod
            event.quantity = props.serviceData.offer.quantity
            event.confirmed = props.serviceData.offer.confirmMethod
        }
    }

    const saveEvent = () => {
        var newEvent = {...props.data}
        prepEventForNotification(newEvent)
        let newStartDate = new Date(props.data.dtStart.getFullYear(), props.data.dtStart.getMonth(),
            props.data.dtStart.getDate(), getHours(props.data.startTime), getMins(props.data.startTime))
        let newEndDate = new Date(props.data.dtEnd.getFullYear(), props.data.dtEnd.getMonth(),
            props.data.dtEnd.getDate(), getHours(props.data.endTime), getMins(props.data.endTime))
        newEvent.dtStart = newStartDate
        newEvent.dtEnd = newEndDate
        props.updateData('dtStart', newStartDate)
        props.updateData('dtEnd', newEndDate)
        // loop through available services to see which checked ones have been changed
        if (newEvent.servicesOffered.length>0)
            for (let i = 0; i < newEvent.servicesOffered.length; i++) {
                if (!newEvent.allServices) 
                    if (newEvent.allServices !== props.originalData.allServices)
                        newEvent.servicesOffered[i].dirty = true
                    else newEvent.servicesOffered[i].dirty = (newEvent.servicesOffered[i].checked !== props.originalData.servicesOffered[i].checked)
            }
        if (newEvent.new) cdo.addData(newEvent, cbSaveEvent)
        else {
            newEvent.originalEvent = props.originalData
            cdo.saveData(newEvent, cbSaveEvent)
        }
    }

    const cbSaveEvent = (err, result) => {
        if (!err && !result.error) {
            if (result.idEvent >= 0) {
                props.updateData('idEvent', result.idEvent)  // only the initial add will return the id
                if (props.data.eventType===3) props.updateData('idBooking', result.idBooking)  // only the initial add will return the id
            }
            props.saveData()
        }
        else {
            alert(`Error ${result.error.errno} saving event.  ${result.error.code} - ${result.error.sqlMessage}`)
        }  
    }

    const changeTime = (dataCol, value) => {
        if (dataCol === 'startTime') changeStartTime(value)
        if (dataCol === 'endTime') changeEndTime(value)
    }

    const changeStartTime = (value) => {
        let newDuration = calcDuration()
        let newStartRow = props.timeArray.findIndex((timeRow) => (timeRow.value === value))
        let newEndRow = newStartRow + newDuration
        if (newEndRow > props.timeArray.length - 1) {
            let additionalDays = Math.floor(newEndRow/props.timeArray.length)
            newEndRow = newEndRow % props.timeArray.length
            let newEndDate = new Date(props.data.dtStart.getFullYear(), props.data.dtStart.getMonth(),
            props.data.dtStart.getDate() + additionalDays, getHours(props.timeArray[newEndRow].value),
                getMins(props.timeArray[newEndRow].value))
            props.updateData('dtEnd', newEndDate)
            
        }
        else if (!sameDate(props.data.dtStart, props.data.dtEnd) && newEndRow < props.timeArray.length) {
            let newEndDate = new Date(props.data.dtStart.getFullYear(), props.data.dtStart.getMonth(),
                props.data.dtStart.getDate(), getHours(props.timeArray[newEndRow].value),
                getMins(props.timeArray[newEndRow].value))
            props.updateData('dtEnd', newEndDate)
        }
        let newStartDate = new Date(props.data.dtStart.getFullYear(), props.data.dtStart.getMonth(),
            props.data.dtStart.getDate(), getHours(value), getMins(value))
        props.updateData('dtStart', newStartDate)
        props.updateData('startTime', value)
        props.updateData('endTime', props.timeArray[newEndRow].value)
    }

    const changeEndTime = (value) => {
        let startRow = props.timeArray.findIndex((timeRow) => (timeRow.value === props.data.startTime))
        let endTimeRow = props.timeArray.findIndex((timeRow) => (timeRow.value === value))
        let newDuration = endTimeRow - startRow
        // if changing end time to span multiple days (before start Time on next day), 
        // but currently dtEnd and dtStart are the same, so increment dtEnd + 1 day
        if (sameDate(props.data.dtStart, props.data.dtEnd) && newDuration < 1) {
            let newEndDate = new Date(props.data.dtStart.getFullYear(), props.data.dtStart.getMonth(),
            props.data.dtStart.getDate() + 1, props.data.dtEnd.getHours(), props.data.dtEnd.getMinutes())
            props.updateData('dtEnd', newEndDate)
        }
        // if (!sameDate(props.data.dtStart, props.data.dtEnd) && startRow + newDuration < props.timeArray.length) {
        //     if (props.data.dtEnd.valueOf() - props.data.dtStart.valueOf() < MS_DAY)
        //         props.updateData('dtEnd', props.data.dtStart)
        // }
        props.updateData('endTime', value)
    }

    const changeStartDate = (dataCol, value) => {
        let newEndDate = new Date(value.valueOf() + (props.data.dtEnd.valueOf() - props.data.dtStart.valueOf()))
        props.updateData('dtStart', value)
        props.updateData('dtEnd', newEndDate)
    }

    const changeEndDate = (dataCol, value) => {
        // alert if user sets the end date before the start date
        if (value.valueOf() < props.data.dtStart.valueOf()) setEndDateAlert(true)
        else {
            let startRow = props.timeArray.findIndex((timeRow) => (timeRow.value === props.data.startTime))
            let endTimeRow = props.timeArray.findIndex((timeRow) => (timeRow.value === props.data.endTime))
            let newDuration = endTimeRow - startRow
            // if end date is the same as start date, but has a time that comes before start time            
            if (sameDate(value, props.data.dtStart) && newDuration < 1) {
                    // start time is 11:45 pm, so don't allow the end date to be the same as the start date
                    if (startRow + 1 === props.timeArray.length) setEndTimeAlert(true)
                else {
                    let newEndTime = props.timeArray[startRow+1]  // set end time to 15 minutes later than start time (startRow is index)
                    props.updateData('endTime', newEndTime)
                    props.updateData('dtEnd', value)
                }
            }
            else props.updateData('dtEnd', value)
        }
    }

    const displayConfirmDelete = () => {
        if (props.data.repeatGenerated) {
            setConfirmRepeatGenerated(true)
            setRepeatGeneratedAction(ACTION_DELETE)
        }
        else setConfirmDelete(true)
    }
    
    const handleConfirmDelete = () => {
        setConfirmDelete(false)
        // if it's a booking, use cancel booking 
        if (props.mode===BOOKING) props.cancelBookings([props.data],false)
        else { // AVAILABILITY
            let openAvailabilityEvent = true
            for (let slice of props.data.availabilitySlices) if (slice.status !== 0) openAvailabilityEvent = false
            if (!openAvailabilityEvent) {  // then cancel associated bookings
                // add confirmation modal to be sure they want to delete assoiciated bookings
                let bookingsToCancel = []
                for (let booking of props.bookings) if (booking.idAvailability === props.data.idEvent) {
                    prepEventForNotification(booking)
                    bookingsToCancel.push(booking)
                }
                props.cancelBookings(bookingsToCancel, true)
                cdo.deleteData(bookingsToCancel, true)
            }
        }
        let deleteEvent = {...props.data}
        prepEventForNotification(deleteEvent)
        cdo.deleteData(deleteEvent, cbDelete)
    }

    const cbDelete = (err, result) => {
        if (!err && !result.error) {
            props.deleteData()
        }
        else {
            alert(`Error ${result.error.errno} deleting event.  ${result.error.code} - ${result.error.sqlMessage}`)
        }  
    }

    const checkAvailabilityOverlap = () => {
        let newEvents = [{...props.data}]
        let newDtStart = new Date(props.data.dtStart.getFullYear(), props.data.dtStart.getMonth(),
            props.data.dtStart.getDate(), getHours(props.data.startTime), getMins(props.data.startTime))
        let newDtEnd = new Date(props.data.dtEnd.getFullYear(), props.data.dtEnd.getMonth(),
            props.data.dtEnd.getDate(), getHours(props.data.endTime), getMins(props.data.endTime))
        newEvents[0].dtStart = newDtStart
        newEvents[0].dtEnd = newDtEnd
        let newRepeatEvents = formulateRepeatEventsForSingleEvent(newEvents[0], newEvents[0].dtStart.getFullYear())
        if (newRepeatEvents.length > 0) newEvents = newEvents.concat(newRepeatEvents)
        console.table(newEvents)
        for (let eventToCheck of newEvents) {
            for (let a of props.availability) {
                if (eventToCheck.dtStart.valueOf() < a.dtEnd.valueOf() && eventToCheck.dtEnd.valueOf() > a.dtStart.valueOf()
                    && eventToCheck.idEvent !== a.idEvent) return true
            }
        }
        return false
    }

    const displayConfirmSave = () => {
        if (props.mode !== AVAILABILITY || !checkAvailabilityOverlap()) {
            if (props.data.repeatGenerated) {
                setConfirmRepeatGenerated(true)
                setRepeatGeneratedAction(ACTION_SAVE)
            }
            else handleSaveChanges()
        }
       else setDisplayOverlapModal(true)
    }
    
    const handleSaveChanges = () => {
        setConfirmCancel(false)
        saveEvent()
    }

    const checkDirty = () => {
        if (props.dirty) setConfirmCancel(true)
        else props.cancelData()
    }

    const handleConfirmCancel = () => {
        setConfirmCancel(false)
        props.cancelData()
    }

    const buildEndTimeArray = () => {
        let endTimeArray = []
        let startTimeIndex = props.timeArray.findIndex((timeRow) => (timeRow.value === props.data.startTime))
        if (startTimeIndex !== props.timeArray.length) { // if start time is not 11:45pm
            if (sameDate(props.data.dtEnd, props.data.dtStart)) //if less or equal 1 day
                endTimeArray = props.timeArray.slice(startTimeIndex + 1) // startrow+1 through 11:45pm
            else startTimeIndex = props.timeArray.length-1 // if more than 1 day, set start index to 96
        }
        endTimeArray = endTimeArray.concat(props.timeArray.slice(0,startTimeIndex+1))//add 12am thru start time
        return endTimeArray
    }

    const makeCustomCaption = (timeFrame) => {
        let customRepeatCaption = ''
        let daysOfWeekRepeatCounter = 0
        allWeekdaysChecked.current = false
        allDaysOfWeekChecked.current = false
        oneDayOfWeekChecked.current = false
        if (props.data.repeatInterval === 1) {
            if (timeFrame === REPEAT_DAILY) customRepeatCaption = 'daily'
            else if (timeFrame === REPEAT_WEEKLY) customRepeatCaption = 'weekly'
            else if (timeFrame === REPEAT_MONTHLY_ORDINAL ||
                timeFrame === REPEAT_MONTHLY_LAST ||
                    timeFrame === REPEAT_MONTHLY_DATE) customRepeatCaption = 'monthly'
            else if (timeFrame === REPEAT_YEARLY)
                customRepeatCaption =
                    `yearly on ${props.data.dtStart.toLocaleDateString('en-US',{month: 'short', day: 'numeric'})}`
        } else {// repeat interval is > 1
            if (timeFrame === REPEAT_DAILY) customRepeatCaption =
                `Every ${props.data.repeatInterval} days`
            else if (timeFrame === REPEAT_WEEKLY) customRepeatCaption =
                `Every ${props.data.repeatInterval} weeks`
            else if (timeFrame === REPEAT_MONTHLY_ORDINAL ||
                timeFrame === REPEAT_MONTHLY_LAST ||
                timeFrame === REPEAT_MONTHLY_DATE) customRepeatCaption =
                `Every ${props.data.repeatInterval} months`
            else if (timeFrame === REPEAT_YEARLY) customRepeatCaption =
                `Every ${props.data.repeatInterval} years on ${props.data.dtStart.toLocaleDateString('en-US',{month: 'short', day: 'numeric'})}`
            }
        if (timeFrame === REPEAT_WEEKLY) {
            if (props.data.repeatSun || props.data.repeatMon || props.data.repeatTue || props.data.repeatWed ||
                props.data.repeatThu || props.data.repeatFri || props.data.repeatSat) {
                    customRepeatCaption += ' on'
                if (props.data.repeatSun && props.data.repeatMon && props.data.repeatTue && props.data.repeatWed &&
                    props.data.repeatThu && props.data.repeatFri && props.data.repeatSat) {
                        customRepeatCaption += ' all days'
                        allDaysOfWeekChecked.current = true
                    }
                else if (props.data.repeatMon && props.data.repeatTue && props.data.repeatWed &&
                        props.data.repeatThu && props.data.repeatFri && !props.data.repeatSun &&
                        !props.data.repeatSat) {
                            customRepeatCaption += ' weekdays'
                            allWeekdaysChecked.current = true
                        }
                else {
                    if (props.data.repeatSun) {
                        customRepeatCaption += ' Sunday'
                        daysOfWeekRepeatCounter++
                    }
                    if (props.data.repeatMon) {
                        if (daysOfWeekRepeatCounter >= 1) customRepeatCaption += ','
                        customRepeatCaption +=' Monday'
                        daysOfWeekRepeatCounter++
                    }
                    if (props.data.repeatTue) {
                        if (daysOfWeekRepeatCounter >= 1) customRepeatCaption += ','
                        customRepeatCaption +=' Tuesday'
                        daysOfWeekRepeatCounter++
                    }
                    if (props.data.repeatWed) {
                        if (daysOfWeekRepeatCounter >= 1) customRepeatCaption += ','
                        customRepeatCaption +=' Wednesday'
                        daysOfWeekRepeatCounter++
                    }
                    if (props.data.repeatThu) {
                        if (daysOfWeekRepeatCounter >= 1) customRepeatCaption += ','
                        customRepeatCaption +=' Thursday'
                        daysOfWeekRepeatCounter++
                    }
                    if (props.data.repeatFri) {
                        if (daysOfWeekRepeatCounter >= 1) customRepeatCaption += ','
                        customRepeatCaption +=' Friday'
                        daysOfWeekRepeatCounter++
                    }
                    if (props.data.repeatSat) {
                        if (daysOfWeekRepeatCounter >= 1) customRepeatCaption += ','
                        customRepeatCaption +=' Saturday'
                    }
                    if (daysOfWeekRepeatCounter === 1) oneDayOfWeekChecked.current = true
                }
            }
        }
        // monthly repeat types
        if (timeFrame === REPEAT_MONTHLY_ORDINAL) customRepeatCaption +=
            ` on the ${calcDayOrdinal()} ${props.data.dtStart.toLocaleDateString('en-US', {weekday: 'long'})}`
        if (timeFrame === REPEAT_MONTHLY_LAST) customRepeatCaption +=
            ` on the last ${props.data.dtStart.toLocaleDateString('en-US', {weekday: 'long'})}`
        if (timeFrame === REPEAT_MONTHLY_DATE) customRepeatCaption +=
            ` on the ${getDateOrdinal(props.data.dtStart.getDate())}`
        // repeat end types
        if (props.data.repeatEndType === 1) customRepeatCaption +=
            ` until ${props.data.repeatEnd.toLocaleDateString('en-US',{month: 'short', day: 'numeric', year: 'numeric'})}`
        if (props.data.repeatEndType === 2) customRepeatCaption +=
            ` ${props.data.repeatOccurences} times`
        return customRepeatCaption
    }

    const addCustomOption = () => {
        let timeFrame = props.data.repeatTimeFrame
        if (timeFrame === REPEAT_MONTHLY_DATE) timeFrame = props.data.repeatMonthlyType
        let newRepeatOption = {caption: makeCustomCaption(timeFrame), value: REPEAT_CUSTOM_SPECIFIC}
        let newRepeatSelection = REPEAT_CUSTOM_SPECIFIC
        // update newRepeatSelection if repeatType can be a default option
        if (parseInt(props.data.repeatInterval) === 1 && parseInt(props.data.repeatEndType) === 0) {
            if (timeFrame === REPEAT_DAILY) newRepeatSelection = REPEAT_DAILY
            if (timeFrame === REPEAT_WEEKLY && oneDayOfWeekChecked.current)
                newRepeatSelection = REPEAT_WEEKLY
            if (timeFrame === REPEAT_WEEKLY && allDaysOfWeekChecked.current)
                newRepeatSelection = REPEAT_DAILY
            if (timeFrame === REPEAT_WEEKLY && allWeekdaysChecked.current)
                newRepeatSelection = REPEAT_WEEKDAYS
            if (timeFrame === REPEAT_MONTHLY_ORDINAL)
                newRepeatSelection = REPEAT_MONTHLY_ORDINAL
            if (timeFrame === REPEAT_MONTHLY_LAST)
                newRepeatSelection = REPEAT_MONTHLY_LAST
            if (timeFrame === REPEAT_MONTHLY_DATE)
                newRepeatSelection = REPEAT_MONTHLY_DATE
            if (timeFrame === REPEAT_YEARLY) newRepeatSelection = REPEAT_YEARLY
        }
        let newRepeatOptions = [...repeatOptions]
        let customSpecificIndex = repeatOptions.findIndex((option)=>option.value === REPEAT_CUSTOM_SPECIFIC)
        if (customSpecificIndex > 1)  // previously custom generated option already exists
            if (newRepeatSelection === REPEAT_CUSTOM_SPECIFIC) 
                newRepeatOptions.splice(newRepeatOptions.length-2, 1, newRepeatOption) //is custom, slice out old custom, and add new
            else newRepeatOptions.splice(newRepeatOptions.length-2, 1)  //not custom, is default option, but previous custom exists, so slice it out
        else // previously custom generated option does not exist
            if (newRepeatSelection === REPEAT_CUSTOM_SPECIFIC) newRepeatOptions.splice(newRepeatOptions.length-1, 0, newRepeatOption)
        setRepeatOptions(newRepeatOptions)
        props.updateData('repeatType', newRepeatSelection)
    }

    const minutePortion = (timeString) => {
        let colon = timeString.indexOf(':')
        return timeString.substring(colon + 1, colon + 3)
    }

    const buildBookingStartTimeArray = () => {
        let startTimeArray = []
        if (!availabilityStartIndex.current) calculateTimeIndices()
        // loop through the availability slices that are shown on the current view date
        // beginning with the time array index of the availability event start time
        for (let i = availabilityStartIndex.current; 
                i < availabilityEndIndex.current && 
                i < props.timeArray.length; i++){
            // if the row (slice) is compatible with the service's start time increment
            if (props.serviceData.offer.startTimeIncrement === 0 ||
                 (props.serviceData.offer.startTimeIncrement === 1 && 
                  (minutePortion(props.timeArray[i].value) === '30' || 
                   minutePortion(props.timeArray[i].value) === '00')) ||
                 (props.serviceData.offer.startTimeIncrement === 2 && 
                  minutePortion(props.timeArray[i].value) === '00')) {
                // found row that works for startTimeIncrement
                let available = true
                // availabilitySliceStartIndex is the index (relative to the availability event)
                // of the availability slice being assessed as a possible start time
                // it is the time array index - availability event start + previous-day start adjustment (if any)
                let availabilitySliceStartIndex = i - availabilityStartIndex.current + previousDayStartAdjustment.current
                // availabilitySliceEndIndex is the index (relative to the availability event)
                // of the availability event end slice, including previous-day start adjustment (if any)
                let availabilitySliceEndIndex = availabilityEndIndex.current - availabilityStartIndex.current + 
                    previousDayStartAdjustment.current
                // if the slice plus the minTimeIncrement goes beyond the end of the availability event,
                // that slice is not available to be a start time
                if (availabilitySliceStartIndex + (props.serviceData.offer.minTimeIncrement / 15) > 
                    availabilitySliceEndIndex) available = false
                // check for existing bookings:
                // loop through each availability slice if it is available (per previous if statement),
                // it is within the availability event, and it + the minTimeIncrement is within the availability event
                for (let sliceIndex = availabilitySliceStartIndex;
                     available && sliceIndex < availabilitySliceEndIndex &&
                     sliceIndex < availabilitySliceStartIndex + props.serviceData.offer.minTimeIncrement / 15; 
                     sliceIndex++) {
                    // if the slice status is partially booked or unavailable
                    if (props.availabilityEvent.availabilitySlices[sliceIndex].status !== 0) {
                        // find the start index (relative to the time array) of the existing booking
                        let bookedStart = props.timeArray.findIndex(element => 
                            element.value===props.selectedBookingStartTime)
                        // find the end index (relative to the time array) of the existing booking
                        let bookedEnd = props.timeArray.findIndex(element => 
                            element.value===props.selectedBookingEndTime)
                        // if the existing booking is not booked by this user, the slice is unavailable
                        if (!props.availabilityEvent.availabilitySlices[sliceIndex].bookedByUser)
                            available = false
                        // if it is booked by the user, but outside of the current booking time slot, 
                        // then it is unavailable and constraints the current start time candidate
                        // (can't book over other appt of the same user)
                        else if (i + (sliceIndex-availabilitySliceStartIndex) < bookedStart || 
                            bookedEnd < i + (sliceIndex-availabilitySliceStartIndex)) available = false
                    }
                }
                // if the slice is available, add it to the start time array
                if (available) startTimeArray.push(props.timeArray[i])
            }
        }
        return startTimeArray
    }

    const buildBookingEndTimeArray = () => {
        let endTimeArray = []
        let startTimeIndex = props.timeArray.findIndex(element=>element.value===props.data.startTime)
        // determine starting point to loop through the availabilitySlices by using timeArray indices
        // the starting point is the difference between the time selected and the start of the availability
        // plus the minimum time for the appointment, plus any prior day adjustment (from slices already passed)
        let availabilitySliceStartIndex = startTimeIndex - availabilityStartIndex.current + 
            (props.serviceData.offer.minTimeIncrement / 15) + previousDayStartAdjustment.current
        // determine one potential ending point to the loop by using timeArray indices
        // the ending point is the difference between the end and start of the availability event (# of 15m slices)
        let availabilitySliceEndIndex = availabilityEndIndex.current - availabilityStartIndex.current  // this might able to be the availitySlices.length
        // initialize the found conflict flag (a conflict means the end time doesn't work)
        let foundConflict = false
        // declare loop varible before the for statement so that it can be used after to add the last row (ending time of last row checked)
        let sliceIndex
        for (sliceIndex = availabilitySliceStartIndex;
            !foundConflict &&  // if we found conflict (the end time is not available), stop the loop
            sliceIndex < availabilitySliceEndIndex &&  // be sure to stop at the end of the slices
            (sliceIndex < startTimeIndex - availabilityStartIndex.current + previousDayStartAdjustment.current +
                (props.serviceData.offer.maxTimeIncrement / 15) || //also stop at the end of the max time
             props.serviceData.offer.maxTimeIncrement === 0); // or keep going if there is no max time
            sliceIndex++) {
            // add valid time to the list of possible end times
            endTimeArray.push(props.timeArray[(sliceIndex + availabilityStartIndex.current - 
                previousDayStartAdjustment.current)%96])
            if (props.availabilityEvent.availabilitySlices[sliceIndex].status !== 0) {
                // determine if the current blocking slice is actually the same booking by current user
                let bookedStart = props.timeArray.findIndex(element => 
                    element.value===props.selectedBookingStartTime)
                let bookedEnd = props.timeArray.findIndex(element => 
                    element.value===props.selectedBookingEndTime)
                let i = (sliceIndex + availabilityStartIndex.current - previousDayStartAdjustment.current)%96
                if (!props.availabilityEvent.availabilitySlices[sliceIndex].bookedByUser)
                    foundConflict = true
                else if (i < bookedStart || bookedEnd < i)  foundConflict = true  // if booked by user, but outside current booking, then it's still a conflict
            }
        }
        //include the last one even though it's outside the availabilitySlices
        if (!foundConflict) endTimeArray.push(props.timeArray[(sliceIndex + availabilityStartIndex.current - 
            previousDayStartAdjustment.current)%96])
        return (endTimeArray)
    }

    const getBookedCount = () => {
        let startTimeIndex = props.timeArray.findIndex(element=>element.value===props.data.startTime)
        if (!availabilityStartIndex.current) { //to make sure useEffect has run to set this ref
            calculateTimeIndices()
        }
        let availabilitySliceStartIndex = startTimeIndex - availabilityStartIndex.current + 
                previousDayStartAdjustment.current
            return props.availabilityEvent.availabilitySlices[availabilitySliceStartIndex].bookedCount
    }

    return (
        <Fragment>
            <div className='event-container'>
                <h1 className='maintain-event-heading'>{props.mode === AVAILABILITY ? 'Set Availability' :
                    `Book ${props.serviceData.entityTitle}`}</h1>
                <div className='event-details-container'>
                    <div className='dates-and-times'>
                        {props.mode === AVAILABILITY ?
                        <Fragment>
                            <div className='maintain-event-date'>
                                <DatePicker value={props.data.dtStart} onChange={changeStartDate}
                                    dataCol='dtStart'></DatePicker>
                            </div>
                            <Select id='startTime' label='Start Time'
                                value={props.data.startTime} styleName='event-time-values'
                                onChange={changeTime} dataCol='startTime' disabled={props.data.allDay}
                                data={props.timeArray} optionsStyle='maintain-event-options'
                                type='text'>
                            </Select>
                            <div className='maintain-event-date'>
                                <DatePicker value={props.data.dtEnd} onChange={changeEndDate}
                                    dataCol='dtEnd'></DatePicker>
                            </div>
                            <Select id='endTime' label='End Time' value={props.data.endTime}
                                styleName='event-time-values' onChange={changeTime} dataCol='endTime'
                                disabled={props.data.allDay} data={buildEndTimeArray()}
                                optionsStyle='maintain-event-options' type='text'>
                            </Select>
                            <CheckBox id='allDayOption' dataCol='allDay' checked={props.data.allDay}
                                styleName='all-day-checkbox' onChange={toggleAllDay}>All day event</CheckBox>
                            <div className='duration'>Duration: {formatDuration(duration * 15)}</div>
                        </Fragment>:
                        // props.mode = BOOKING:
                        <Fragment>
                            {props.maintainEventMode === 1 ? // maintainEventMode = new booking
                                <Fragment>
                                    <TileSelect id='startTime' label='Start Time' value={props.data.startTime}
                                        onChange={changeTime} dataCol='startTime'
                                        data={buildBookingStartTimeArray()} type='text'></TileSelect>
                                    {props.data.startTime &&
                                    <TileSelect id='endTime' label='End Time' value={props.data.endTime}
                                        onChange={changeTime} dataCol='endTime'
                                        data={buildBookingEndTimeArray()} type='text'></TileSelect>}
                                    <div className='duration'>Duration: {formatDuration(duration * 15)}</div>
                                </Fragment> :
                                // maintainEventMode = partially booked:
                                <Fragment>
                                <div className='fixed-times'>
                                    <span>Start time: <span className='display-view-booking-value'>
                                        {props.data.startTime}</span></span>
                                    <span>End time: <span className='display-view-booking-value'>
                                        {props.data.endTime}</span></span>
                                    <div className='duration'>Duration: {formatDuration(duration * 15)}</div>
                                </div>
                                <div className='customer-count'>
                                    Number of customers currently booked at this time:&nbsp;
                                    <span className='display-view-booking-value'>
                                        {getBookedCount()}</span></div>
                                </Fragment>}
                        </Fragment>}
                    </div>
                    <div className='event-details'>
                        {props.mode === AVAILABILITY ?
                        <Fragment>
                            <Select id='repeatType' data={repeatOptions} label='Repeats'
                                containerStyle='repeat-options-container' styleName='event-details'
                                value={props.data.repeatType} dataCol='repeatType' onChange={props.updateData}
                                optionsStyle='maintain-event-options'>
                            </Select>
                            {props.data.repeatType === REPEAT_CUSTOM &&
                                <CustomRepeat data={props.data} updateData={props.updateData}
                                    cancelCustom={props.cancelCustom}
                                    addCustomOption={addCustomOption}
                                    lastDateOfMonth={props.lastDateOfMonth}
                                    scrollDistance={props.scrollDistance}></CustomRepeat>}
                            <CheckBoxList dataCol='servicesOffered' data={props.data.servicesOffered}
                                onChange={props.updateData} selectAllChecked={props.data.allServices}
                                dataColAll='allServices' label='Services Offered'></CheckBoxList>
                        </Fragment> :
                        // props.mode = BOOKING:
                        <section className='display-view-booking-container'>
                            <h2 className='sub-section-heading'>Booking Details</h2>
                            <div className='display-view-booking-blocks'>
                                <HelpIcon styleName='display-view-help'>
                                    This is the shortest duration someone can book this service.</HelpIcon>
                                <span className='display-view-booking-label'>Minimum Time Block:</span>
                                <span className='display-view-booking-value'>
                                    {formatTimeBlockValues(props.serviceData.offer.minTimeIncrement)}
                                </span>
                            </div>
                            {props.serviceData.offer.maxTimeIncrement !== 0 &&
                                <div className='display-view-booking-blocks'>
                                    <HelpIcon styleName='display-view-help'>
                                        This is the longest duration someone can book this service.</HelpIcon>
                                <span className='display-view-booking-label'>Maximum Time Block:</span>
                                <span className='display-view-booking-value'>
                                {formatTimeBlockValues(props.serviceData.offer.maxTimeIncrement)}</span>
                                </div>}
                            <div className='display-view-booking-blocks'>
                                <HelpIcon styleName='display-view-help'>
                                    Your appointment can start at this portion of the hour.
                                </HelpIcon>
                                <span className='display-view-booking-label'>Start Time Increment:</span>
                                <span className='display-view-booking-value'>
                                    {START_TIME_OPTIONS[START_TIME_OPTIONS.findIndex(e=>e.value===props.serviceData.offer.startTimeIncrement)].caption}</span>
                            </div>
                            <div className='display-view-booking-blocks'>
                                <HelpIcon styleName='display-view-help'>
                                    You must book with at least this much notice before the appointment starts.
                                </HelpIcon>
                                <span className='display-view-booking-label'>Booking Lead Time:</span>
                                <span className='display-view-booking-value'>
                                    {formatLeadTime(props.serviceData.offer.bookingLeadNumber,
                                        props.serviceData.offer.bookingLeadType)}</span>
                            </div>
                            {props.serviceData.offer.cancelLeadNumber !== 0 &&
                                <div className='display-view-booking-blocks'>
                                    <HelpIcon styleName='display-view-help'>
                                        You must cancel with at least this much notice to avoid being charged.
                                    </HelpIcon>
                                    <span className='display-view-booking-label'>Cancellation Lead Time:</span>
                                    <span className='display-view-booking-value'>
                                    {formatLeadTime(props.serviceData.offer.cancelLeadNumber,
                                        props.serviceData.offer.cancelLeadType)}</span>
                                </div>}
                            {props.serviceData.offer.cancelLeadNumber && props.serviceData.offer.cancelFee &&
                                <div className='display-view-booking-blocks'>
                                <HelpIcon styleName='display-view-help'>
                                    The cancellation fee is a percentage of the total price of the booked 
                                        appointment.
                                </HelpIcon>
                                <span className='display-view-booking-label'>Cancellation Fee:</span>
                                <span className='display-view-booking-value'>
                                    {props.serviceData.offer.cancelFee}%</span>
                                </div>}
                            <div className='display-view-booking-blocks'>
                                <HelpIcon styleName='display-view-help'>
                                    The number of customers who can participate in each appointment.
                                </HelpIcon>
                                <span className='display-view-booking-label'>Customers per Time Block:</span>
                                <span className='display-view-booking-value'>
                                    {props.serviceData.offer.quantity}</span>
                            </div>
                        </section>}
                    </div>
                </div>
                <div className='button-container'>
                    <IconButton styleName='save-button' disabled={saveDisabled} src={icons.saveIcon}
                        onClick={displayConfirmSave} 
                        caption={props.mode === BOOKING ? 'Book' : 'Save'}></IconButton>
                    <IconButton styleName='delete-button' disabled={deleteDisabled} src={icons.deleteIcon}
                        onClick={displayConfirmDelete} caption='Delete'></IconButton>
                    <IconButton styleName={props.dirty ? 'cancel-button' : 'edit-button'} 
                        caption={props.dirty ? 'Cancel' : 'Close'} src={icons.closeIcon}
                        onClick={checkDirty}></IconButton>
                </div>
            </div>
            <div className='hazy-div'></div>
            {confirmDelete && 
                <Modal buttonText='Delete' onClick={handleConfirmDelete} buttonTwoText='Cancel delete'
                    onClickTwo={()=>setConfirmDelete(false)}>Delete this time-block?</Modal>}
            {confirmCancel &&
                <Modal buttonText='Save changes' onClick={handleSaveChanges} buttonTwoText='Cancel changes'
                    onClickTwo={handleConfirmCancel}>You have unsaved changes.</Modal>}
            {confirmRepeatGenerated &&
                <RepeatUpdateOptions action={repeatGeneratedAction} 
                setConfirmRepeatGenerated={setConfirmRepeatGenerated}></RepeatUpdateOptions>}
            {endDateAlert &&
                <Modal buttonText='OK' onClick={()=>setEndDateAlert(false)}>
                    The end date and time can not be before the start date and time.</Modal>}
            {endTimeAlert &&
                <Modal buttonText='OK' onClick={()=>setEndTimeAlert(false)}>
                    There's not enough time left on&nbsp;
                    {props.data.dtStart.toLocaleDateString('en-US',{month: 'long', day: '2-digit'})}&nbsp;
                    to make the end date the same.</Modal>}
            {displayOverlapModal &&
                <Modal buttonText='OK' onClick={()=>setDisplayOverlapModal(false)}>
                    Overlapping availability time-blocks are not allowed. You may edit this one or the existing time-block to avoid the conflict.
                </Modal>}
        </Fragment>
    )
}

export default MaintainEvent
