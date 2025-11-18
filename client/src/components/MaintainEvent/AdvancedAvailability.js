import React from 'react'
import './CreateAvailability.css'

const AdvancedAvailability = () => {
    return (
        <>
            <div className='advanced-availability'>
                <label for='block-start' className='combo-label'>Time Blocks Start: </label>
                <select id='block-start' name='block-start'/*Do we need name?*/>
                    <option value='on-the-hour'>On the hour</option>
                    <option value='on-the-half-hour'>On the half-hour</option>
                    <option value='on-the-quarter-hour'>On the quarter-hour</option>
                    <option value='unspecified'>Unspecified</option>
                </select>
            </div>
            <div className='advanced-availability'>
                <label for='confirm-option' className='combo-label'>Confirm Booking Requests: </label>
                <select id='confirm-option' name='confirm-option'/*Do we need name?*/>
                    <option value='manually'>Manually</option>
                    <option value='automatically'>Automatically</option>
                </select>
            </div>
        </>
    )
}

export default AdvancedAvailability
