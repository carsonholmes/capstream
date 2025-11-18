import React, { useState } from 'react'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'
import Modal from '../controls/Modal/Modal'

const AttributeListValues = (props) => {

    const [duplicates, setDuplicates] = useState(false)

    const addListValue = () => {
        let values = [...props.data]
        values.push('')
        props.onChange('listValues', values)
    }

    const updateListValue = (value, index) => {
        let values = [...props.data]
        values[index] = value
        props.onChange('listValues', values)
    }

    const checkEmptyValue = () => {
        for (let value of props.data) {
            if (value.trim() === '') return true 
        }
        return false
    }

    const checkDuplicateValues = () => {
        let foundDuplicates = false
        if (props.data.length > 1)
            for (let i = 0; i < props.data.length; i++) {
                let copyToSplice = [...props.data]
                copyToSplice.splice(i,1) 
                if (copyToSplice.findIndex(element => props.data[i] === element) !== -1) 
                    foundDuplicates = true
            }
        if (!foundDuplicates) props.save()
        setDuplicates(foundDuplicates)
    }

    return (
        <div className='modal-container'>
            <div className='attribute-list-values-container'>
                <h1 className='attribute-heading'>Attribute List Values</h1>
                <div className='button-container'>
                    <IconButton styleName='save-button' caption={'Done'}
                        disabled={!props.dirty || checkEmptyValue()} src={icons.checkIcon}
                        onClick={checkDuplicateValues}></IconButton>
                    <IconButton styleName={(props.dirty ? 'cancel-button' : 'edit-button')}
                        caption={(props.dirty ? 'Cancel' : 'Close')} src={icons.closeIcon}
                        onClick={props.close}></IconButton> 
                </div>
                <IconButton styleName='add-button small' src={icons.addIcon} caption='Add A List Value'
                    onClick={addListValue}></IconButton>
                <div className='list-values-container'>
                    {props.data.map((row, index) => {
                        return (
                            <div className='box-and-icon' key={index}>
                                <input type='text' className='list-value-input' value={row}
                                    onChange={(event)=>updateListValue(event.target.value, index)}></input>
                            </div>
                        )
                    })}
                </div>
            </div>
            <div className='hazy-div'></div>
            {duplicates &&
                <Modal onClick={()=>setDuplicates(false)} buttonText='OK'>
                    Duplicate list items are not allowed.</Modal>}
        </div>
    )
}

export default AttributeListValues