import React from 'react'
import TextBox from '../TextBox/TextBox'
import './CreditCard.css'
// uses styling from Checkout.css

const CreditCard = () => {
    return (
        <div className='credit-card-container'>
            <h2 className='checkout-subheading'>Credit Card:</h2>
            <TextBox id='creditCardNumber' placeholder='Card Number'></TextBox>
            <TextBox id='creditCardName' placeholder='Name on Card'></TextBox>
            <TextBox id='creditCardExp' placeholder='Expiration Date'></TextBox>
            <TextBox id='creditCardSecurityCode' placeholder='Security Code'></TextBox>
        </div>
    )
}

export default CreditCard
