import React, { useEffect, useRef } from 'react'
import './CheckBoxList.css'
// uses styling from CheckBox.css

const CheckBoxList = (props) => {

    const selectAll = useRef()

    useEffect(() => {
        if (props.selectAllChecked) {
            let newArray = [...props.data]
            for (let checkbox of newArray) checkbox.checked = true
        }
    }, [props.selectAllChecked, props.data])
    

    const areAllChecked = (array) => {
        let allChecked = true
        for (let checkbox of array) {
            if (!checkbox.checked) allChecked = false
        }
        if (allChecked) return true
        else return false
    }

    const updateList = (index) => {
        let newArray = [...props.data]
        newArray[index].checked = !newArray[index].checked
        props.onChange(props.dataCol, newArray)
        if (areAllChecked(newArray)) {
            selectAll.current.checked = true
            props.onChange(props.dataColAll, true)
        }
        else {
            selectAll.current.checked = false
            props.onChange(props.dataColAll, false)
        }
    }

    const toggleSelectAll = () => {
        if (!props.selectAllChecked && !areAllChecked(props.data)) {
            let newArray = [...props.data]
            for (let checkbox of newArray) checkbox.checked = true
            props.onChange(props.dataCol, newArray)
            props.onChange(props.dataColAll, true)

        }
        else {
            let newArray = [...props.data]
            for (let checkbox of newArray) checkbox.checked = false
            props.onChange(props.dataCol, newArray)
            props.onChange(props.dataColAll, false)
        }
    }

    return (
        <div className='check-box-list-container'>
            <h2 className='check-box-list-label'>{`\u00A0 ${props.label} \u00A0`}</h2>
            <div className={props.styleName ? `check-box-select-all ${props.styleName}` :
                'check-box-select-all'}>
                <input type='checkbox' id='selectAll' onChange={toggleSelectAll} checked={props.selectAllChecked}
                    className={props.styleName ? `check-box-list ${props.styleName}` : 'check-box-list'}
                    ref={selectAll}/>
                <label className={props.styleName ? `${props.styleName} checkbox select-all` :
                    'checkbox select-all'} htmlFor='selectAll'>Select/Deselect All</label>
            </div>
            <div className='check-boxes-container'>
                {props.data.map((row, index) => {
                    return (
                        <div key={index} className={props.styleName ? `box-and-label ${props.styleName}` :
                            'box-and-label'}>
                            <input type='checkbox' id={index} onChange={()=>updateList(index)}
                                disabled={props.disabled} checked={row.checked}
                                className={props.styleName ? `check-box-list ${props.styleName}` : 'check-box-list'}
                                defaultChecked={props.defaultChecked}/>
                            <label className={props.styleName ? `${props.styleName} checkbox check-box-list` :
                                'checkbox check-box-list'}
                                htmlFor={index}>{row.caption}</label>
                        </div>
                    )
                })}
            </div>
        </div>
    )
}

export default CheckBoxList