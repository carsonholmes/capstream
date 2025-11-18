import React, {useState, useEffect, useContext} from 'react'
import {AppContext} from '../../AppContext'
import MediaCDO from '../../cdos/MediaCDO'
import EditEntityImage from '../EditEntityImage/EditEntityImage'
import jsonFunctions from '../../shared/jsonFunctions'
const cdo = new MediaCDO()

const MaintainEntityImages= (props) => {
    
    const {appContext, setAppContext} = useContext(AppContext)
    const [data, setData] = useState([])
    const [dataLoaded, setDataLoaded] = useState(false)
    const [originalData, setOriginalData] = useState([])
    const [dirty, setDirty] = useState(false)
        
    useEffect(()=>{
        if (!dataLoaded && cdo) {
            setDataLoaded(true)
            if (props.idEntity)
                cdo.loadData({idEntity: props.idEntity, idUser: appContext.idEntity,
                    idSession: appContext.idSession}, cbLoadData)
            else setData(cdo.getEmptyRow)
        }
    }, [dataLoaded, props.idEntity, appContext.idEntity, appContext.idSession])

    useEffect(()=>{
        setDirty(!jsonFunctions.jsonEqual(data, originalData))
    }, [data,originalData])

    const cbLoadData = (error, dbData) => {
        let newData = [...dbData]
        newData.forEach(element => {
            element.dirty = false
            element.new = false
        });
        setData(newData)
        setOriginalData(jsonFunctions.deepCopy(newData))
    }

    const saveMedia = () => {
        var updateData = {  idEntity: props.idEntity,
                            idUser: appContext.idEntity,
                            idSession: appContext.idSession,
                            media: data }
        cdo.saveDataAll(updateData, cbSave)    
    }

    const cbSave = (err, dbData ) => {
        if (!err) {
            if (dbData.error)
                alert('Error ' + dbData.error.errno + ' saving data: ' + dbData.error.code + ' - ' + dbData.error.sqlMessage)
            else {
                // no need to set new and dirty flags to false, component is going away
                // var newData = [...data]
                // for (var i=0;i<data.length;i++) {
                //     newData[i].new = false;
                //     newData[i].dirty = false;
                // }
                // setData(newData)
                if (props.circular) {
                    refreshAvatar()
                }
                props.closeEdit()
            }
        }
        else alert('Error communicating with server')
    }

    const refreshAvatar = () => {
        //toggle avatarRefresh to get ProfileMenu to refresh Avatar icon
        var newContext = {...appContext}
        newContext.avatarRefresh = true
        setAppContext(newContext)
        var newContext2 = {...appContext}
        newContext2.avatarRefresh = false
        setAppContext(newContext2)
    }

    const deleteMedia = (index) => {
        var isRefreshNeeded = false
        if (index === data.length-1) isRefreshNeeded = true
        cdo.deleteData(data[index], cbDeleteMedia)
        var newData = [...data]
        newData.splice(index,1)
        setData(newData)
        var newOriginalData = [...originalData]
        newOriginalData.splice(index,1)
        setOriginalData(newOriginalData)
        if (isRefreshNeeded) refreshAvatar()
    }

    const cbDeleteMedia = (err, result) => {
        if (err) alert('Error deleting media file and/or media database record.')
    }

    const cancelMedia = () => {
        var newData = [...data]
        for (var i=0; i<data.length; i++) {
            if (data[i].new) {
                var mediaData = {...data[i]}
                cdo.deleteData(mediaData, cbDeleteMedia)
                newData.splice(i,1)
            }
        }
        setData(newData)  //avoid a double call that may attempt to delete more than once by updating with deletions spliced out
        props.closeEdit()
    }

    return (
            <EditEntityImage data={data}
                idEntity={props.idEntity}
                entityType={props.entityType}
                circular={props.circular}
                profile={true}
                dirty={dirty}
                updateMedia={setData}
                saveMedia={saveMedia}
                cancelMedia={cancelMedia}
                deleteMedia={deleteMedia}>
            </EditEntityImage>
    )
}

export default MaintainEntityImages