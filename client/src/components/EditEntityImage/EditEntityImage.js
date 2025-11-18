import React, {useState, useRef, useEffect, useContext, Fragment} from 'react'
import { AppContext } from '../../AppContext'
import EditImage from '../EditImage/EditImage'
import ScaledImage from '../controls/ScaledImage/ScaledImage'
import Modal from '../controls/Modal/Modal'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
import mediaPath from '../../shared/mediaPath'
import './EditEntityImage.css'
import MediaCDO from '../../cdos/MediaCDO'
import { ENTITY_USER } from '../../cdos/EntityCDO'
const cdo = new MediaCDO()

const DELETE_CONFIRM_MESSAGE = 'Are you sure you want to delete this media item?'
const CANCEL_CONFIRM_MESSAGE = 'You have unsaved changes are you sure you want to cancel?'
const CLOSE_CONFIRM_MESSAGE = 'You have unsaved changes are you sure you want to close the tab?'

const EditEntityImage = (props) => {
    
    const {appContext} = useContext(AppContext)
    const [currentImageIndex, setCurrentImageIndex] = useState(0)
    const [initialIndex, setInitialIndex] = useState(false)
    const [confirm, setConfirm] = useState(null)
    const [closeListener, setCloseListener] = useState(false)
    const inputFile = useRef(null)
    const refContainer = useRef(null)
    const refButtonContainer = useRef()

    useEffect(()=>{
        if (!initialIndex && props.data.length>0) {
            setInitialIndex(true)
            setCurrentImageIndex(0)
            scrollPosition()
        }
    }, [initialIndex, props.data.length])

    useEffect(()=> { 
        const checkClose = (event) => {
            event.preventDefault()
            return event.returnValue = CLOSE_CONFIRM_MESSAGE
        }

        const handleUnload = () => {
            props.cancelMedia()
        }
    
        if (!closeListener) {
            setCloseListener(true)
            refContainer.current.addEventListener('beforeunload', checkClose)
            refContainer.current.addEventListener('unload', handleUnload)
        }        
    }, [closeListener, props])

    const selectFile = () => {
        inputFile.current.click()
    }

    const onChange = (event) => {
        if (inputFile.current.value) {
            const mediaData = new FormData()
            mediaData.append('file',event.target.files[0])
            mediaData.append('idEntity', props.idEntity)
            mediaData.append('idUser', appContext.idEntity)
            mediaData.append('idSession', appContext.idSession)
            cdo.uploadFile(mediaData, cbUpdateProgress, cbUploadMedia)
            inputFile.current.value = null
        }
    }

    //callback for progress to update status bar
    const cbUpdateProgress = () => {

    }

    //callback for upload complete
    const cbUploadMedia = (err, dbData) => {
        if (!err) {
            if (dbData.response === 'Success') {
                let newData = [...props.data]
                dbData.new = true
                dbData.dirty = true
                dbData.newUpload = true
                dbData.xOffset = null   //EditImage will use this to set X or Y for the first time
                dbData.yOffset = null   //EditImage will use this to set X or Y for the first time
                dbData.scale = 1
                if (props.entityType === ENTITY_USER) { // adding profile media, so add it to the beginning, otherwise add it to the end
                    dbData.sortOrder = 1
                    for (let i=0; i<newData.length; i++) {
                        newData[i].sortOrder = newData[i].sortOrder + 1
                        newData[i].dirty = true
                    }
                    newData.unshift(dbData)
                    setCurrentImageIndex(0)
                    console.table(newData)
                }
                else {
                    dbData.sortOrder = maxSortOrder() + 1
                    newData.push(dbData)
                    setCurrentImageIndex(newData.length-1)
                }
                props.updateMedia(newData)
            }
            else alert(dbData.response)
        }
        else alert(err)
    }

    const maxSortOrder = () => {
        let result = 0
        for (var i = 0; i < props.data.length; i++)
            if (props.data[i].sortOrder > result) result = props.data[i].sortOrder
        return result
    }

    const setPosition = (index, xOffset, yOffset, scale) => {
        let newData = [...props.data]
        newData[index].xOffset = xOffset
        newData[index].yOffset = yOffset
        newData[index].scale = scale
        newData[index].dirty = true
        props.updateMedia(newData)
    }

    const deleteMedia = () => {
        props.deleteMedia(currentImageIndex)
        setConfirm(null)
        if (currentImageIndex !== 0) setCurrentImageIndex(currentImageIndex-1)
    }

    const cancelMedia = () => {
        if (props.dirty) setConfirm(CANCEL_CONFIRM_MESSAGE)
        else props.cancelMedia()
    }

    const actionMedia = () => {
        if (confirm === DELETE_CONFIRM_MESSAGE) deleteMedia()               
        if (confirm === CANCEL_CONFIRM_MESSAGE) {
            props.cancelMedia()
        }
    }

    const sortPrevious = (index) => {
        let newData = [...props.data]
        //swap their sort order values
        let prevIndex = index - 1
        while (prevIndex > 0 && newData[prevIndex].markedForDeletion) prevIndex--
        if (prevIndex !== index) {
            let sortOrder = newData[index].sortOrder
            newData[index].sortOrder = newData[prevIndex].sortOrder
            newData[prevIndex].sortOrder = sortOrder
            //swap array elements
            let moveElement = newData[index]
            newData[index] = newData[prevIndex]
            newData[prevIndex] = moveElement
            props.updateMedia(newData)
            setCurrentImageIndex(prevIndex)
        }
    }

    const sortNext = (index) => {
        let newData = [...props.data]
        //swap their sort order values
        let nextIndex = index + 1
        while (nextIndex < newData.length-2 && newData[nextIndex].markedForDeletion) nextIndex++
        if (nextIndex !== index) {
            let sortOrder = newData[index].sortOrder
            newData[index].sortOrder = newData[nextIndex].sortOrder
            newData[nextIndex].sortOrder = sortOrder
            //swap array elements
            let moveElement = newData[index]
            newData[index] = newData[nextIndex]
            newData[nextIndex] = moveElement
            props.updateMedia(newData)
            setCurrentImageIndex(nextIndex)
        }
    }

    const scrollPosition = () => {
        window.scroll({
            top: window.scrollY + refContainer.current.getBoundingClientRect().top - 140,
            behavior: 'smooth'
            });
    }

    return (
        <div className='edit-entity-image' ref={refContainer}>
            <div className='button-container' ref={refButtonContainer}>
                <IconButton styleName='add-button' caption='Add' 
                    src={icons.addIcon} onClick={selectFile}></IconButton>
                <IconButton styleName='save-button' caption={props.profile ? 'Save' : 'Done'} 
                    disabled={!props.dirty}
                    src={props.profile ? icons.saveIcon : icons.checkIcon} onClick={props.saveMedia}></IconButton>
                <IconButton styleName='delete-button' caption='Delete' 
                    disabled={(props.data.length<1)}
                    src={icons.deleteIcon} 
                    onClick={()=>setConfirm(DELETE_CONFIRM_MESSAGE)}>
                </IconButton>
                <IconButton styleName={(props.dirty ? 'cancel-button' : 'edit-button')} caption={(props.dirty ? 'Cancel' : 'Close')}
                    src={icons.closeIcon} 
                    onClick={cancelMedia}></IconButton>
            </div>
            {props.data &&
                <div className='edit-avatar-images'>
                    {props.data[currentImageIndex] &&
                        <EditImage index={currentImageIndex}
                            src={mediaPath(currentImageIndex, props.data, props.idEntity, props.entityType)}
                            new={props.data[currentImageIndex].new}
                            left={props.data[currentImageIndex].xOffset}
                            top={props.data[currentImageIndex].yOffset}
                            scale={props.data[currentImageIndex].scale}
                            setPosition={setPosition}   
                            circular={props.circular}>
                        </EditImage>
                    }
                </div>
            }
            {props.data && 
                <div className='media-strip-container'>
                    <div className='media-strip'>
                        {props.data.map((row,index)=>{
                            if (!row.markedForDeletion)
                                return (<Fragment key={row.fileName}>
                                            {index===currentImageIndex && index!==0 &&
                                                <button className='strip-sort-arrow' onClick={()=>sortPrevious(index)}>
                                                    <img className='strip-sort-arrow' src={icons.previousIcon}
                                                        alt='Move to previous'></img>
                                                </button>}
                                            <ScaledImage key={index} 
                                                styleName={index===currentImageIndex ? 'strip-thumb-nail strip-selected'
                                                    : 'strip-thumb-nail'} onClick={()=>setCurrentImageIndex(index)}
                                                    size='x-small' src={mediaPath(index, props.data, props.idEntity)}
                                                    left={row.xOffset} top={row.yOffset} scale={row.scale}
                                                    circular={props.circular}>
                                            </ScaledImage>
                                            {index===currentImageIndex && index!==props.data.length-1 && 
                                                <button className='strip-sort-arrow' onClick={()=>sortNext(index)}>
                                                    <img className='strip-sort-arrow' src={icons.nextIcon}
                                                        alt='Move to next'></img>
                                                </button>}
                                        </Fragment>)
                            else return null
                        })}
                    </div>
                </div>
            }
            <input ref={inputFile} type='file' className='hidden-file-input' onChange={onChange}/>
            {confirm && <Modal buttonText='Yes' onClick={actionMedia}
                buttonTwoText='No' onClickTwo={()=>setConfirm(null)}>{confirm}</Modal>}
            <input ref={inputFile} type='file' className='hidden-file-input' onChange={onChange}/>
        </div>
    )
}

export default EditEntityImage
