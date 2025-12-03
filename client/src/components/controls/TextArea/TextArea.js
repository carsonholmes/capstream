import React, {useEffect, useRef, useState} from 'react'
import './TextArea.css'
import { formatText } from '../../../shared/jsxFunctions'
// uses styling from TextBox.css

const TextArea = (props) => {

    const refDisplayTextArea = useRef()
    const [height, setHeight] = useState(0);

    useEffect( () => { 
        if (refDisplayTextArea.current && height === 0)
            var newHeight = refDisplayTextArea.current.scrollHeight
            var thirtyVH = document.body.clientHeight * .3
            if (newHeight < thirtyVH) newHeight = thirtyVH
            setHeight(newHeight) 
    }, [height]);

    const notifyChange = (event) => {
        if (props.onChange) props.onChange(props.dataCol, event.target.value)
    }
 
     if (props.displayOnly)
        return (
            <div style={props.style} className='input-container text-area-container'>
                <label htmlFor={props.id} className='display-text-area-label'>{props.placeholder}</label>
                <div style={{height: `${height}px`}} className='display-text-area-value'
                ref={refDisplayTextArea}>{formatText(props.value)}</div>
                {/* <textarea id={props.id} style={{height: `${height}px`}} ref={refDisplayTextArea} 
                    className='display-text-area-value input-area' disabled onClick={props.onClick} 
                    value={props.value}>
                </textarea> */}
            </div>
        )
    else return (
        <div style={props.style} className='input-container text-area-container'>
            <textarea id={props.id} value={props.value} placeholder=' ' onClick={props.onClick}
                className={props.styleName ? 
                    `text-area-element input-area ${props.styleName}`
                     :
                    'text-area-element input-area'}
                onFocus={props.onFocus} onChange={(event) => notifyChange(event)} onBlur={props.onBlur}>
            </textarea>
            <label htmlFor={props.id} className='input-label'>
                {props.placeholder}</label>
        </div>
     )
}

export default TextArea