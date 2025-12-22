import React, { useEffect, useRef, useState } from 'react'
import Button from '../buttons/Button'
import './Modal.css'

const Modal = (props) => {

    const [containerTop, setContainerTop] = useState(0)
    const refModalContainer = useRef()

    // vertically position modal container
    useEffect(() => {
        setContainerTop(-refModalContainer.current.getBoundingClientRect().top)
    }, [])
    

    return (
        <div className='modal-container' ref={refModalContainer} style={{top: containerTop}}>
            <div className={props.styleName ? `${props.styleName} modal` : 'modal'}>{props.children}
                <div className='modal-button-container'>
                    <Button styleName='primary modal default-color' onClick={props.onClick}>{props.buttonText}</Button>
                    {props.buttonTwoText &&
                        <Button styleName='primary modal default-color' onClick={props.onClickTwo}>{props.buttonTwoText}</Button>}
                </div>
            </div>
            <div className='hazy-div'></div>
        </div>
    )
}

export default Modal
