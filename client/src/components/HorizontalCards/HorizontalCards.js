import React, {useState, useRef, useEffect} from 'react'
import CardDetails from '../CardDetails/CardDetails'
import './HorizontalCards.css'

const HorizontalCards = (props) => {

    const [startX, setStartX] = useState(0)
    const [containerStartLeft, setContainerStartLeft] = useState(0)
    const [isDragging, setIsDragging] = useState(false)
    const [dragDistance, setDragDistance] = useState(0)
    const [cursor, setCursor] = useState('grab')
    const refContainer = useRef()
    const refCard = useRef([])
    
    // if cards are removed, the refCard array is holding onto null cards, so remove them if the data changes
    useEffect(() => {
        refCard.current.forEach((card, index) => {
            if (card === null) refCard.current.splice(index,1)
        })
    }, [props.data])

    const styleRow = (index) => {
        let style = 'horizontal-card '
        if (props.currentRow === index) style += 'current '
        else style += 'adjacent '
        if (!(index === 0 && index === props.data.length-1)) {
            if (index === 0) style += 'left '
            if (index === props.data.length-1) style += 'right '
            style += 'horizontal-card-margin'
        }
        else style += 'horizontal-card-margin-single-card'
        return style
    }

    const dragStart = (event) => {
        if (refCard.current.length > 1) {
            setIsDragging(true)
            setCursor('grabbing')
            props.setCurrentRow(-1)
            let newStartX = event.clientX
            setStartX(newStartX)
            setDragDistance(0)
            setContainerStartLeft(refContainer.current.scrollLeft)
        }
    }

    const dragCards = (event) => {
        if (isDragging) {
            props.setCurrentRow(-1)
            let newX = event.clientX
            let newDragDistance = startX - newX
            let newContainerStartLeft = containerStartLeft
            refContainer.current.scrollLeft = newContainerStartLeft + newDragDistance
            setDragDistance(newDragDistance)
        }
    }

    const dragEnd = () => {
        if (isDragging) {
            setIsDragging(false)
            setCursor('grab')
            let cardWidth = refCard.current[0].getBoundingClientRect().width
            let cardGaps
            if (refCard.current.length > 1)
                cardGaps = (refCard.current[1].getBoundingClientRect().left - 
                    (refCard.current[0].getBoundingClientRect().left + cardWidth))
            else cardGaps = 0
            let cardLefts = []
            if (dragDistance === 0) {
                refCard.current.forEach((card, index) => {
                    cardLefts[index] = card.getBoundingClientRect().left
                    if ((cardLefts[index] - cardGaps / 2) <= startX &&
                        (cardLefts[index] + cardWidth + cardGaps / 2) >= startX) {
                        props.setCurrentRow(index)
                    }
                })
                if (cardLefts[0] > startX) props.setCurrentRow(0)
                if (cardLefts[refCard.current.length - 1] < startX) props.setCurrentRow(refCard.current.length - 1)
            }
            else {
                let centerline = (refContainer.current.clientWidth / 2 +
                    refContainer.current.getBoundingClientRect().left)
                refCard.current.forEach((card, index) => {
                    cardLefts[index] = card.getBoundingClientRect().left
                    if (cardLefts[index] - cardGaps / 2 <= centerline &&
                        (cardLefts[index] + cardWidth + cardGaps / 2) >= centerline) {
                        props.setCurrentRow(index)
                    }
                })
            }
        }
    }

    return (
            <div className='row-card-container' ref={refContainer} onPointerDown={(event)=>dragStart(event)}
                onPointerMove={(event)=>dragCards(event)} onPointerUp={(event)=>dragEnd(event)}
                style={{cursor: cursor}} onPointerLeave={()=>dragEnd()}>
                {props.data.length > 0 && props.data.map((row, index) => {
                    return (
                        <div key={index} className={styleRow(index)}
                            ref={element => refCard.current[index] = element}>
                            <CardDetails row={row} index={index} cardHeading={props.cardHeading} 
                                isEditing={props.isEditing} data={props.data}
                                setValid={props.setValid} onChange={props.onChange}></CardDetails>
                        </div>
                    )
                })}
            </div>
    )
}

export default HorizontalCards
