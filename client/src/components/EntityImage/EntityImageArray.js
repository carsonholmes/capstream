import {React} from 'react'
import mediaPath from '../../shared/mediaPath'
import ScaledImage from '../controls/ScaledImage/ScaledImage'
// uses styling from EditEntityImage.css

const EntityImageArray = (props) => {

    const handleClick = (index) => {
        if (!props.notSelectable) props.setCurrentImageIndex(index)
    }

    const getClass = (index) => {
        if (index===props.currentImageIndex && !props.notSelectable) return 'strip-thumb-nail strip-selected'
        if (props.notSelectable) return 'strip-thumb-nail not-selectable'
        else return 'strip-thumb-nail'
    }

    return (
        <div className={props.styleName ? `media-strip ${props.styleName}` : 'media-strip'}>
            {props.data.map((row,index)=>{
                if (!row.markedForDeletion)
                    return (
                        <ScaledImage key={row.fileName} 
                            styleName={getClass(index)}
                            size={props.size} src={mediaPath(index, props.data, props.idEntity, props.entityType)} left={row.xOffset} top={row.yOffset} scale={row.scale}
                            onClick={()=>handleClick(index)}
                            circular={props.circular}>
                        </ScaledImage>)
                else return null
            })}
        </div>
    )
}

export default EntityImageArray