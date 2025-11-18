import React, {useState, useEffect} from 'react'
import { AppContext } from '../../AppContext'
import AuthFrame from '../AuthFrame/AuthFrame'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
import EntityList from '../EntityList/EntityList'
import MaintainSingleEntityData from '../MaintainSingleEntityData/MaintainSingleEntityData'
import Modal from '../controls/Modal/Modal'
import EntityCDO, { ENTITY_TYPE, ENTITY_TYPE_LOWERCASE_PLURAL } from '../../cdos/EntityCDO'
import jsonFunctions from '../../shared/jsonFunctions'
import './EntityMaintenance.css'

const cdo = new EntityCDO()

const EntityMaintenance = () => {

    //PROCESS URL
    const entityMaintenanceURL = window.location.pathname.substring(10, window.location.pathname.length)  //10 because '/maintain/' is the first 0-9
    var entityTypeURL 
    const slashBeforeParameter = entityMaintenanceURL.search('/')
    var editEntity = null
    if (slashBeforeParameter > 0) {
        entityTypeURL = entityMaintenanceURL.substring(0,slashBeforeParameter)
        editEntity = entityMaintenanceURL.substring(slashBeforeParameter+1, entityMaintenanceURL.length)
    }
    else {
        entityTypeURL = entityMaintenanceURL
        editEntity = 0
    }
    const entityTypeIndex = ENTITY_TYPE_LOWERCASE_PLURAL.findIndex(element=>element===entityTypeURL) 
    if (!entityTypeIndex) window.location.href = 'home' // if not a valid entity, redirect to home

    const {appContext} = React.useContext(AppContext)
    const [entityType] = useState(entityTypeIndex)
    const [isAdding, setIsAdding] = useState(false)
    const [isEditing, setIsEditing] = useState(false)
    const [data, setData] = useState([])
    const [dataLoaded, setDataLoaded] = useState(false)
    const [selectedData, setSelectedData] = useState([])
    const [deleteConfirm, setDeleteConfirm] = useState(false)

    useEffect(()=>{
        const cbLoadData = (error, dbData) => {
            if (!error)
                if (!dbData.error) {
                    if (editEntity) {
                        let newData = []
                        newData.push(dbData)
                        setData(newData)
                        console.table(newData)
                        setSelectedData([0])
                        setIsEditing(true)
                    }
                    else {
                        for (let i=0; i<dbData.length;i++) {
                            dbData.selected = false
                        }
                        setData(dbData)
                    }
                }
                else alert(`Error ${dbData.error.errno} loading data.  ${dbData.error.code} - ${dbData.error.sqlMessage}`)
        }

        if (!dataLoaded && cdo && editEntity !== null) {
            setDataLoaded(true)
            if (editEntity) cdo.view({idEntity: editEntity}, cbLoadData)
            else if (appContext.idEntity) 
                cdo.loadData({idUser: appContext.idEntity, idSession: appContext.idSession, entityType: entityType}, cbLoadData)
        }
    }, [dataLoaded, appContext.idEntity, appContext.idSession, entityType, editEntity])
  
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
    }

    const addRow = () => {
        let newData = [...data]
        newData.unshift(cdo.getEmptyRow())
        newData[newData.length-1].new = true
        newData[newData.length-1].idUser = appContext.idEntity
        newData.entityType = entityType
        setData(newData)
        setSelectedData([0])
        setIsAdding(true)
        setIsEditing(true)
    }

    const toggleEditData = () => {
        // if (!data[selectedData[0]].idEntity) {
        //     let newData = [...data]
        //     newData.splice(selectedData[0],1)
        //     setData(newData)
        // }
        if (editEntity !== 0) document.location.href = '/maintain/' + ENTITY_TYPE_LOWERCASE_PLURAL[entityType]
        else {
            setIsEditing(!isEditing)  //toggle state variable
            if (isAdding) setIsAdding(false)
        }
    }

    const cancelEdit = () => {
        if (editEntity !== 0) document.location.href = '/view/' + editEntity
        if (!data[selectedData[0]].idEntity) {
            let newData = [...data]
            newData.splice(selectedData[0],1)
            setData(newData)
            setSelectedData([])
        }
        setIsEditing(!isEditing)
    }

    const updateData = (row) => {
        let newData = [...data]
        newData[selectedData[0]]={...row}
        setData(newData)
    }

    const deleteData = () => {
        let deleteEntities = []
        let newData = jsonFunctions.deepCopy(data)
        for (let i=0; i<selectedData.length; i++) {
            deleteEntities.push(newData[selectedData[i]])
            newData.splice(selectedData[i],1)
        }
        cdo.deleteData(deleteEntities, cbDeleteData)
        setData(newData)
        setSelectedData([])
        setDeleteConfirm(false)
    }

    const cbDeleteData = (error, result) => {
        if (error) alert('General error deleting entity')
        else if (result.error) {
            console.table(result.error)
            alert('Error deleting entity')
        }
    }

    const deleteConfirmMessage = () => {
        let msg =  'Are you sure you want to delete '
        if (selectedData.length===1) msg += ' this ' + ENTITY_TYPE[entityType]
        else msg += ' these ' + ENTITY_TYPE[entityType] + 's'
        return msg
    }

    return (
        <AuthFrame mandatory={true}>
            <ContentContainer>
                {!isEditing &&
                    <Card cardHeading={'Maintain ' + ENTITY_TYPE[entityType] + 's'}>
                        <div className='maintenance-container'>
                            <div className='button-container'>
                                <IconButton styleName='add-button' 
                                    caption='Add' src={icons.addIcon} onClick={addRow}></IconButton>
                                <IconButton styleName='edit-button' disabled={selectedData.length!==1}
                                    caption='Edit' onClick={toggleEditData} src={icons.editIcon}></IconButton>
                                <IconButton styleName='delete-button' disabled={!(selectedData.length>0)} src={icons.deleteIcon}
                                    caption='Delete' onClick={()=>setDeleteConfirm(true)}></IconButton>
                            </div>
                            {data.length>0 ?
                                <EntityList data={data} selectable={true}
                                    updateSelection={updateSelection}
                                    selectedData={selectedData}>
                                </EntityList> 
                            :
                                <div>
                                    <br/>
                                    <p>Use the Add button to create your first {ENTITY_TYPE[entityType]}.</p>
                                </div>}
                        </div>
                    </Card>
                }
                {isEditing && 
                    <MaintainSingleEntityData entityType={entityType} create={isAdding}
                        data={data[selectedData[0]]} setCreate={setIsAdding}
                        updateData={updateData} toggleEditData={toggleEditData} cancelEdit={cancelEdit}
                        cardHeading={`${isAdding ? 'Create' : 'Edit'} ${ENTITY_TYPE[entityType]}`}>
                    </MaintainSingleEntityData>
                }
                {deleteConfirm && 
                    <Modal buttonText='Yes' onClick={deleteData}
                        buttonTwoText='No' onClickTwo={()=>setDeleteConfirm(false)}>{deleteConfirmMessage()}</Modal>
                }
            </ContentContainer>
        </AuthFrame>
    )
}

export default EntityMaintenance
