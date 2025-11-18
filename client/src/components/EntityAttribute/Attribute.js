import React, { useEffect, useState } from 'react'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'
import TextBox from '../controls/TextBox/TextBox'
import Select from '../controls/Select/Select'
import AttributeListValues from './AttributeListValues'
import AttributeCDO, {ATTRIBUTE_TYPE_NUMBER, ATTRIBUTE_TYPE_TEXT, ATTRIBUTE_TYPE_CUSTOM_DROPDOWN}
    from '../../cdos/AttributeCDO'
import jsonFunctions from '../../shared/jsonFunctions'
import CheckBox from '../controls/CheckBox/CheckBox'
// uses styling from Modal.css

const cdo = new AttributeCDO()

const ATTRIBUTE_TYPES = [{caption: '', value: -1 },
                         {caption: 'Number', value: ATTRIBUTE_TYPE_NUMBER },
                         {caption: 'Text', value: ATTRIBUTE_TYPE_TEXT },
                         {caption: 'List', value: ATTRIBUTE_TYPE_CUSTOM_DROPDOWN }]

const Attribute = (props) => {

    // const [data,setData] = useState({idAttribute: null,
    //                                  attrName: '', 
    //                                  attrType: -1,
    //                                  idSuggestor: null,
    //                                  idSession: null,
    //                                  value: ''})
    const [editValues, setEditValues] = useState(false)
    const [validInputs, setValidInputs] = useState(false)
    const [originalListValues, setOriginalListValues] = useState(null)

    useEffect(() => {
        if (originalListValues === null) setOriginalListValues([...props.data.listValues])
    }, [originalListValues, props.data.listValues])
    
    
    const onChange = (dataCol, value) => {
        props.onChange(dataCol, value)
        let newData = {...props.data}
        newData[dataCol] = value
        if (newData.attrName.length > 0 && newData.attrType >= 0) {
            if (!validInputs) setValidInputs(true)
        }
        else if (validInputs) setValidInputs(false)
    }

    const saveData = () => {
        if (props.data.idAttribute) 
            cdo.saveData(props.data, cbSaveData)  // updates an existing Attribute in the DB
        else
            cdo.addData(props.data, cbSaveData)  // insert a new attribute
    }

    const cbSaveData = (err, result) => {
        if (!err && !result.error) {
            if (props.new) props.onChange('idAttribute', result.idAttribute)
            // if (attr.type === ATTRIBUTE_TYPE_CUSTOM_DROPDOWN) {
                
            // }
            props.saveAttribute()
        }
        else alert (`Error ${result.error.errno} loading data.  ${result.error.code} - ${result.error.sqlMessage}`)
    }

    const checkListValuesDirty = () => {
        return !jsonFunctions.jsonEqual(props.data.listValues, originalListValues)
    }
    
    const closeAttributeListValues = () => {
        setEditValues(false)
        props.onChange('listValues', [...originalListValues])
    }

    const saveAttributeListValues = () => {
        setEditValues(false)
        setOriginalListValues([...props.data.listValues])
    }

    return (
        <div className='modal-container'>
        {console.log(props.data)}
            <div className='edit-attribute'>
                <h1 className='attribute-heading'>{props.new ? 'Add' : 'Edit'} Attribute</h1>
                <div className='button-container'>
                    <IconButton styleName='save-button' caption={'Save'} disabled={!validInputs}
                        src={icons.saveIcon} onClick={saveData}></IconButton>
                    <IconButton styleName={(props.dirty ? 'cancel-button' : 'edit-button')}
                        caption={(props.dirty ? 'Cancel' : 'Close')} src={icons.closeIcon}
                        onClick={props.close}></IconButton>
                </div>
                <TextBox id='attrName' dataCol='attrName' placeholder='Attribute Name'
                    value={props.data.attrName} onChange={onChange}></TextBox>
                <Select id='attrType' data={ATTRIBUTE_TYPES} dataCol='attrType' onChange={onChange}
                    value={props.data.attrType}
                    label={props.new ? 'Select Type...' : 'Attribute Type'}></Select>
                <CheckBox id='required' dataCol='required' onChange={onChange} checked={props.data.required}>
                    Required attribute</CheckBox>
                {props.data.attrType === ATTRIBUTE_TYPE_CUSTOM_DROPDOWN &&
                    <IconButton styleName='edit-button small margin-top-button' 
                        caption='Edit List Values' src={icons.editIcon} 
                        onClick={()=>setEditValues(true)}></IconButton>}
                {props.data.attrType === ATTRIBUTE_TYPE_CUSTOM_DROPDOWN && editValues && 
                    <AttributeListValues close={closeAttributeListValues} data={props.data.listValues}
                        onChange={props.onChange} dirty={checkListValuesDirty()} 
                        save={saveAttributeListValues}></AttributeListValues>}
            </div>
            <div className='hazy-div'></div>
        </div>
    )
}

export default Attribute