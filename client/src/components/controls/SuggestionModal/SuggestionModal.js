import React, { useContext, useEffect, useRef, useState  } from 'react'
import {AppContext} from '../../../AppContext'
import SuggestionCDO from '../../../cdos/SuggestionCDO'
import Button from '../buttons/Button'
import Modal from '../Modal/Modal'
import './SuggestionModal.css'
// uses styling from App.css, Card.css, & Modal.css
const cdo = new SuggestionCDO()

const SuggestionModal = (props) => {

    const {appContext} = useContext(AppContext)
    const [suggestion, setSuggestion] = useState('')
    const [isProcessing, setIsProcessing] = useState(false)
    const [displayModal, setDisplayModal] = useState(false)
    const [containerTop, setContainerTop] = useState(0)
    const refModalContainer = useRef()

    // vertically position modal container
    useEffect(() => {
        setContainerTop(-refModalContainer.current.getBoundingClientRect().top)
    }, [])

    const onChange = (e) => {
        setSuggestion(e.target.value)
    }

    const disableSaveSuggestion = () => {
        return (suggestion.length === 0 || isProcessing)
    }

    const saveSuggestion = () => {
        if (!disableSaveSuggestion()){
            setIsProcessing(true)
            cdo.addData({suggestion: suggestion, idEntity: appContext.idEntity}, cbSaveSuggestion)
        }
    }

    const cbSaveSuggestion = (error, data) => {
        if (!error) {
            setDisplayModal(true)
        }
        else {
            alert('Error saving suggestion')
            setIsProcessing(false)
        }
    }

    const handleThankYouModal = () => {
        setDisplayModal(false)
        props.onClick()
    }

    return (
        <>
            <div className='modal-container' ref={refModalContainer} style={{top: containerTop}}>
                <div className='modal suggestion-modal'>
                    <div className='card-heading'>Suggestion Box</div>
                    <textarea className='suggestion-text' onChange={(event)=>onChange(event)}></textarea>
                    <div className='modal-button-container'>
                        <Button disabled={disableSaveSuggestion()} styleName = 'primary modal' 
                            onClick={saveSuggestion}>Submit</Button>
                        <Button styleName='primary modal' onClick={props.onClick}>Close</Button>
                    </div>
                </div>
                <div className='hazy-div'></div>
            </div>
            {displayModal &&
                <Modal buttonText='Close' onClick={handleThankYouModal}>Thank you for your suggestion!</Modal>
            }
        </>
    )
}

export default SuggestionModal
