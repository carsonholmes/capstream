import React, {useState} from 'react'
import TextBox from '../TextBox/TextBox'
import './Dropdown.css'

const Dropdown = (props) => {

    const [hasFocus, setHasFocus] = useState(false)

    const onChange = (index) => {
        if (props.onChange) props.onChange(props.dataCol, props.data[index].value)
    }

    const findCaption = (value) => {
        let found = -1
        for (let i=0; i<props.data.length && found<0; i++) {
            if (props.data[i].value === props.value) found = i
        }
        if (found>=0) return props.data[found].caption
        else return ''
    }

    return (    
        <div className={props.containerStyle ? `${props.containerStyle} dropdown-container` :
            'dropdown-container'}>
                <TextBox id={props.id} dataCol={props.dataCol} styleName={props.styleName ?
                    `${props.styleName} dropdown-input` : 'dropdown-input'}
                    value={findCaption(props.value)} placeholder={props.placeholder}
                    onFocus={()=>setHasFocus(true)} onBlur={()=>setHasFocus(false)}
                    containerStyle='dropdown-input' inputMode='none'>
                </TextBox>
            {hasFocus && 
                <div className='dropdown-list'>
                    {props.data.map((row, index) => {
                        return (
                            <label key={index} 
                                className={(props.value===row.value) ? 'dropdown-item dropdown-item-selected' :
                                    'dropdown-item dropdown-item-hover'}
                                onMouseDown={()=>onChange(index)}>{row.caption}
                            </label>
                        )
                    })}
                </div>
            }
        </div>
    )
}

export default Dropdown
