import { LEAD_TYPES_SINGULAR, LEAD_TYPES_PLURAL } from "./serviceConstants"
import { REPEAT_DAILY, REPEAT_WEEKLY, REPEAT_WEEKDAYS, REPEAT_MONTHLY_ORDINAL,
    REPEAT_MONTHLY_LAST, REPEAT_MONTHLY_DATE, REPEAT_YEARLY } from "../cdos/EventCDO"

export const formatTimeBlockValues = (value) => {
    let valueDisplay = ''
    let hours = Math.floor(value / 60)
    if (hours === 1) valueDisplay += '1 Hour '
    else if (hours > 1) valueDisplay += hours + ' Hours '
    let minutes = (value % 60)
    if (minutes !== 0) valueDisplay += minutes + ' Minutes'
    return valueDisplay        
}

export const formatLeadTime = (number, timeType) => {
    if (number === 1) return number + ' ' + LEAD_TYPES_SINGULAR[timeType].caption
    else return number + ' ' + LEAD_TYPES_PLURAL[timeType].caption
}

export const sameDate = (d1, d2) => {
    // are d1 and d2 the same date
    if (d1 && d1.getFullYear)
        return (d1.getFullYear() === d2.getFullYear() && d1.getMonth() === d2.getMonth() &&
            d1.getDate() === d2.getDate())
    else return true  // if dates haven't propogated just assume they are the same
}

export const dateWithoutTime = (dt) => {
    let d = new Date(dt.getFullYear(), dt.getMonth(), dt.getDate())
    return d
}

export const formatDuration = (minutes) => {
    let d = 0
    if (minutes > 1440) {
        d = Math.floor(minutes / 1440)
        minutes = minutes % 1440
    }
    let m = minutes % 60
    let h = (minutes - m) / 60
    return (d > 0 ? `${d}d ` : '') + (h > 0 ? `${h}h ` : '') + (m > 0 ? `${m}m` : '')
}

export const calcDayOrdinal = (dateTime) => {
    let date = dateTime.getDate()
    if (date / 7 <= 1) return 1
    else if (date / 7 > 1 && date / 7 <= 2) return 2
    else if (date / 7 > 2 && date / 7 <= 3) return 3
    else if (date / 7 > 3 && date / 7 <= 4) return 4
}

const MAX_REPEAT = 366

export const addDays = (d, days) => {
    var date = new Date(d.valueOf());
    date.setDate(date.getDate() + days);
    return date;
}
export const addMonths = (d, months) => {
    var date = new Date(d.valueOf());
    date.setMonth(date.getMonth() + months);
    return date;
}
export const addYears = function(d, years) {
    var date = new Date(d.valueOf());
    date.setFullYear(date.getFullYear() + years);
    return date;
}

export const formulateRepeatEventsForSingleEvent = (event, currentYear) => {
    let newEvents = []
    let searchDate = new Date()
    let dayOfWeek = 0
    let done = false
    let counter = 0
    switch (event.repeatType) {
        case REPEAT_DAILY:
            while (!done) {
                counter += event.repeatInterval 
                if (event.repeatEndType === 0 && counter > MAX_REPEAT) done = true
                if (event.repeatEndType === 1 && 
                    addDays(event.dtStart, counter) > event.repeatEnd) done = true
                if (event.repeatEndType === 2 && ( counter / event.repeatInterval ) > event.occurences) done = true
                if (!done) {
                    let newRepeatEvent = {...event}
                    newRepeatEvent.dtStart = addDays(event.dtStart, counter)
                    newRepeatEvent.dtEnd = addDays(event.dtEnd, counter)
                    newRepeatEvent.repeatGenerated = true
                    newEvents.push(newRepeatEvent)
                }
            }
            break
        case REPEAT_WEEKLY:
            while (!done) {
                counter += event.repeatInterval * 7
                if (event.repeatEndType === 0 && counter > MAX_REPEAT) done = true
                if (event.repeatEndType === 1 &&
                    addDays(event.dtStart, counter) > event.repeatEnd) done = true
                if (event.repeatEndType === 2 &&
                    (counter / event.repeatInterval / 7) > event.occurences) done = true
                if (!done) {
                    let newRepeatEvent = {...event}
                    newRepeatEvent.dtStart = addDays(event.dtStart, counter)
                    newRepeatEvent.dtEnd = addDays(event.dtEnd, counter)
                    newRepeatEvent.repeatGenerated = true
                    newEvents.push(newRepeatEvent)
                }
            }
            break
        case REPEAT_WEEKDAYS:
            let occurenceCounter = 1
            while (!done) {
                counter += event.repeatInterval 
                if (event.repeatEndType === 0 && counter > MAX_REPEAT) done = true
                if (event.repeatEndType === 1 && addDays(event.dtStart, counter) > event.repeatEnd)
                    done = true
                if (event.repeatEndType === 2 && occurenceCounter > event.occurences) done = true
                if (!done) {
                    let newRepeatEvent = {...event}
                    newRepeatEvent.dtStart = addDays(event.dtStart, counter)
                    newRepeatEvent.dtEnd = addDays(event.dtEnd, counter)
                    newRepeatEvent.repeatGenerated = true
                    if (newRepeatEvent.dtStart.getDay() !== 0 && newRepeatEvent.dtStart.getDay() !== 6) {
                        occurenceCounter++
                        newEvents.push(newRepeatEvent)
                    }
                }
            }
            break
        case REPEAT_MONTHLY_ORDINAL:
            let ordinal = calcDayOrdinal(event.dtStart)
            dayOfWeek = event.dtStart.getDay()
            while (!done) {
                counter += event.repeatInterval
                searchDate = new Date(event.dtStart.getFullYear(), event.dtStart.getMonth() + counter,
                    1 + (7 * (ordinal-1)), event.dtStart.getHours(), event.dtStart.getMinutes())
                while (searchDate.getDay() !== dayOfWeek) searchDate = addDays( searchDate, 1)
                if (event.repeatEndType === 0 && counter > MAX_REPEAT / 30) done = true
                if (event.repeatEndType === 1 && searchDate > event.repeatEnd) done = true
                if (event.repeatEndType === 2 &&
                    (counter / event.repeatInterval) > event.occurences) done = true
                if (!done) {
                    let newRepeatEvent = {...event}
                    newRepeatEvent.dtStart = searchDate
                    newRepeatEvent.dtEnd = new Date(searchDate.valueOf() + (event.dtEnd.valueOf() - event.dtStart.valueOf()))
                    newRepeatEvent.repeatGenerated = true
                    newEvents.push(newRepeatEvent)
                }
            }
            break
        case REPEAT_MONTHLY_LAST:
            dayOfWeek = event.dtStart.getDay()
            while (!done) {
                counter += event.repeatInterval
                let nextRepeatMonth = new Date(event.dtStart.getFullYear(), event.dtStart.getMonth() + counter + 1, 0)
                let lastDayOfMonth = nextRepeatMonth.getDate()
                searchDate = new Date(event.dtStart.getFullYear(), event.dtStart.getMonth() + counter,
                    lastDayOfMonth - 6, event.dtStart.getHours(), event.dtStart.getMinutes())
                while (searchDate.getDay() !== dayOfWeek) searchDate = addDays( searchDate, 1)
                if (event.repeatEndType === 0 && counter > MAX_REPEAT / 30) done = true
                if (event.repeatEndType === 1 && searchDate > event.repeatEnd) done = true
                if (event.repeatEndType === 2 &&
                    (counter / event.repeatInterval) > event.occurences) done = true
                if (!done) {
                    let newRepeatEvent = {...event}
                    newRepeatEvent.dtStart = searchDate
                    newRepeatEvent.dtEnd = new Date(searchDate.valueOf() + (event.dtEnd.valueOf() - event.dtStart.valueOf()))
                    newRepeatEvent.repeatGenerated = true
                    newEvents.push(newRepeatEvent)
                }
            }
            break
        case REPEAT_MONTHLY_DATE:
            while (!done) {
                counter += event.repeatInterval 
                if (event.repeatEndType === 0 && counter > MAX_REPEAT / 30) done = true
                if (event.repeatEndType === 1 && 
                    addMonths(event.dtStart, counter) > event.repeatEnd) done = true
                if (event.repeatEndType === 2 && ( counter / event.repeatInterval ) > event.occurences) done = true
                if (!done) {
                    let newRepeatEvent = {...event}
                    newRepeatEvent.dtStart = addMonths(event.dtStart, counter)
                    newRepeatEvent.dtEnd = addMonths(event.dtEnd, counter)
                    newRepeatEvent.repeatGenerated = true
                    newEvents.push(newRepeatEvent)
                }
            }
            break
        case REPEAT_YEARLY:
            let nextYearDate = new Date(event.dtStart)
            while (!done) {
                counter += event.repeatInterval
                nextYearDate = addYears(event.dtStart, counter)
                if (event.repeatEndType === 0 && nextYearDate.getFullYear() > currentYear)
                    done = true
                if (event.repeatEndType === 1 && 
                    nextYearDate > event.repeatEnd) done = true
                if (event.repeatEndType === 2 && 
                    (counter > event.occurences || nextYearDate.getFullYear() > currentYear))
                    done = true
                if (!done) {
                    let newRepeatEvent = {...event}
                    newRepeatEvent.dtStart = addYears(event.dtStart, counter)
                    newRepeatEvent.dtEnd = addYears(event.dtEnd, counter)
                    newRepeatEvent.repeatGenerated = true
                    newEvents.push(newRepeatEvent)
                }
            }
            break
        default: break
    }
    return newEvents
}
