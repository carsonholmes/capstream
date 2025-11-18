import React from 'react'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'
import './RepeatUpdateOptions.css'

const RepeatUpdateOptions = (props) => {

    const setHeadingAction = () => {
        if (props.action === 1) return 'Delete'
        return 'Edit'
    }

    return (
        <div className='modal-container'>
            <div className='repeat-update-options-container'>
                <div className='repeat-update-radio-block'>
                    <h1 className='custom-repeat-heading'>{setHeadingAction()} Repeating Event</h1>
                    <input type='radio' className='repeat-update-options' id='this'
                        name='repeatUpdateOptions' value='this' checked
                        onChange={()=>props.updateData('repeatUpdateOption', 0)}>
                    </input>
                    <label className='repeat-update-options' htmlFor='this'>This event</label><br />
                    <input type='radio' className='repeat-update-options'
                        id='thisAndFollowing' name='repeatUpdateOptions' value='thisAndFollowing'
                        onChange={()=>props.updateData('repeatUpdateOption', 1)}>
                    </input>
                    <label className='repeat-update-options' htmlFor='thisAndFollowing'>
                        This and following events</label><br />
                    <input type='radio' className='repeat-update-options'
                        id='all' name='repeatUpdateOptions' value='all'
                        onChange={()=>props.updateData('repeatUpdateOption', 2)}>
                    </input>
                    <label className='repeat-update-options' htmlFor='all'>All events</label><br />
                </div>
                <div className='button-container'>
                    <IconButton styleName='save-button' src={icons.saveIcon} caption='OK'></IconButton>
                    <IconButton styleName='cancel-button' src={icons.closeIcon} caption='Cancel'
                        onClick={()=>props.setConfirmRepeatGenerated(false)}></IconButton>
                </div>
            </div>
            <div className='hazy-div'></div>
        </div>
    )
}

export default RepeatUpdateOptions