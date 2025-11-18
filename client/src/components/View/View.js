import React, {useState, useEffect, useRef, useContext} from 'react'
import DisplayView from './DisplayView'
import EntityCDO, { ENTITY_POST, ENTITY_GROUP, ENTITY_USER } from '../../cdos/EntityCDO'
import MediaCDO from '../../cdos/MediaCDO'
import { AppContext } from '../../AppContext'
var cdo = new EntityCDO()
var cdoMedia = new MediaCDO()
const idEntity = window.location.pathname.substring(6, window.location.pathname.length)  //6 because '/view/' is the first 0-5
    
const View = () => {

    const {appContext} = useContext(AppContext)
    const [data, setData] = useState(cdo.getEmptyRow())
    const [dataLoaded, setDataLoaded] = useState(false)
    const [mediaDataLoaded, setMediaDataLoaded] = useState(false)
    const [contentDataLoaded, setContentDataLoaded] = useState(false)
    const [ownedDataLoaded, setOwnedDataLoaded] = useState(false)
    const [ownershipDataLoaded, setOwnershipDataLoaded] = useState(false)
    const [isOwner, setIsOwner] = useState(null)  //default to null so that we can detect once it's set
    const [ownerData, setOwnerData] = useState(null)
    const [currentImageIndex, setCurrentImageIndex] = useState(-1)
    const refData = useRef(cdo.getEmptyRow())
    
    //load core entity data
    useEffect(()=>{
        const cbLoadData = (error, dbData) => {
            if (!error)
                if (!dbData.error) {
                    let newData = {...refData.current}
                    for (let itemName in dbData) {
                        newData[itemName] = dbData[itemName]
                    }
                    setData(newData)
                    refData.current = newData
                }
                else alert(`Error ${dbData.error.errno} loading data.  ${dbData.error.code} - ${dbData.error.sqlMessage}`)
            }
        if (!dataLoaded && cdo) {
            setDataLoaded(true)
            cdo.view({idEntity}, cbLoadData)
        }
    }, [data, dataLoaded])

    //load media data
    useEffect(()=>{
        const cbLoadMediaData = (error, dbData) => {
            if (!error)
                if (!dbData.error) {
                    let newData = {...refData.current}
                    newData.media = dbData
                    setData(newData)
                    refData.current = newData
                    setCurrentImageIndex(0)
                }
                else alert(`Error ${dbData.error.errno} loading media data.  ${dbData.error.code} - ${dbData.error.sqlMessage}`)
        }
        if (!mediaDataLoaded && cdoMedia && data.idEntity) {
            setMediaDataLoaded(true)
            cdoMedia.loadData({idEntity}, cbLoadMediaData)
        }
    }, [data, mediaDataLoaded])

    //load linked content data
    useEffect(()=>{
        const cbLoadContentData = (error, dbData) => {
            if (!error)
                if (!dbData.error) {
                    let newData = {...refData.current}
                    newData.content = dbData
                    setData(newData)
                    refData.current = newData
                }
                else alert(`Error ${dbData.error.errno} loading linked content data.  ${dbData.error.code} - ${dbData.error.sqlMessage}`)
        }
        if (!contentDataLoaded && cdo && data.idEntity) {
            setContentDataLoaded(true)
            cdo.loadEntityContent({idEntity: idEntity, relateType: 2}, cbLoadContentData)
        }
    }, [data, contentDataLoaded])

    //load owned data
    useEffect(()=>{
        const cbLoadOwnedData = (error, dbData) => {
            if (!error)
                if (!dbData.error) {
                    if (dbData[0]) {
                        let newData = {...refData.current}
                        newData.owned[dbData[0].entityType] = dbData
                        setData(newData)
                        refData.current = newData
                    }
                }
                else alert(`Error ${dbData.error.errno} loading owned data.  ${dbData.error.code} - ${dbData.error.sqlMessage}`)
        }
        if (!ownedDataLoaded && cdo && data.idEntity && data.entityType === ENTITY_USER) {
            setOwnedDataLoaded(true)
            for (let et = ENTITY_POST; et <= ENTITY_GROUP; et++) {
                cdo.loadData({idUser: idEntity, entityType: et}, cbLoadOwnedData)
            }
        }
    }, [data, ownedDataLoaded])

    //verify ownership - load entity-relates for the entity being viewed and the user to see all relationships
    useEffect(()=>{
        const cbLoadOwnership = (error, dbData) => {
            let newIsOwner = false
            let newOwner = null
            if (!error) {
                if (!dbData.error) {
                    if (dbData[0]) {
                        for (let owner of dbData) {
                            newIsOwner = (appContext.idEntity===owner.idEntity)
                            newOwner = owner
                        }
                    }
                }
                else alert(`Error ${dbData.error.errno} loading ownership data.  ${dbData.error.code} - ${dbData.error.sqlMessage}`)
                setIsOwner(newIsOwner)
                setOwnerData(newOwner)
            }
        }
        if (!ownershipDataLoaded && cdo && data.idEntity) {
            setOwnershipDataLoaded(true)
            cdo.loadEntityOwner({idEntity: data.idEntity}, cbLoadOwnership)
        }
    }, [data, ownershipDataLoaded, appContext.idEntity])

    return (
        <DisplayView data={data} 
            idEntity={idEntity} entityTitle={data.entityTitle}
            currentImageIndex={currentImageIndex} 
            setCurrentImageIndex={setCurrentImageIndex}
            isOwner={isOwner}
            ownerData={ownerData}>
        </DisplayView>
    )
}

export default View