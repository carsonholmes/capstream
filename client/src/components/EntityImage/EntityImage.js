import React, { useState, useEffect, useContext, Fragment } from 'react'
import { AppContext } from '../../AppContext'
import MediaCDO from '../../cdos/MediaCDO'
import mediaPath, {emptySrc} from '../../shared/mediaPath'
import ScaledImage from '../controls/ScaledImage/ScaledImage'
import FullPageImageModal from '../controls/FullPageImageModal/FullPageImageModal'
import './EntityImage.css'

const cdo = new MediaCDO()

const EntityImage = (props) => {

    const {appContext} = useContext(AppContext)
    const [data, setData] = useState([])
    const [dataLoaded, setDataLoaded] = useState(false)
    const [displayFullScreen, setDisplayFullScreen] = useState(false)
    const [currentImageIndex, setCurrentImageIndex] = useState(0)
    
    useEffect(()=>{
        if (!dataLoaded && cdo && props.idEntity) {
            setDataLoaded(true)
            cdo.loadData({idEntity: props.idEntity, idUser: appContext.idEntity,
                idSession: appContext.idSession}, cbLoadData)
        }
    }, [dataLoaded, props.idEntity, appContext.idEntity, appContext.idSession])

    const cbLoadData = (error, dbData) => {
        if (!error) {
            if (dbData && dbData[0]) {
                setData([...dbData])
            }
        }
        else alert('Error ' + dbData.error.errno + ' loading EntityImage: ' + dbData.error.code + ' - ' +
            dbData.error.sqlMessage);
    }

    const handleClick = () => {
        if (props.fullScreenAble) {
            if (props.toggleFilter) props.toggleFilter(false)
            setDisplayFullScreen(true)
        }
        else if (props.onClick) props.onClick()
    }

    const handleClose = () => {
        if (props.toggleFilter) props.toggleFilter(true)
        setDisplayFullScreen(false)
    }

    if (data.length>0)
        return (
            <Fragment>
                <ScaledImage styleName={props.styleName ? `avatar-image ${props.styleName}` : 'avatar-image'}
                    size={props.size} src={mediaPath(0, data, props.idEntity, props.entityType)}  
                    left={data[0].xOffset} top={data[0].yOffset} scale={data[0].scale}
                    onClick={handleClick} 
                    circular={props.circular}>
                </ScaledImage>
                {displayFullScreen &&
                    <FullPageImageModal onClose={handleClose} imageArrayLength={data.length}
                    src={mediaPath(currentImageIndex, data, props.idEntity, props.entityType)}
                    currentImageIndex={currentImageIndex} setCurrentImageIndex={setCurrentImageIndex}>
                    </FullPageImageModal>}
            </Fragment>)

    else return <img className={props.styleName ? `empty-avatar-${props.size} ${props.styleName}` :
        `empty-avatar-${props.size}`} src={emptySrc(props.entityType)} onClick={props.onClick} alt='Empty Avatar'/>
}

export default EntityImage