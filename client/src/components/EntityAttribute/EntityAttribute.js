import React, {Fragment, useState, useContext} from 'react'
import { AppContext } from '../../AppContext'
import Attribute from './Attribute'
import icons from '../../shared/icons'
import IconButton from '../controls/buttons/IconButton'
import './EntityAttribute.css'
import TextBox from '../controls/TextBox/TextBox'
import jsonFunctions from '../../shared/jsonFunctions'
import { ATTRIBUTE_TYPE_CUSTOM_DROPDOWN, ATTRIBUTE_TYPE_NUMBER, ATTRIBUTE_TYPE_TEXT } from '../../cdos/AttributeCDO'
import Select from '../controls/Select/Select'

const EntityAttribute = (props) => {

  const [newAttribute, setNewAttribute] = useState(false)
  const [addOrEditAttribute,setAddOrEditAttribute] = useState(false)
  const [attributes, setAttributes] = useState([])
  const [editIndex, setEditIndex] = useState(0)
  const [originalAttributes, setOriginalAttributes] = useState([])
  const {appContext} = useContext(AppContext)

  const addAttribute = () => {
    let attrArray = [...attributes]
    setOriginalAttributes(jsonFunctions.deepCopy(attrArray))
    attrArray.push({idAttribute: null,
      attrName: '', 
      attrType: -1,
      idSuggestor: appContext.idEntity,
      idSession: appContext.idSession,
      value: '',
      required: false,
      listValues: []})
    setAttributes(attrArray)
    setEditIndex(attrArray.length - 1)
    setAddOrEditAttribute(true)
    setNewAttribute(true)
  }

  const editAttribute = (index) => {
    setOriginalAttributes(jsonFunctions.deepCopy(attributes))
    setAddOrEditAttribute(true)
    setNewAttribute(false)
    setEditIndex(index)
  }

  // const saveAttribute = (attrData) => {
  //   let attrArray = [...attributes]
  //   attrArray.push(attrData)
  //   setAttributes(attrArray)
  // }

  const updateAttribute = (dataCol, value) => {
    let attrArray = [...attributes]
    attrArray[editIndex][dataCol] = value
    setAttributes(attrArray)
  }

  const updateData = (dataCol, value) => {
    let attrArray = [...attributes]
    let index = attrArray.findIndex((element) => element.attrName === dataCol)
    attrArray[index].value = value
    setAttributes(attrArray)
  }

  const closeAttribute = () => {
    setAddOrEditAttribute(false)
    setAttributes(originalAttributes)
  }

  const generateSelectData = (listValues) => {
    let optionsArray = [{caption: 'Please select...', value: -1}]
    for (let value of listValues)
      optionsArray.push({caption: value, value: value})
    return optionsArray
  }

  const displayAttributes = () => {
    return (
      <Fragment>
        {attributes.map((attr, index) => {
            return (
                <div className='attribute-box-and-icon' key={attr.attrName}>
                    {(attr.attrType === ATTRIBUTE_TYPE_NUMBER || attr.attrType === ATTRIBUTE_TYPE_TEXT) &&
                      <TextBox id={attr.attrName} dataCol={attr.attrName} value={attr.value}
                          onChange={updateData} placeholder={attr.attrName} containerStyle='attribute'>
                      </TextBox>}
                    {attr.attrType === ATTRIBUTE_TYPE_CUSTOM_DROPDOWN &&
                      <Select id={attr.attrName} dataCol={attr.attrName} value={attr.value}
                      onChange={updateData} label={attr.attrName}
                      data={generateSelectData(attr.listValues)}></Select>}
                    <IconButton styleName='no-caption edit-icon' src={icons.editBlueIcon}
                        onClick={()=>editAttribute(index)} tooltip='Edit'></IconButton>
                </div>
            )
        })}
      </Fragment>
    )
  }

    return (
        <div className='attribute-container'>
            <h2 className='sub-section-heading'>Required Attributes:</h2>
            <h2 className='sub-section-heading'>Suggested Attributes:</h2>
            {displayAttributes()}
            <IconButton styleName='add-button small margin-top-button' 
                caption='Add Attribute' src={icons.addIcon} 
                onClick={addAttribute}></IconButton>
            {addOrEditAttribute && 
                <Attribute new={newAttribute} data={attributes[editIndex]} onChange={updateAttribute}
                    close={closeAttribute} saveAttribute={()=>setAddOrEditAttribute(false)}
                    originalData={originalAttributes[editIndex]}></Attribute>}
        </div>
    )
}

export default EntityAttribute