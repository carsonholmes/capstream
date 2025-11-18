import React, { useState } from 'react'
import EntityCDO from '../../cdos/EntityCDO'
import ServiceRateAndPayment from './ServiceRateAndPayment'
import MaintainTitle from './MaintainTitle'
import ServiceLocation from './ServiceLocation'

const cdo = new EntityCDO()

const  CreateService = (props) => {

    const [createStep, setCreateStep] = useState(1)
    
    const updateData = (dataCol, newValue) => {
        let newData = {...props.data}
        newData[dataCol] = newValue
        props.updateData(dataCol, newValue)
    }

    const updateRate = (rateData) => {
        var newData = {...props.data}
        newData.rate = {...rateData}
        props.setData(newData)
    }

    const updateOffer = (offerData) => {
        var newData = {...props.data}
        newData.offer = {...offerData}
        props.setData(newData)
    }

    const validateSave = () => {
        props.saveData()
        props.setCreate(false)
    }

    const handleNext = () => {
        props.saveData()
        setCreateStep(prevCreateStep => prevCreateStep + 1)
    }

    const handleBack = () => {
        props.saveData()
        setCreateStep(prevCreateStep => prevCreateStep - 1)
    }

    const handleClose = () => {
        if (props.data.entityTitle.length > 0) props.saveData()
        props.setCreate(false)
    }

    if (createStep === 1) {
        return (
            <MaintainTitle data={props.data} action='Create'
                saveData={props.saveData} updateData={updateData}
                handleClose={handleClose} dirty={props.dirty}
                handleNext={handleNext}>
            </MaintainTitle>
        )
    }
    else if (createStep === 2) {
        return (
            <ServiceRateAndPayment data={props.data.rate} updateData={updateRate}
                action='Create' saveData={props.saveData}
                handleBack={handleBack} validateSave={validateSave}
                handleNext={handleNext}>
            </ServiceRateAndPayment>
        )
    }
    else if (createStep === 3) {
        return (
            <ServiceLocation data={props.data.offer} updateData={updateOffer}
                action='Create' saveData={props.saveData}
                handleBack={handleBack} validateSave={validateSave}>
            </ServiceLocation>
        )
    }
}

export default CreateService