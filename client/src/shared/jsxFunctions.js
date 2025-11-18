import React, { Fragment } from 'react'

export const formatText = (text) => {
    return (
        <Fragment>
            {text && text.split('\n').map((paragraph, index) => {
                return(
                    <Fragment key={index}>
                        {paragraph}
                        <br />
                    </Fragment>
                )
            })}
        </Fragment>
    )
}

const jsxFunctions = () => {
    
    return null
}

export default jsxFunctions