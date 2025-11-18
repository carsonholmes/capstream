import React, {useState, useEffect} from 'react'
import { AppContext } from '../../AppContext'
import IconButton from '../controls/buttons/IconButton'
import CardDetails from '../CardDetails/CardDetails'
import SelectCDO from '../../cdos/SelectCDO'
import icons from '../../shared/icons'
import jsonFunctions from '../../shared/jsonFunctions'
import Modal from '../controls/Modal/Modal'
import Card from '../../components/Card/Card'
import CardList from '../controls/CardList/CardList'
// uses styling from Card.css

const selectCDO = new SelectCDO()

const DataCard = (props) => {

    const {appContext} = React.useContext(AppContext)
    const [isEditing, setIsEditing] = useState(false)
    const [data, setData] = useState({})
    const [originalData, setOriginalData] = useState({})
    const [dataLoaded, setDataLoaded] = useState(false)
    const [currentRow, setCurrentRow] = useState(0)
    const [dirty, setDirty] = useState(false)
    const [valid, setValid] = useState(true)
    const [confirmCancel, setConfirmCancel] = useState(false)
    const [confirmDelete, setConfirmDelete] = useState(false)
    const [primaryDeleteWarning, setPrimaryDeleteWarning] = useState(false)
    var cdo = selectCDO.getCDO(props.cardHeading)
            
    useEffect(()=>{
        const cbLoadData = (error, dbData) => {
            if (!error)
                if (!dbData.error) {
                    setData(dbData)
                    setOriginalData(dbData)
                    setDirty(false)
                }
                else alert(`Error ${dbData.error.errno} loading data.  ${dbData.error.code} - ${dbData.error.sqlMessage}`)
            else {
                let newRow = cdo.getEmptyRow()
                newRow.idEntity = appContext.idEntity
                setData(newRow)
                setOriginalData(jsonFunctions.deepCopy(newRow))
                setDirty(false)
            }
        }

        if (!dataLoaded && cdo) {
            setDataLoaded(true)
            cdo.loadData({idEntity: appContext.idEntity, idSession: appContext.idSession}, cbLoadData)
        }
    }, [dataLoaded, cdo, appContext.idEntity, appContext.idSession])

    useEffect(()=>{
        
    }, [isEditing])
   
    const updateData = (dataCol, newValue) => {
        console.log(dataCol, newValue)
        let newData = jsonFunctions.deepCopy(data)
        if (props.multiple) newData[currentRow][dataCol] = newValue
        else newData[dataCol] = newValue
        if (props.cardHeading === 'Email' && dataCol === 'primary' && newValue) {  // if they change an email to primary, deactive the other primary
            for (let i = 0; i<newData.length; i++) {
                if (i !== currentRow) newData[i].primary = false
            }
            newData[currentRow].idEntity = appContext.idEntity  //needs idEntity to update User table with primary email
        }
        setData(newData)
        setDirty(!jsonFunctions.jsonEqual(newData, originalData))
        if (props.cardHeading === "Time Zone" || props.cardHeading === "Notifications") cdo.saveData(newData, cbSaveData)  // special case these two due to timing issue, can't call update then save, so all in one
    }

    const saveData = () => {
        setIsEditing(false)
        setConfirmCancel(false)
        cdo.saveData(data, cbSaveData)
    }

    const cbSaveData = (error, dbData) => {
        if (dbData.response === 'Success') {
            setOriginalData(jsonFunctions.deepCopy(data))
            setDirty(false)
        }
        else {
            //console.table(data)
            alert('Error ' + dbData.error.errno + ' saving data: ' + dbData.error.code + ' - ' + dbData.error.sqlMessage)
            setIsEditing(true)
        }
    }

    const addRow = () => {
        let newData = [...data]
        newData.push(cdo.getEmptyRow())
        newData[newData.length-1].new = true
        newData[newData.length-1].idEntity = appContext.idEntity
        setData(newData)
        setCurrentRow(newData.length-1)
        setIsEditing(true)
    }

    const deleteRow = () => {
        setConfirmDelete(false)
        cdo.deleteData(data[currentRow], cbDeleteRow)
    }

    const cbDeleteRow = (result, error) => {
        let newData = [...data]
        newData.splice(currentRow, 1)
        setData(newData)
        if (currentRow !== 0) setCurrentRow(currentRow-1)
    }

    const handleDeleteClick = () => {
        if (!data[currentRow].primary) setConfirmDelete(true)
        else setPrimaryDeleteWarning(true)
    }

    const editData = () => {
        if (props.cardHeading === 'Avatar') {
            if (!isEditing) props.setIsEditingAvatar(true)  //check NOT because state variable yet to be switched
            else props.setIsEditingAvatar(false)
        }
        setIsEditing(!isEditing)  //toggle state variable
    }

    const checkDirty = () => {
        if (dirty) setConfirmCancel(true)
        else cancelEdit()
    }

    const cancelEdit = () => {
        var newData = jsonFunctions.deepCopy(originalData)
        if (currentRow > newData.length-1) setCurrentRow(newData.length-1)
        setDirty(false)
        setData(newData)
        setIsEditing(false)
        setConfirmCancel(false)
    }

    return (
        <Card cardHeading={props.cardHeading}>
            {!isEditing && 
                <div className='button-container'>
                    {props.multiple &&
                        <IconButton styleName='add-button' caption='Add' src={icons.addIcon}
                            onClick={addRow}></IconButton>}
                    {props.cardHeading !== 'Notifications' && props.cardHeading !== 'Time Zone' &&
                        <IconButton styleName='edit-button' caption='Edit' onClick={editData}
                            src={icons.editIcon}></IconButton>}
                    {props.multiple &&
                        <IconButton styleName='delete-button' caption='Delete' src={icons.deleteIcon}
                            onClick={()=>handleDeleteClick()}></IconButton>}
                </div>
            }
            {isEditing && 
                <div className='button-container'>
                    <IconButton styleName='save-button' disabled={!dirty || !valid} src={icons.saveIcon}
                        caption='Save' onClick={saveData}></IconButton>
                    <IconButton styleName='cancel-button'  src={icons.closeIcon}
                        caption='Cancel' onClick={checkDirty}></IconButton>
                </div>
            }
            {props.multiple && 
                <CardList cardHeading={props.cardHeading} 
                    currentRow={currentRow} setCurrentRow={setCurrentRow}
                    isEditing={isEditing} data={data}
                    setValid={setValid}
                    onChange={updateData}></CardList>}
            {!props.multiple && 
                <CardDetails cardHeading={props.cardHeading} isEditing={isEditing} data={data}
                    setValid={setValid} save={saveData} onChange={updateData}></CardDetails>}
            {confirmCancel && <Modal buttonText='Save changes' onClick={saveData}
                buttonTwoText='Cancel changes' onClickTwo={cancelEdit}>You have unsaved changes.</Modal>}
            {confirmDelete && <Modal buttonText='Delete email' onClick={deleteRow}
                buttonTwoText='Cancel delete' onClickTwo={()=>setConfirmDelete(false)}>
                Delete email address {data[currentRow].emailAddress}?</Modal>}
            {primaryDeleteWarning && <Modal buttonText='Okay' onClick={()=>setPrimaryDeleteWarning(false)}>
                A primary email address may not be deleted.<br /><br />
                Please make another email address primary before deleting this one.</Modal>}
        </Card>
    )
}

export default DataCard
