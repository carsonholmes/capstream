import React, {useState, useEffect} from 'react'
import EntityList from '../EntityList/EntityList'
import Modal from '../controls/Modal/Modal'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
import EntityCDO from '../../cdos/EntityCDO'
var cdo = new EntityCDO()

const CANCEL_CONFIRM_MESSAGE = 'You have unsaved changes are you sure you want to cancel?'

const filterArray = [1,0,0,0,0,0,0]
const SelectLinkedContent = (props) => {

    const [entityFilter, setEntityFilter] = useState(filterArray)
    const [dataLinkedContent, setDataLinkedContent] = useState(null)
    const [dataLinkedContentLoaded, setDataLinkedContentLoaded] = useState(false)
    const [confirm, setConfirm] = useState(null)
    const [selectedData, setSelectedData] = useState([])
    
    useEffect(()=>{
        const cbLoadData = (error, dbData) => {
            if (!error)
                if (!dbData.error) {
                    let newData = []
                    let newSelectedData = []
                    for (var x = 0; x < dbData.length; x++) {
                        newData[x] = dbData[x]
                        var found = false
                        for (var y=0; y<props.data.length && !found; y++) {
                            if (props.data[y].idEntity === newData[x].idEntity) found = true
                        }
                        if (found) {
                            newSelectedData.push(x)
                            newData[x].selected = true
                        }
                        else newData[x].selected = false                    
                    }
                    setDataLinkedContent(newData)
                    setSelectedData(newSelectedData)
                }
                else alert(`Error ${dbData.error.errno} loading data.  ${dbData.error.code} - ${dbData.error.sqlMessage}`)
        }

        if (cdo && !dataLinkedContentLoaded) {
            setDataLinkedContentLoaded(true)
            cdo.search({searchValue: ''}, cbLoadData)
        }
    }, [entityFilter, dataLinkedContentLoaded, props.data])

    const getStyle = (index) => {
        var style = 'edit-button'
        if (entityFilter[index]) 
            if (index) style += ' selected-icon-button'
            else style += ' selected-all-icon-button'
        return style
    }

    const handleClick = (index) => {
        if (index === 0) {
            if (entityFilter[0]===0) {
                setEntityFilter(filterArray)
                setDataLinkedContentLoaded(false)
            }
        }
        else {
            var newArray = [...entityFilter]
            newArray[0] = 0  //deselect All button on different selection
            if (newArray[index]) newArray[index] = 0  //if the newly selected button is on turn it off
            else newArray[index] = 1  //otherwise turn it on
            if (newArray[1] + newArray[2] + newArray[3] + newArray[4] + newArray[5] + newArray[6] === 0) newArray[0] = 1  // if all are off, turn on All
            setEntityFilter(newArray)
            setDataLinkedContentLoaded(false)
        }
        
    }
    
    const cancelContent = () => {
        if (props.dirty) setConfirm(CANCEL_CONFIRM_MESSAGE)
        else props.cancelContent()
    }

    const updateSelection = (index) => {
        var newSelection = [...selectedData]
        let found = -1
        for (let i=0; i<newSelection.length; i++) {
            if (newSelection[i] === index) {
                found = i
            }
        }
        if (found >=0 ) newSelection.splice(found,1)
        else {
                newSelection.push(index)
        }
        setSelectedData(newSelection)
        var newContent = [...dataLinkedContent]
        newContent[index].selected = !newContent[index].selected
        setDataLinkedContent(newContent)
        props.updateContent(newContent[index])
    }

    return (
        <>
            <div className='button-container'>
                <IconButton styleName='save-button' caption={'Done'} 
                    disabled={!props.dirty}
                    src={icons.checkIcon} onClick={props.saveContent}></IconButton>
                <IconButton styleName={(props.dirty ? 'cancel-button' : 'edit-button')} caption={(props.dirty ? 'Cancel' : 'Close')}
                    src={icons.closeIcon}
                    onClick={cancelContent}></IconButton>
            </div>
            <div className='entity-sub-header'>Filter list with these options:</div>
            <div className='button-container'>
                <IconButton styleName={getStyle(0)} onClick={()=>handleClick(0)} src={icons.allIcon} caption='All'></IconButton>
                <IconButton styleName={getStyle(1)} onClick={()=>handleClick(1)} src={icons.itemsIcon} caption='Items'></IconButton>
                <IconButton styleName={getStyle(2)} onClick={()=>handleClick(2)} src={icons.servicesIcon} caption='Services'></IconButton>
                <IconButton styleName={getStyle(3)} onClick={()=>handleClick(3)} src={icons.eventsIcon} caption='Events'></IconButton>
                <IconButton styleName={getStyle(4)} onClick={()=>handleClick(4)} src={icons.contactsIcon} caption='Contacts'></IconButton>
                <IconButton styleName={getStyle(5)} onClick={()=>handleClick(5)} src={icons.groupsIcon} caption='Groups'></IconButton>
                <IconButton styleName={getStyle(6)} onClick={()=>handleClick(6)} src={icons.placesIcon} caption='Places'></IconButton>
            </div>
            <hr/>
            <EntityList data={dataLinkedContent} selectable={true} selectedData={selectedData}
                updateSelection={updateSelection}></EntityList>
            {confirm && <Modal buttonText='Yes' onClick={props.cancelContent()}
                buttonTwoText='No' onClickTwo={()=>setConfirm(null)}>{confirm}</Modal>}
        </>
    )
}

export default SelectLinkedContent
