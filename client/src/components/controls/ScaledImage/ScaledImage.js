import React, {useEffect, useRef, useState} from 'react'
import './ScaledImage.css'

const THUMBNAIL_SIZE = []
THUMBNAIL_SIZE['xxx-small'] = 18 // 1 border for 20
THUMBNAIL_SIZE['xx-small'] = 36 // 2 border for 40
THUMBNAIL_SIZE['x-small'] = 58  // 3 border for 64
THUMBNAIL_SIZE['small'] = 94 // 3 border for 100
THUMBNAIL_SIZE['medium'] = 122 // 3 border for 128
THUMBNAIL_SIZE['large'] = 246 // 5 border for 256
const SCALE_REFERENCE = 350

const ScaledImage = (props) => {
    
    const refImage = useRef()
    const [left, setLeft] = useState(props.left)
    const [top, setTop] = useState(props.top)
    const [height, setHeight] = useState(0)
    const [width, setWidth] = useState(0)
    
    useEffect(() => {
        sizeImage()
    }, [props.size, props.scale, props.left, props.top])
    
    const sizeImage = () => {
        let initialHeight = refImage.current.naturalHeight
        let initialWidth = refImage.current.naturalWidth
        let aspectRatio = initialWidth / initialHeight
        var initialLeft, initialTop
        if (initialHeight > initialWidth) {
            initialWidth = THUMBNAIL_SIZE[props.size] * props.scale
            initialHeight = initialWidth / aspectRatio
            if (props.left !== null) initialLeft = (props.left) * (THUMBNAIL_SIZE[props.size]/SCALE_REFERENCE)
            else initialLeft = 0
            if (props.top !== null) initialTop = (props.top) * (THUMBNAIL_SIZE[props.size]/SCALE_REFERENCE)
            else initialTop = (THUMBNAIL_SIZE[props.size]/2) - (initialHeight / 2)
        }
        else {
            initialHeight = THUMBNAIL_SIZE[props.size] * props.scale
            initialWidth = initialHeight * aspectRatio
            if (props.left !== null) initialLeft = props.left * (THUMBNAIL_SIZE[props.size]/SCALE_REFERENCE)
            else initialLeft = (THUMBNAIL_SIZE[props.size]/2) - (initialWidth / 2)
            if (props.top !== null) initialTop = props.top * (THUMBNAIL_SIZE[props.size]/SCALE_REFERENCE)
            else initialTop = 0
        }
        setLeft(initialLeft)
        setTop(initialTop)
        setHeight(initialHeight)
        setWidth(initialWidth)
    }
    
    const setClass = () => {
        var style = 'scaled-image-container-' + props.size
        if (props.styleName) style += ' ' + props.styleName
        if (props.circular)  style += ' circular'
        return style
    }

    return (
        <div className={setClass()}>
            <img className='scaled-image'
                 onLoad={sizeImage}
                 ref={refImage}
                 src={props.src}
                 style={{
                    height: height,
                    left: left,
                    top: top,
                    width: width
                 }}
                 onClick={props.onClick}
                 alt='entity media'
            />            
        </div>
    )
}

export default ScaledImage
