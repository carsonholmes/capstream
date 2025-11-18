import React, {useRef, useState, useEffect, Fragment} from 'react'
import {AppContext} from '../../../AppContext'
import infoIcon from '../../../assets/images/info.png'
import icons from '../../../shared/icons'
import './HelpIcon.css'

const HelpIcon = (props) => {

    const [displayHelp, setDisplayHelp] = useState(false)
    const [iconTop, setIconTop] = useState(0)
    const [documentHeight, setDocumentHeight] = useState(0)
    const refInfoIcon = useRef()
    const refHelpContainer = useRef()
    const refClearDiv = useRef()
    const [clearDivTop, setClearDivTop] = useState(0)
    const {appContext} = React.useContext(AppContext)

    useEffect(() => {
      if (refClearDiv.current) setClearDivTop(refClearDiv.current.offsetTop)
    }, [])
    

    useEffect(() => {
        const checkViewportScroll = () => {
            if (refHelpContainer.current && refHelpContainer.current.getBoundingClientRect().top < 0 ) {
                if (appContext.signedIn && appContext.authState === 'home' && appContext.cartQuantity > 0){
                window.scroll({
                    top: window.scrollY + refHelpContainer.current.getBoundingClientRect().top - 48, //48px = banner height
                    behavior: 'smooth'
                    })
                }
                else {
                    window.scroll({
                        top: window.scrollY + refHelpContainer.current.getBoundingClientRect().top,
                        behavior: 'smooth'
                        })
                }
            }
        }
    
        checkViewportScroll()
        setDocumentHeight(document.body.scrollHeight)
    }, [displayHelp, appContext])

    const positionHelp = () => {
        if (refInfoIcon.current) {
            setIconTop(refInfoIcon.current.getBoundingClientRect().top - window.scrollY)
        }
        setDisplayHelp(true)
    }

    return (
        <Fragment>
            <img className={props.styleName ? `help-icon ${props.styleName}` : 'help-icon'} ref={refInfoIcon}
                src={infoIcon} onClick={positionHelp} alt='Help Info'/>
            {displayHelp && 
                <div className='clear-div' onClick={()=>setDisplayHelp(false)}
                    style={{height: documentHeight}} ref={refClearDiv}>
                    <div className='help-container' ref={refHelpContainer}
                        style={{bottom: documentHeight - iconTop - window.scrollY + 3}}>
                        <img className='help-close-x' src={icons.closeBlackIcon} alt='Close'></img>
                        {props.children}
                    </div>
                </div>
            }
        </Fragment>
    )
}

export default HelpIcon
