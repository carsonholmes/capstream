import React, {Fragment, useCallback, useEffect, useRef, useState} from 'react';
import {REPEAT_DAILY, REPEAT_WEEKLY, REPEAT_MONTHLY_DATE, REPEAT_MONTHLY_ORDINAL, REPEAT_MONTHLY_LAST,
    REPEAT_YEARLY} from '../../cdos/EventCDO';
import Select from '../controls/Select/Select';
import CheckBox from '../controls/CheckBox/CheckBox';
import './CustomRepeat.css'
import IconButton from '../controls/buttons/IconButton';
import icons from '../../shared/icons';
import TextBox from '../controls/TextBox/TextBox'
import DatePicker from '../controls/DatePicker/DatePicker'
// uses styling from MaintainEvent.css

const weekdaysArray = [
    {dataCol: 'repeatSun', caption: 'S'}, {dataCol: 'repeatMon', caption: 'M'},
    {dataCol: 'repeatTue', caption: 'T'}, {dataCol: 'repeatWed', caption: 'W'},
    {dataCol: 'repeatThu', caption: 'T'}, {dataCol: 'repeatFri', caption: 'F'},
    {dataCol: 'repeatSat', caption: 'S'}]

const TIME_FRAMES_SINGULAR = [
    {caption: 'day', value: REPEAT_DAILY},
    {caption: 'week', value: REPEAT_WEEKLY},
    {caption: 'month', value: REPEAT_MONTHLY_DATE},
    {caption: 'year', value: REPEAT_YEARLY}]

const TIME_FRAMES_PLURAL = [
    {caption: 'days', value: REPEAT_DAILY},
    {caption: 'weeks', value: REPEAT_WEEKLY},
    {caption: 'months', value: REPEAT_MONTHLY_DATE},
    {caption: 'years', value: REPEAT_YEARLY}]

const endOptions = [
    {caption: 'Never', value: 0},
    {caption: 'On', value: 1},
    {caption: 'After', value: 2}]
    
const CustomRepeat = (props) => {

    const [repeatTimeFrameOptions, setRepeatTimeFrameOptions] = useState(TIME_FRAMES_SINGULAR)
    const [repeatMonthlyOptions, setRepeatMonthlyOptions] = useState([])
    const firstTimeScroll = useRef(false)

    // initial window scroll
    useEffect(() => {
        if (!firstTimeScroll.current) {
            window.scrollTo({top: props.scrollDistance})
            firstTimeScroll.current = true
        }
    }, [])

    useEffect(() => {
        if (props.data.repeatInterval > 1) setRepeatTimeFrameOptions(TIME_FRAMES_PLURAL)
        else setRepeatTimeFrameOptions(TIME_FRAMES_SINGULAR)
    }, [props.data.repeatInterval])

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

    useEffect(() => {
        let newRepeatMonthlyOptions = [
        {caption: `on the ${calcDayOrdinal()} ${props.data.dtStart.toLocaleDateString('en-US', {weekday: 'long'})}`,
            value: REPEAT_MONTHLY_ORDINAL},
        {caption: `on the last ${props.data.dtStart.toLocaleDateString('en-US', {weekday: 'long'})}`,
            value: REPEAT_MONTHLY_LAST},
        {caption: `on the ${getDateOrdinal(props.data.dtStart.getDate())}`,
            value: REPEAT_MONTHLY_DATE}
        ]
        let spliced = 0
        if (props.data.dtStart.getDate() > 28) {
            newRepeatMonthlyOptions.splice(0,1)
            spliced++
        }
        if (props.lastDateOfMonth - props.data.dtStart.getDate() > 6) {
            newRepeatMonthlyOptions.splice(1 - spliced,1)
            spliced++
        }
        setRepeatMonthlyOptions(newRepeatMonthlyOptions)
    }, [props.data, calcDayOrdinal, props.lastDateOfMonth])

    const addCustomOption = () => {
        props.addCustomOption()
    }

    return (
        <div className='modal-container'>
            <div className='custom-repeat-container'>
                <h1 className='custom-repeat-heading'>Custom Repeat</h1>
                <h2 className='custom-repeat-sub-heading'>Repeat every:</h2>
                <div className='repeat-intervals'>
                    <TextBox id='repeatInterval' styleName='custom-repeat-interval' placeholder='Repeat Every'
                        dataCol='repeatInterval' onChange={props.updateData} value={props.data.repeatInterval}>
                    </TextBox>
                </div>
                <Select id='repeatTimeFrame' data={repeatTimeFrameOptions} value={props.data.repeatTimeFrame}
                    onChange={props.updateData} styleName='repeat-select' dataCol='repeatTimeFrame'
                    label='Repeat Time Frame' optionsStyle='maintain-event-options'></Select>
                {(props.data.repeatTimeFrame === REPEAT_WEEKLY) &&
                    <div className='day-checkboxes-container'>
                        {weekdaysArray.map((row, index) => {
                            return (
                                <CheckBox key={index} id={row.dataCol} dataCol={row.dataCol}
                                    onChange={props.updateData} checked={props.data[row.dataCol]}
                                    disabled={index === props.data.dtStart.getDay()}
                                    styleName='repeat-day-checkboxes'>{row.caption}</CheckBox>
                            )
                        })}
                    </div>}
                {(props.data.repeatTimeFrame === REPEAT_MONTHLY_DATE) &&
                    <Select id='repeatMonthlyType' data={repeatMonthlyOptions} 
                        value={props.data.repeatMonthlyType}
                        onChange={props.updateData} styleName='repeat-select'
                        dataCol='repeatMonthlyType' label='Monthly Repeat Type'
                        optionsStyle='maintain-event-options'></Select>}
                    <h2 className='custom-repeat-sub-heading ends-sub-heading'>Ends:</h2>
                    <div className='repeat-end-block'>
                        {endOptions.map((row,index)=>{
                            return (
                                <Fragment key={row.value}>
                                    <input type='radio' className='custom-radio-end-options'
                                        id={row.caption} name='repeatEndTypes' 
                                        checked={row.value===props.data.repeatEndType}
                                        onChange={()=>props.updateData('repeatEndType', row.value)}>
                                    </input>
                                    <label className='custom-radio-end-options' htmlFor={row.caption}>
                                        {row.caption}</label>
                                    {index === 1 &&
                                        <div>
                                            <DatePicker value={props.data.repeatEnd} onChange={props.updateData}
                                                dataCol='repeatEnd' disabled={props.data.repeatEndType !== 1}>
                                            </DatePicker>
                                        </div>}
                                    {index === 2 &&
                                        <TextBox placeholder='Occurences' dataCol='repeatOccurences'
                                            disabled={props.data.repeatEndType !== 2}
                                            id='repeatOccurences' styleName='occurences'
                                            onChange={props.updateData} value={props.data.repeatOccurences}>
                                        </TextBox>}
                                </Fragment>
                            )   
                        })}
                    </div>
                    <div className='button-container'>
                    <IconButton styleName='save-button' caption={props.idEntity ? 'Save' : 'Done'} 
                        onClick={addCustomOption}
                        src={props.idEntity ? icons.saveIcon : icons.checkIcon} ></IconButton>
                    <IconButton styleName='cancel-button' caption='Cancel' src={icons.closeIcon}
                        onClick={props.cancelCustom}></IconButton>
                </div>
            </div>
            <div className='hazy-div'></div>
        </div>
    )
};

export default CustomRepeat;
