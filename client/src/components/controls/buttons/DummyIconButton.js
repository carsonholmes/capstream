import React from 'react'
import './button.css'

const DummyIconButton = (props) => {

    return (
        <button className={props.styleName ? `dummy-icon-button ${props.styleName}` : 'dummy-icon-button'}>
            <div className='button-contents-container'>
                <img className='icon' src={props.src} alt={props.caption}/>
                {props.caption &&
                    <label className='dummy-icon-button-caption'>
                        {props.caption}</label>}
            </div>
        </button>    
    )
}

export default DummyIconButton
