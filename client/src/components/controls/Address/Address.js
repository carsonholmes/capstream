import React, {useEffect, useState, useRef} from 'react'
import './Address.css'
import TextBox from '../TextBox/TextBox'
import Button from '../buttons/Button'
import Select from '../Select/Select'
import LocationCDO from '../../../cdos/LocationCDO'
const cdo = new LocationCDO()
// uses styling from Checkout1.css

const Address = (props) => {

    const [shippingAddress, setShippingAddress] = useState(cdo.getEmptyRow())
    const provinceOrState = useRef('State')
    const [zipOrPostal, setZipOrPostal] = useState('Zip Code')
    const [countryArray, setCountryArray] = useState([])
    const [provinceArray, setProvinceArray] = useState([{caption: '', value: -1}])


    useEffect(() => {
        const cbLoadCountries = (error, data) => {
            let newArray = [{caption: '', value: -1}]
            if (!error) {
                for (let country of data) newArray.push({caption: country.name, value: country.idCountry})
                setCountryArray(newArray)
            }
        } 
        cdo.loadCountries(cbLoadCountries)
    }, [])

    const cbLoadProvinces = (error, data) => {
        let newArray = [{caption: '', value: -1}]
        if (!error) {
            for (let province of data) newArray.push({caption: province.name, value: province.idProvince})
            setProvinceArray(newArray)
        }
    }

    const updateShippingData = (dataCol, value) => {
        let newShippingAddress = {...shippingAddress}
        newShippingAddress[dataCol] = value
        if (dataCol === 'idCountry') {
            if (parseInt(value) === 231) {
                provinceOrState.current = 'State'
                setZipOrPostal('Zip Code')
            }
            else {
                provinceOrState.current = 'Province'
                setZipOrPostal('Postal Code')
            }
            cdo.loadProvinces({idCountry: value}, cbLoadProvinces)
            newShippingAddress.idProvince = -1
        }
        setShippingAddress(newShippingAddress)
        var newCheckoutData = {...props.checkoutData}
        newCheckoutData[props.dataCol] = newShippingAddress
        props.setCheckoutData(newCheckoutData)
    }
    return (
        <div className='address-container'>
            <h2 className='checkout-subheading'>{props.addressHeading}</h2>
            {props.addressHeading === 'Shipping Address:' &&
                <TextBox id='name' placeholder='Recipient Name' dataCol='name'></TextBox>}
            {props.addressHeading === 'Billing Address:' &&
                <Button styleName='primary fit-content'>Same as shipping address</Button>}
            <Select id='countrySelect' dataCol='idCountry' data={countryArray} label='Country'
                value={shippingAddress.idCountry} onChange={updateShippingData}></Select>
            <TextBox id='addressLine1' placeholder='Address - line 1' dataCol='addressLine1'
                onChange={updateShippingData} value={shippingAddress.addressLine1}></TextBox>
            <TextBox id='addressLine2' placeholder='Address - line 2' dataCol='addressLine2'
                onChange={updateShippingData} value={shippingAddress.addressLine2}></TextBox>
            <TextBox id='city' placeholder='City' dataCol='city'
                onChange={updateShippingData} value={shippingAddress.city}></TextBox>
            <Select id='provinceSelect' dataCol='idProvince' data={provinceArray} label={provinceOrState.current}
                value={shippingAddress.idProvince} onChange={updateShippingData}></Select>
            <TextBox id='postalCode' placeholder={zipOrPostal} dataCol='postalCode'
                onChange={updateShippingData} value={shippingAddress.postalCode}></TextBox>
        </div>
    )
}

export default Address
