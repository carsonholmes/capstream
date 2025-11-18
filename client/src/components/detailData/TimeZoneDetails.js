import React, { Fragment, useState } from 'react'
import './TimeZoneDetails.css'
import Select from '../controls/Select/Select'
import { timeZoneData } from '../../cdos/ProfileCDO'

const TimeZoneDetails = (props) => {

    const onChange = (dataCol, value) => {
        props.onChange(dataCol, value)
    }

    return (
        <Fragment>
            <div className='time-zone-explanation'>
                Setting this ensures that your notifications contain accurate time information.
            </div>
            <Select id='userTimeZone' dataCol='userTimeZone' label='Preferred time zone'
            data={timeZoneData} value={props.data.userTimeZone} onChange={onChange}
            placeholderStyle='time-zone-placeholder' optionsStyle='time-zone-options'
            styleName='time-zone-value' containerStyle='time-zone-container'></Select>
        </Fragment>
    )
}

export default TimeZoneDetails
