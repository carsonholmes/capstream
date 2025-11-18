import React from 'react'
import Button from '../buttons/Button'
import './TileSelect.css'

const TileSelect = (props) => {

    const notifyChange = (index) => {
        if (props.onChange) 
            if (props.type === 'text') props.onChange(props.dataCol, props.data[index].value)
            else props.onChange(props.dataCol, parseInt(props.data[index].value))
    }

    return (
        <div className='tile-select-container' disabled={props.disabled}>
            <h2 className='tile-select-label'>{`\u00A0 ${props.label} \u00A0`}</h2>
            <div className='tile-container'>
                {props.data.map((row, index) => {
                    return (
                        <Button key={index} value={row.value} 
                            styleName={row.value === props.value ? 'primary tile-select tile-selected' :
                                'primary tile-select'}
                            onClick={()=>notifyChange(index)}>
                            {row.caption}
                        </Button>
                    )
                })}
            </div>
        </div>
    )
}

export default TileSelect
