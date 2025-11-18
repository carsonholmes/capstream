import {React, useState, useRef, useEffect, useCallback} from 'react'
import icons from '../../../shared/icons'
import './FullPageImageModal.css'

const FullPageImageModal = (props) => {

    const refImage = useRef()
    const [initialHeight, setInitialHeight] = useState(0)
    const [initialWidth, setInitialWidth] = useState(0)
    const [initialLeft, setInitialLeft] = useState(0)
    const [height, setHeight] = useState(0)
    const [width, setWidth] = useState(0)
    const [startX, setStartX] = useState(0)
    const [startY, setStartY] = useState(0)
    const [isSwiping, setIsSwiping] = useState(false)
    const [isDragging, setIsDragging] = useState(false)
    const [startLeft, setStartLeft] = useState(null)
    const [startTop, setStartTop] = useState(0)
    const [left, setLeft] = useState(0)
    const [top, setTop] = useState(0)
    const [isPinching, setIsPinching] = useState(false)
    const prevPinchDistance = useRef()
    const [scale, setScale] = useState(1)
    const [scrollListener, setScrollListener] = useState(false)
    const [imageVisibility, setImageVisibility] = useState('hidden')
    const refContainer = useRef()
    
    const calcResize = useCallback(() => {
        let windowHeightPercent = 1
        if (props.imageArrayLength > 1) windowHeightPercent = .9
        if (refImage.current) {
            let imgAspectRatio = refImage.current.naturalWidth / refImage.current.naturalHeight
            let windowAspectRatio = window.innerWidth / (window.innerHeight * windowHeightPercent)
            let newInitialWidth
            let newInitialHeight
            if (imgAspectRatio >= windowAspectRatio) { // if the image is wider than the window
                newInitialWidth = window.innerWidth
                newInitialHeight = window.innerWidth / imgAspectRatio
            }
            else { // if the window is wider than the image
                newInitialHeight = window.innerHeight * windowHeightPercent
                newInitialWidth = newInitialHeight * imgAspectRatio
            }
            setInitialWidth(newInitialWidth)
            setWidth(newInitialWidth)
            setInitialHeight(newInitialHeight)
            setHeight(newInitialHeight)
            let newLeft = (window.innerWidth / 2) - (newInitialWidth / 2)
            setInitialLeft(newLeft)
            setLeft(newLeft)
            setTop(0)
            setScale(1)
            setImageVisibility('inherit')
        }
    }, [setInitialWidth, setInitialHeight, setWidth, setHeight, props.imageArrayLength])

    useEffect(()=>{
        setImageVisibility('hidden')
        //size a div over the image with the same size, that says loading image...
    },[props.src])

    useEffect(() => {
        window.addEventListener('resize', ()=> {
            calcResize()
        })
    }, [calcResize])

    useEffect(()=> { 
        if (!scrollListener) {
            setScrollListener(true)
            refContainer.current.addEventListener('wheel',(e)=>preventScroll(e), {passive: false})
        }        
    }, [scrollListener])

    const preventScroll = (event) => {
        event.preventDefault()
    }

    const goPrevious = () => {
        if (props.currentImageIndex === 0) props.setCurrentImageIndex(props.imageArrayLength - 1)
        else props.setCurrentImageIndex(props.currentImageIndex - 1)
    }

    const goNext = () => {
        if (props.currentImageIndex === props.imageArrayLength - 1)
            props.setCurrentImageIndex(0)
        else props.setCurrentImageIndex(props.currentImageIndex + 1)
    }

    const pointerDown = (event) => {
        if (props.imageArrayLength > 1 && scale === 1) { // start swipe
            setIsSwiping(true)
            setIsDragging(false)
            setIsPinching(false)
            setStartX(event.clientX)
        }
        if (scale > 1) { // start drag
            setIsDragging(true)
            setIsSwiping(false)
            setIsPinching(false)
            setStartLeft(left)
            setStartTop(top)
            setStartX(event.clientX)
            setStartY(event.clientY)
        }
    }

    const pointerMove = (event) => {
        if (isDragging && !isPinching) { // drag
            let newLeft = startLeft + event.clientX - startX
            let newTop = startTop + event.clientY - startY
            if (scale > 1) {
                if (height > window.innerHeight && width > window.innerWidth){
                    if (newLeft > 0) newLeft = 0
                    if (newLeft + width < window.innerWidth) newLeft = window.innerWidth - width
                    if (newTop > 0) newTop = 0
                    if (newTop + height < window.innerHeight) newTop = window.innerHeight - height
                }
                if (height > window.innerHeight && width < window.innerWidth) {
                    newLeft = left
                    if (newTop > 0) newTop = 0
                    if (newTop + height < window.innerHeight) newTop = window.innerHeight - height
                }
                if (height < window.innerHeight && width > window.innerWidth) {
                    if (newLeft > 0) newLeft = 0
                    if (newLeft + width < window.innerWidth) newLeft = window.innerWidth - width
                    newTop = 0
                }
            }
            setLeft(newLeft)
            setTop(newTop)
        }
        if (isSwiping) { // swipe
            let newLeft = initialLeft + event.clientX - startX
            setLeft(newLeft)
        }
    }

    const pointerUp = () => {
        if (isSwiping) {
            setIsSwiping(false)
            if (left > (window.innerWidth * .25 + initialLeft)) goPrevious()
            else if (left < (initialLeft - window.innerWidth * .25)) goNext()
                else setLeft(initialLeft)
        }
        if (isDragging) {
            setIsDragging(false)
        }
    }

    const startPinch = (event) => {
        if (event.touches.length === 2 && !isPinching) {
            setIsPinching(true)
            setIsDragging(false)
            setIsSwiping(false)
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

    const wheel = (event) => {
        let newScale
        if (event.deltaY < 0) newScale = scale * 1.1
        else newScale = scale / 1.1
        scaleImage(newScale)
    }

    const scaleImage = (newScale) => {
        let newLeft
        let leftPercent = ((window.innerWidth / 2) - left) / width
        let topPercent = ((window.innerHeight/ 2) - top) / height
        if (newScale < 1) newScale = 1
        let newWidth = initialWidth * newScale
        let newHeight = initialHeight * newScale
        newLeft = left - ((newWidth - width) * leftPercent)
        let newTop = top - ((newHeight - height) * topPercent)
        if (newHeight < window.innerHeight) newTop = 0
        if (newWidth > window.innerWidth) {
            if (newLeft > 0) newLeft = 0
            if (newLeft + newWidth < window.innerWidth) newLeft = window.innerWidth - newWidth
        }
        if (newHeight > window.innerHeight) {
            if (newTop > 0) newTop = 0
            if (newTop + newHeight < window.innerHeight) newTop = window.innerHeight - newHeight
        }
        if (newScale === 1) {
            setLeft(initialLeft)
            setTop(0)
        }
        else {
            setLeft(newLeft)
            setTop(newTop)
        }
        setHeight(newHeight)
        setWidth(newWidth)
        setScale(newScale)
    }

    const endPinch = () => setIsPinching(false)

    const handleDoubleClick = () => {
        if (scale === 1) scaleImage(2)
        else scaleImage(1)
    }

    const setCursor = () => {
        let cursor = 'unset'
        if (props.imageArrayLength > 1 || scale > 1) cursor = 'grab'
        if (isDragging || isSwiping) cursor = 'grabbing'
        return cursor
    }

    return (
        <main className='full-page-image-container'>
            <div className='full-image-container'
                onPointerDown={(event)=>pointerDown(event)}
                onPointerMove={(event)=>pointerMove(event)}
                onPointerUp={(event)=>pointerUp(event)}
                onPointerOut={(event)=>pointerUp(event)}
                onDoubleClick={(event)=>handleDoubleClick(event)}
                onWheel={(event)=>wheel(event)} ref={refContainer}>
                <img className='modal-image' src={props.src} ref={refImage} alt='full page'
                    onTouchStart={(event)=>startPinch(event)}
                    onTouchMove={(event)=>pinchImage(event)}
                    onTouchEnd={(event)=>endPinch(event)}
                    onLoad={calcResize}
                    style={{cursor: setCursor(),
                            height: height,
                            left: left,
                            top: top,
                            visibility: imageVisibility,
                            width: width}}
                    draggable='false'/>
                <img className='full-page-image-close' src={icons.closeIcon} alt='Close'
                    onClick={props.onClose}/>
            </div>
            {props.imageArrayLength > 1 &&
                <div className='chevron-container'>
                    <img className='full-page-chevron' src={icons.previousIcon} alt='Previous'
                        onClick={()=>goPrevious()}/>
                    <img className='full-page-chevron' src={icons.nextIcon} alt='Next' onClick={()=>goNext()}/>
                </div>
            }
        </main>
    )
}

export default FullPageImageModal
