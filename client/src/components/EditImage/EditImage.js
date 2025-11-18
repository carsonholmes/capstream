import React, {useState, useRef, useEffect} from 'react'
import './EditImage.css'
const REFERENCE_WIDTH = 400

const EditImage = (props) => {

    const [left, setLeft] = useState(0)
    const [top, setTop] = useState(0)
    const [startLeft, setStartLeft] = useState(null)
    const [startTop, setStartTop] = useState(null)
    const [isDragging, setIsDragging] = useState(false)
    const [startX, setStartX] = useState(0)
    const [startY, setStartY] = useState(0)
    const [cursor, setCursor] = useState('grab')
    const [scale, setScale] = useState(props.scale)
    const [scrollListener, setScrollListener] = useState(false)
    const [sizedForSrc, setSizedForSrc] = useState('')
    const refContainer = useRef()
    const refImage = useRef()
    const refCircleSVG = useRef()
    const [height, setHeight] = useState(0)
    const [width, setWidth] = useState(0)
    const [minHeight, setMinHeight] = useState(0)
    const [minWidth, setMinWidth] = useState(0)
    const [containerWidth, setContainerWidth] = useState(400)
    const [maskMargin] = useState(25)
    const [isPinching, setIsPinching] = useState(false)
    const prevPinchDistance = useRef()
    
    useEffect(()=> {
        let newContainerWidth
        if (window.innerWidth < REFERENCE_WIDTH || window.innerHeight < REFERENCE_WIDTH) {
            if (window.innerWidth <= window.innerHeight) newContainerWidth = window.innerWidth
            else newContainerWidth = window.innerHeight
        }
        else newContainerWidth = REFERENCE_WIDTH
        if (refImage.current.naturalHeight > 0 && sizedForSrc !== props.src) {
            setSizedForSrc(props.src)  //set the src of the image to be sized
            let initialHeight = refImage.current.naturalHeight
            let initialWidth = refImage.current.naturalWidth
            let aspectRatio = initialWidth / initialHeight
            var initialLeft, initialTop
            if (initialHeight > initialWidth) { // portrait image
                initialWidth = (newContainerWidth - (maskMargin * 2)) * props.scale
                initialHeight = initialWidth / aspectRatio
                if (props.left !== null) initialLeft = props.left * (newContainerWidth  / (REFERENCE_WIDTH))
                else initialLeft = 0
                if (props.top !== null) initialTop = props.top  * (newContainerWidth / (REFERENCE_WIDTH ))
                else initialTop = (newContainerWidth / 2) - (initialHeight / 2) - maskMargin
            }
            else { // landscape image
                initialHeight = (newContainerWidth - (maskMargin * 2)) * props.scale
                initialWidth = initialHeight * aspectRatio
                if (props.left !== null) initialLeft = props.left * ((newContainerWidth - (maskMargin * 2)) /
                    (REFERENCE_WIDTH - (maskMargin * 2)))
                else initialLeft = (newContainerWidth / 2) - (initialWidth / 2) - maskMargin
                if (props.top != null) initialTop = props.top  * ((newContainerWidth - (maskMargin * 2)) /
                    (REFERENCE_WIDTH - (maskMargin * 2)))
                else initialTop = 0
            }
            setLeft(maskMargin + initialLeft)
            setTop(maskMargin + initialTop)
            if (props.new) props.setPosition(props.index, initialLeft, initialTop, props.scale)
            setHeight(initialHeight)
            setWidth(initialWidth)
            setMinHeight(initialHeight / props.scale)
            setMinWidth(initialWidth / props.scale)
            setScale(props.scale)
        }
        else if (sizedForSrc !== props.src) setHeight(height+1)  //keep adding one to height so useEffect keeps getting triggered until we have a naturalHeight
        setContainerWidth(newContainerWidth)
    }, [sizedForSrc, props, height, containerWidth, maskMargin])

    useEffect(()=> { 
        if (!scrollListener) {
            setScrollListener(true)
            refContainer.current.addEventListener('wheel',(e)=>preventScroll(e), {passive: false})
        }        
    }, [scrollListener])

    const grab = (event) => {
        setCursor('grabbing')
        setStartX(event.clientX)
        setStartY(event.clientY)
        let currentLeft = refImage.current.offsetLeft
        let currentTop = refImage.current.offsetTop
        setLeft(currentLeft)
        setTop(currentTop)
        setStartLeft(currentLeft)
        setStartTop(currentTop)
        setIsDragging(true)
    }

    const dragImage = (event) => {
        if (isDragging && !isPinching) {
            let newLeft = startLeft + (event.clientX - startX)
            let newTop = startTop + (event.clientY - startY)
            if (newLeft > maskMargin) newLeft = maskMargin
            if ((newLeft + width) < (containerWidth - maskMargin)) newLeft = (containerWidth - maskMargin - width)
            if (newTop > maskMargin) newTop = maskMargin
            if ((newTop + height) < (containerWidth - maskMargin)) newTop = (containerWidth - maskMargin - height)
            setLeft(newLeft)
            setTop(newTop)
            let outboundLeft = ((newLeft- maskMargin) * ((REFERENCE_WIDTH - (maskMargin*2)) /
                (containerWidth - (maskMargin*2))))
            let outboundTop = ((newTop- maskMargin) * ((REFERENCE_WIDTH - (maskMargin*2)) /
                (containerWidth - (maskMargin*2))))
            props.setPosition( props.index, outboundLeft, outboundTop, scale)
        }
    }

    const endDrag = () => {
        setIsDragging(false)
        setCursor('grab')
    }

    const wheel = (event) => {
        let newScale
        if (event.deltaY < 0) newScale = scale * 1.1
        else newScale = scale / 1.1
        scaleImage(newScale)
    }

    const preventScroll = (event) => {
        event.preventDefault()
    }

    const scaleImage = (newScale) => {
        let leftPercent = ((containerWidth / 2) - left) / width
        let topPercent = ((containerWidth / 2) - top) / height
        if (newScale < 1) newScale = 1
        let newWidth = minWidth * newScale
        let newHeight = minHeight * newScale
        let newLeft = left - ((newWidth - width) * leftPercent)
        let newTop = top - ((newHeight - height) * topPercent)
        if (newLeft > maskMargin) newLeft = maskMargin
        if ((newLeft + newWidth) < (containerWidth - maskMargin))
            newLeft = containerWidth - maskMargin - newWidth
        if (newTop > maskMargin) newTop = maskMargin
        if ((newTop + newHeight) < (containerWidth - maskMargin))
            newTop = containerWidth - maskMargin - newHeight
        setLeft(newLeft)
        setTop(newTop)
        setHeight(newHeight)
        setWidth(newWidth)
        setScale(newScale)
        let outboundLeft = ((newLeft- maskMargin) * ((REFERENCE_WIDTH - (maskMargin*2)) /
            (containerWidth - (maskMargin*2))))
        let outboundTop = ((newTop- maskMargin) * ((REFERENCE_WIDTH - (maskMargin*2)) /
            (containerWidth - (maskMargin*2))))
        props.setPosition( props.index, outboundLeft, outboundTop, newScale)
    }

    const startPinch = (event) => {
        if (event.touches.length === 2 && !isPinching) {
            setIsPinching(true)
            let newPinchDistance = Math.hypot(
                event.touches[0].pageX - event.touches[1].pageX,
                event.touches[0].pageY - event.touches[1].pageY)
            prevPinchDistance.current = newPinchDistance
        }
    }

    const pinchImage = (event) => {
        if (isPinching) {
            let newPinchDistance = Math.hypot(
                event.touches[0].pageX - event.touches[1].pageX,
                event.touches[0].pageY - event.touches[1].pageY)
            let newScale = scale * (newPinchDistance / prevPinchDistance.current)
            if (newScale !== scale) scaleImage(newScale)
            prevPinchDistance.current = newPinchDistance
        }
    }

    const endPinch = () => setIsPinching(false)

    return (
        <>
        <div className='edit-image-container' onPointerOut={endDrag} onWheel={(event)=>wheel(event)}
            ref={refContainer} style={{height: containerWidth, width: containerWidth}}>
            <img className='avatar-original' src={props.src} alt='avatar original' 
                style={{
                    height: height,
                    left: left,
                    minHeight: minHeight,
                    minWidth: minWidth,
                    top: top,
                    width: width
                }}
                draggable='false'
                ref={refImage}/>
            <svg className='avatar-mask' 
                ref={refCircleSVG}
                style={{cursor: cursor, height: containerWidth, width: containerWidth}}
                onPointerDown={(event)=>grab(event)}
                onPointerMove={(event)=>dragImage(event)}
                onPointerUp={endDrag}
                onTouchStart={(event)=>startPinch(event)}
                onTouchMove={(event)=>pinchImage(event)}
                onTouchEnd={()=>endPinch()}>
                <mask id='mask' x='0' y='0' width='100' height='100'>
                    <rect x='0' y='0' width={containerWidth} height={containerWidth} fill='#fff'/>
                    {props.circular ?
                        <circle cx={containerWidth / 2} cy={containerWidth / 2}
                            r={(containerWidth - (maskMargin * 2)) / 2} fill='black'/>
                    :
                        <rect x={maskMargin} y={maskMargin} width={(containerWidth - (maskMargin * 2))}
                            height={(containerWidth - (maskMargin * 2))} fill='black'/>
                    }
                </mask>
                <rect x='0' y='0' width={containerWidth} height={containerWidth} mask='url(#mask)'
                    fillOpacity='0.5'/>    
            </svg>
        </div>
        </>
    )

}
export default EditImage