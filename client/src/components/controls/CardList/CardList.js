import React, { useState } from 'react'
import CardDetails from '../../CardDetails/CardDetails'
import './CardList.css'

const CardList = (props) => {

    const [selectedCard, setSelectedCard] = useState(-1)

    return (
        <div className='card-list'>
            {props.data.length > 0 && props.data.map((row, index) => {
                return (
                    <div key={index} className=
                        {selectedCard === index ? 'card-list-item card-list-selected' : 'card-list-item'}>
                        <CardDetails row={row} index={index} cardHeading={props.cardHeading} 
                            isEditing={props.isEditing && selectedCard === index} data={props.data}
                            setValid={props.setValid} onChange={props.onChange}
                            onSelect={()=>setSelectedCard(index)}></CardDetails>
                    </div>
                )
            })}
        </div>
    )
}

export default CardList