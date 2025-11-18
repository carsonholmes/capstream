import React, { Fragment } from 'react'
import TextBox from '../controls/TextBox/TextBox'
import TextArea from '../controls/TextArea/TextArea'

const TitleAndDescription = (props) => {
    return (
        <Fragment>
            <TextBox id='entityTitle' dataCol='entityTitle' placeholder='Title'
                        value={props.data.entityTitle} onChange={props.updateData}></TextBox>
            <TextArea id='entityDesc' dataCol='entityDesc' styleName='entity-create' placeholder='Description'
                value={props.data.entityDesc} onChange={props.updateData}></TextArea>        
        </Fragment>
    )
}

export default TitleAndDescription
