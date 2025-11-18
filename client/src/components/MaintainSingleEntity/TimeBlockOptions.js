import React, { Fragment, useEffect, useState } from 'react'
import CheckBox from '../controls/CheckBox/CheckBox'
import RadioButtons from '../controls/RadioButtons/RadioButtons'
import Select from '../controls/Select/Select'
import TextBox, { REGEX_NUMBER } from '../controls/TextBox/TextBox'
import {START_TIME_OPTIONS, TIME_BLOCK_OPTIONS, valueIndex} from '../../shared/serviceConstants'
import HelpIcon from '../controls/HelpIcon/HelpIcon'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'

const TimeBlockOptions = (props) => {

	const updateData = (dataCol, value) => {
        let newOffer = {...props.data}
        newOffer[dataCol] = value
        props.updateData(newOffer)
    }

    const limitBasedOnMin = () => {
        return [TIME_BLOCK_OPTIONS[0]].concat(TIME_BLOCK_OPTIONS.slice(valueIndex(TIME_BLOCK_OPTIONS, props.data.minTimeIncrement)))
    }

    return (
        <Card cardHeading='Edit Time-Block Options' setRef={props.setRef}
            styleHeading='edit-entity-heading'
            styleName='edit-entity-card'>
            <div className='edit-entity-container'>
                <HelpIcon styleName='edit-entity-help'>
                    This is the shortest duration someone can book this service.</HelpIcon>
                <Select id='minTimeIncrement' data={TIME_BLOCK_OPTIONS.slice(1)} label='Minimum Time Block'
                        value={props.data.minTimeIncrement} dataCol='minTimeIncrement'
                        onChange={updateData} styleName='edit-entity'
                        optionsStyle='edit-entity'>
                </Select>
                <HelpIcon styleName='edit-entity-help'>
                    This is the longest duration someone can book this service.</HelpIcon>
                <Select id='maxTimeIncrement' data={limitBasedOnMin()} label='Maximum Time Block'
                        value={props.data.maxTimeIncrement} dataCol='maxTimeIncrement'
                        onChange={updateData} styleName='edit-entity'
                        optionsStyle='edit-entity'>
                </Select>
                <HelpIcon styleName='edit-entity-help'>
                    Choose when customers can begin their appointments.</HelpIcon>
                <Select id='startTimeIncrement' data={START_TIME_OPTIONS} label='Start Time Options'
                        value={props.data.startTimeIncrement} dataCol='startTimeIncrement'
                        onChange={updateData} styleName='edit-entity'
                        optionsStyle='edit-entity'>
                </Select>
            </div>
            <br /><br />
            <IconButton styleName={'primary medium-small'}
                src={icons.saveIcon}
                onClick={props.saveData} caption='Save'>
            </IconButton>
            <IconButton styleName={'primary medium-small'}
                src={icons.closeIcon}
                onClick={props.handleClose} caption='Close'>
            </IconButton>
        </Card>
    )
}

export default TimeBlockOptions