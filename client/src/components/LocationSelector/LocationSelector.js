import React, {useEffect, useState} from 'react'

const URL = 'https://ip.nf/me.json'

const LocationSelector = (props) => {

    const [locationInfo, setLocationInfo] = useState({ip : {}})

    useEffect(() => {
        fetch(URL, { method: 'get' })
            .then((response)=>response.json())
            .then((data)=> { setLocationInfo({...data})})
    })

    // if (navigator.geolocation) { // device can return its location
    //     navigator.geolocation.getCurrentPosition(function(position) {
    //          console.log(position.coords.latitude);
    //          console.log(position.coords.longitude);
    //     });
    // }

    return (
        <div>
            <br/>IP: {locationInfo.ip.ip}
            <br/>Country: {locationInfo.ip.country}
            <br/>Country Code: {locationInfo.ip.country_code}
            <br/>City: {locationInfo.ip.city}
            <br/>Latitude: {locationInfo.ip.latitude}
            <br/>Longitude: {locationInfo.ip.longitude}
        </div>
    )
}

export default LocationSelector
