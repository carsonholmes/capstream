import React, {useEffect, useRef} from 'react'
import './Card.css'
import { AppContext } from '../../AppContext'

const Card = (props) => {

    const { appContext, setAppContext } = React.useContext(AppContext)
    const refCard = useRef()

    useEffect(() => {
        if (props.setRef) props.setRef(refCard.current)
    }, [refCard.current])
    

    return (
        <section className={props.styleName ? `card ${props.styleName} ${appContext.darkMode ? 'dark-mode' : 'light-mode'}` : `card ${appContext.darkMode ? 'dark-mode' : 'light-mode'}`}
            ref={refCard}>
            {props.cardHeading &&
            <h2 className={props.styleHeading ? `${props.styleHeading} card-heading` : 'card-heading'}>{props.cardHeading}</h2>}
            {props.children}
        </section>
    )
}

export default Card