import React from 'react'
import {AppContext} from '../../AppContext'
import cart from '../../assets/images/shopping-cart.png'
import envelope from '../../assets/images/envelope.png'
import event from '../../assets/images/events-black.png'
import './Banner.css'

const Banner = () => {

    const {appContext} = React.useContext(AppContext)

    if (appContext.signedIn && appContext.authState === 'home' && appContext.cartQuantity === 0)
        return (
            <>
                <div className='banner'>
                    <div className='banner-image-container' data-notification-count='2'
                        onClick={()=>{window.location.href='/availability/booking-list'}}>
                        <img className='banner-image' src={event} alt='booking'
                            onClick={()=>{window.location.href='/availability/booking-list'}}></img>
                    </div>
                    <div className='banner-image-container' data-notification-count='12'>
                        <img className='banner-image' src={cart} alt='cart'
                            onClick={()=>{window.location.href='/view-cart'}}></img>
                        {/* {appContext.cartQuantity > 0 &&
                            <div className='quantity-circle'
                                onClick={()=>{window.location.href='/view-cart'}}>
                                {appContext.cartQuantity}
                            </div>} */}
                    </div>
                    <div className='banner-image-container' data-notification-count='99+'
                        onClick={()=>{window.location.href='/messages'}}>
                        <img className='banner-image' src={envelope} alt='envelope'
                            onClick={()=>{window.location.href='/messages'}}></img>
                        {/* <div className='quantity-circle'
                            onClick={()=>{window.location.href='/messages'}}>
                            2
                        </div> */}
                    </div>
                </div>
                <div className='spacer'></div>
            </>
        )
    else return <></>
}

export default Banner
