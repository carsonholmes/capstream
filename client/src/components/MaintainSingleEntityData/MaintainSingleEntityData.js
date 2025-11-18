import React, {useState, useEffect, useContext, useRef, useCallback} from 'react'
import { AppContext } from '../../AppContext'
import { loadFromSessionStorage, storeToSessionStorage } from '../../shared/storage'
import MaintainSingleEntity from '../MaintainSingleEntity/MaintainSingleEntity'
import EntityPreview from '../EntityPreview/EntityPreview'
import EntityCDO, { ENTITY_SERVICE } from '../../cdos/EntityCDO'
import CategoryCDO from '../../cdos/CategoryCDO'
import { ENTITY_TYPE } from '../../cdos/EntityCDO'
import jsonFunctions from '../../shared/jsonFunctions'
import CreateService from '../MaintainSingleEntity/CreateService'
const cdo = new EntityCDO()
const cdoCategory = new CategoryCDO()

const MaintainSingleEntityData = (props) => {

    const {appContext} = useContext(AppContext)
    const [mode, setMode] = useState('create')
    const [data, setData] = useState(cdo.getEmptyRow())
    const [originalData, setOriginalData] = useState(null)
    const [dirty, setDirty] = useState(false)
    const [isDisabled, setIsDisabled] = useState(false)
    const [currentImageIndex, setCurrentImageIndex] = useState(-1)
    const [categoryList, setCategoryList] = useState([])
    const refData = useRef()  //data stored here by reference for multiple callback loads
    const dataLoaded = useRef()

    useEffect(()=>{
        setDirty(!jsonFunctions.jsonEqual(data, originalData))
    }, [data, originalData])
    
    const cbLoadEntityAuxData = useCallback((error, result) => {
        if (!error && !result.error) {
            let newData = jsonFunctions.merge( refData.current, result)
            setData(newData)
            setOriginalData(jsonFunctions.deepCopy(newData))
            refData.current = newData
        }
    },[setData, setOriginalData])
    
    const cbLoadEntityMedia = useCallback((error, result) => {
        if (!error && !result.error) {
            let newData = {...refData.current}
            newData.media = result
            setData(newData)
            setOriginalData(jsonFunctions.deepCopy(newData))
            setCurrentImageIndex(0)
            refData.current = newData
        }
    },[setData, setOriginalData])
    
    const cbLoadEntityContent = useCallback((error, result) => {
        if (!error && !result.error) {
            let newData = {...refData.current}
            newData.content = result
            setData(newData)
            setOriginalData(jsonFunctions.deepCopy(newData))
            refData.current = newData
        }
    }, [setData, setOriginalData])

    const cbLoadEntityCategories = useCallback((error, result) => {
        if (!error && !result.error) {
            let newData = {...refData.current}
            newData.category = result
            setData(newData)
            setOriginalData(jsonFunctions.deepCopy(newData))
            refData.current = newData
        }
    }, [setData, setOriginalData])
    
    const cbLoadEntityOffer = useCallback((error, result) => {
        if (!error && result && !result.error) {
            let newData = {...refData.current}
            let area = newData.offer.area
            newData.offer = result
            newData.offer.area = area
            newData.offer.cancelPolicyOn = (result.cancelPolicyOn.data[0] === 1)
            newData.offer.handlePayment = (result.handlePayment.data[0] === 1)
            //newData.offer.offered = true
            if (newData.entityType === ENTITY_SERVICE) {
                newData.rate.idOffer = result.idOffer
                newData.rate.price = result.price
                newData.rate.rateType = result.rateType
                newData.rate.negotiable = result.negotiable
                newData.rate.handlePayment = newData.offer.handlePayment
                newData.rate.new = false
                if (result.price === 0 && !result.negotiable) {
                    newData.rate.rateSetType = 2
                }
            }
            setData(newData)
            setOriginalData(jsonFunctions.deepCopy(newData))
            refData.current = newData
        }
    }, [setData, setOriginalData])

    const cbLoadEntityArea = useCallback((error, result) => {
        if (!error && result && !result.error) {
            let newData = {...refData.current}
            newData.offer.area = result
            setData(newData)
            setOriginalData(jsonFunctions.deepCopy(newData))
            refData.current = newData
        }
    }, [setData, setOriginalData])

    const cbLoadCategories = (error, result) => {
        if (!error && result && !result.error) setCategoryList(result)
        else alert('Can not load categories from the database')
    }

    useEffect(()=>{
        
        if (props.create)  // if we are creating a new entity use the local storage to cache/load the work, otherwise the DB has it
            if (!dataLoaded.current) {
                var cachedPostData = {} //loadFromSessionStorage('cached' + ENTITY_TYPE[props.entityType])
                if (cachedPostData.entityTitle) {
                    cachedPostData.idUser = appContext.idEntity
                    cachedPostData.idSession = appContext.idSession
                    setData(cachedPostData)
                    setOriginalData(jsonFunctions.deepCopy(cachedPostData))
                }
                else {
                    let newData = {...data}
                    newData.idUser = appContext.idEntity
                    newData.idSession = appContext.idSession
                    newData.entityType = props.entityType
                    storeToSessionStorage('cached' + ENTITY_TYPE[props.entityType], newData)
                    setData(newData)
                    setOriginalData(jsonFunctions.deepCopy(newData))
                }
                dataLoaded.current = true
            }
            else {
                let newData = {...data}
                newData.idUser = appContext.idEntity
                newData.idSession = appContext.idSession
                newData.entityType = props.entityType
                storeToSessionStorage('cached' + ENTITY_TYPE[props.entityType], newData)
            }
        else
        {
            //alert('Data loaded: ' + dataLoaded.current)
        }
        if (!dataLoaded.current) {
            dataLoaded.current = true
            let newData = cdo.getEmptyRow() //
            newData.idUser = appContext.idEntity
            newData.idSession = appContext.idSession
            let combinedData = jsonFunctions.merge(newData, props.data)
            combinedData.rate.new = false
            setData(combinedData)
            setOriginalData(jsonFunctions.deepCopy(combinedData))
            refData.current = newData //load reference data for multiple data loads
            //cdo.loadEntityAttributes()
            //cdo.loadEntityCategories()
            cdo.view(newData, cbLoadEntityAuxData)
            cdo.loadEntityMedia(newData, cbLoadEntityMedia)
            cdo.loadEntityContent(newData, cbLoadEntityContent)
            cdo.loadEntityOffer(newData, cbLoadEntityOffer)
            cdo.loadEntityArea(newData, cbLoadEntityArea)
            cdo.loadEntityCategories(newData, cbLoadEntityCategories)
            cdoCategory.loadData({entityType: ENTITY_SERVICE}, cbLoadCategories)
        }
        //}     
        setIsDisabled(data.entityTitle.length===0)  //need to improve this
        return () => {
            
        }
    }, [data, dataLoaded, appContext.idEntity, appContext.idSession, props.entityType, props.data,
            props.create, cbLoadEntityMedia, cbLoadEntityContent, cbLoadEntityAuxData, cbLoadEntityOffer,
            cbLoadEntityCategories])

    const updateData = (dataCol, newValue) =>{
        setData(prevData=>{
            let newData = {...prevData}
            newData[dataCol] = newValue
            return newData
        })
    }

    const saveData = () => {
        let newData = {...data}
        if (newData.entityType === ENTITY_SERVICE) {  // if service, grab data from rate to fill offer fields
            newData.offer.price = newData.rate.price
            newData.offer.rateType = newData.rate.rateType
            newData.offer.negotiable = newData.rate.negotiable
            if (!newData.rate.negotiable && newData.rate.price === 0) newData.offer.rateType = 0 // save with flat fee if no price was provided on set rate
            newData.offer.handlePayment = newData.rate.handlePayment
        }
        if (data.idEntity) {  // not new
            newData.offer.dirty = jsonFunctions.jsonEqual(data.offer, originalData.offer)
            cdo.saveData( newData, cbUpdateData)
        }
        else
            cdo.addData( newData, cbSaveData)
    }

    const cbSaveData = (err, result) => {
        if (!err && !result.error) {
            let newData = {...data}
            newData.idEntity = result.idEntity
            newData.offer.idOffer = result.offer.idOffer
            props.updateData(newData)  // update EntityMaintenance data row
            updateData('idEntity',result.idEntity) // update local detailed entity data
            let newOffer = {...data.offer}
            newOffer.idOffer = result.offer.idOffer
            updateData('offer', newOffer)
            setOriginalData(jsonFunctions.deepCopy(data))
        }
        else alert (`Error ${result.error.errno} saving entity.  ${result.error.code} - ${result.error.sqlMessage}`)
    }

    const cbUpdateData = (err, result) => {
        if (!err && !result.error) {
            let newData = {...data}
            let revisedCategory = []
            for (let c of data.category) {
                if (!c.markedForDeletion) revisedCategory.push(c)
            }
            newData.category = revisedCategory
            props.updateData(newData)
            setData(newData)
            //remove dategories marked for deletion from array
            setOriginalData(jsonFunctions.deepCopy(newData))
        }
        else alert (`Error ${result.error.errno} saving entity.  ${result.error.code} - ${result.error.sqlMessage}`)
    }

    const cancelEdit = () => {
        // let newData = cdo.getEmptyRow()
        // newData.idUser = appContext.idEntity
        // newData.idSession = appContext.idSession
        // newData.entityType = props.entityType
        // storeToSessionStorage('cached' + ENTITY_TYPE[props.entityType], newData)
        setData(jsonFunctions.deepCopy(originalData))
        props.updateData(jsonFunctions.deepCopy(originalData))
        props.cancelEdit()
    }

    switch (mode) {
        case 'create':  if (props.create)
                            return <CreateService setMode={setMode} data={data} setData={setData} 
                                originalData = {originalData} entityType={props.entityType}
                                updateData={updateData} isDisabled={isDisabled} saveData={saveData} 
                                 create={props.create} cancelEdit={cancelEdit} dirty={dirty}
                                cardHeading={props.cardHeading} setCreate={props.setCreate}>
                            </CreateService>
                        else
                            return <MaintainSingleEntity setMode={setMode} data={data} setData={setData} 
                                        originalData = {originalData} entityType={props.entityType}
                                        updateData={updateData} isDisabled={isDisabled} saveData={saveData} 
                                        create={props.create} cancelEdit={cancelEdit} dirty={dirty}
                                        cardHeading={props.cardHeading} currentImageIndex={currentImageIndex}
                                        setCurrentImageIndex={setCurrentImageIndex}
                                        categoryList={categoryList} setCategoryList={setCategoryList}>
                                    </MaintainSingleEntity>
        default: return <EntityPreview entityType={props.entityType} setMode={setMode} mode={mode} 
                            data={data} saveData={saveData} idEntity={data.idEntity} create={props.create}></EntityPreview>
    }
}

export default MaintainSingleEntityData