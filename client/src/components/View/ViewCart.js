import {React, useEffect, useState, useRef, useContext, Fragment} from 'react'
import { AppContext } from '../../AppContext'
import jsonFunctions from '../../shared/jsonFunctions'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import IconButton from '../controls/buttons/IconButton'
import icons from '../../shared/icons'
import './ViewCart.css'
import EntityImage from '../EntityImage/EntityImage'
import EntityCDO from '../../cdos/EntityCDO'
import CartCDO from '../../cdos/CartCDO'
import Modal from '../controls/Modal/Modal'
import AuthFrame from '../AuthFrame/AuthFrame'
const cdo = new EntityCDO()
const cdoCart = new CartCDO()

// uses styling from EntityList.css

const ViewCart = () => {

    const {appContext, setAppContext} = useContext(AppContext)
    const [shoppingCart, setShoppingCart] = useState([])
    const [shoppingCartLoaded, setShoppingCartLoaded] = useState(false)
    const [removalCandidate, setRemovalCandidate] = useState(null)
    const refShoppingCart = useRef([])

    useEffect(() => {

        const cbLoadData = (error, result) => {
            if (!error) {
                let newShoppingCart = result
                setShoppingCart(newShoppingCart)
                refShoppingCart.current = newShoppingCart
                if (result.length > 0) {
                    for (let i=0; i<result.length; i++) {
                        cdo.view({idEntity: result[i].idEntity}, cbLoadEntityData)
                    }
                }
                else window.location.href = '/'
            }       
        }

        const cbLoadEntityData = (error, result) => {
            if (!error) {
                let found = false
                for (let i=0; i<refShoppingCart.current.length && !found; i++) {
                    if (refShoppingCart.current[i].idEntity === result.idEntity) {
                        refShoppingCart.current[i] =
                            jsonFunctions.merge(refShoppingCart.current[i], result)
                        found = true                        
                    }
                }
                setShoppingCart(jsonFunctions.deepCopy(refShoppingCart.current))
            }
            else alert(error)
        }
        if (!shoppingCartLoaded) {
            setShoppingCartLoaded(true)
            if (appContext.idEntity) cdoCart.loadData({idUser: appContext.idEntity}, cbLoadData)     
        }
    }, [shoppingCart, shoppingCartLoaded, appContext.idEntity])

    const incrementQuantity = (item, index) => {
        let newCart = [...shoppingCart]
        newCart[index].quantity++
        setShoppingCart(newCart)
        cdoCart.addData(item, cbChangeCartQuantity)
        let newContext = {...appContext}
        newContext.cartQuantity++
        setAppContext(newContext)
    }

    const decrementQuantity = (item, index) => {
        let newCart = [...shoppingCart]
        if (newCart[index].quantity === 1) setRemovalCandidate(index)
        else {
            newCart[index].quantity--
            setShoppingCart(newCart)
            cdoCart.deleteData(item, cbChangeCartQuantity)
            let newContext = {...appContext}
            newContext.cartQuantity--
            setAppContext(newContext)
        }
    }

    const changeQuantity = (event, index) => {
        let newContext = {...appContext}
        newContext.cartQuantity += event.target.value - shoppingCart[index].quantity
        let newCart = [...shoppingCart]
        newCart[index].quantity = event.target.value
        setAppContext(newContext)
        setShoppingCart(newCart)
        cdoCart.saveData(shoppingCart[index], cbChangeCartQuantity)
    }

    const removeQuantity = () => {
        cdoCart.removeData(shoppingCart[removalCandidate], cbChangeCartQuantity)
        let newContext = {...appContext}
        newContext.cartQuantity -= shoppingCart[removalCandidate].quantity
        let newCart = jsonFunctions.deepCopy(shoppingCart)
        newCart.splice(removalCandidate, 1)
        setAppContext(newContext)
        setRemovalCandidate(null)
        if (newContext.cartQuantity === 0) window.location.href = '/'
        setShoppingCart(newCart)
    }

    const cbChangeCartQuantity = (error, result) => {
        if (error) alert('Error changing cart quantity')
    }

    const sumSubtotal = () => {
        let subtotal = 0
        for (let item of shoppingCart) if (item.offer) subtotal += item.offer.price * item.quantity
        return Intl.NumberFormat('en-US', {style: 'currency', currency: 'USD'}).format(subtotal)
    }

    return (
        <AuthFrame mandatory={true}>
            <ContentContainer>
                <Card cardHeading='Shopping Cart'>
                    <div className='cart-contents entity-list-container four-columns'>
                        {shoppingCart && shoppingCart.map((item, index) => {
                            return (
                                <Fragment key={item.idEntity}>
                                    <EntityImage styleName='entity-list' idEntity={item.idEntity}
                                        entityType = {item.entityType} size='xx-small' 
                                        onClick={()=>window.location.href = "/view/" + item.idEntity}>
                                    </EntityImage>
                                    <a className='entity-list-entity-title cart-title'
                                        href={'/view/' + item.idEntity}>{item.entityTitle}</a>
                                    {item.offer && 
                                        <Fragment>
                                            <span className='unit-price-label'>Unit price: </span>
                                            <span className='unit-price'>
                                                {Intl.NumberFormat('en-US', {style: 'currency', currency: 'USD'})
                                                    .format(item.offer.price)}</span>
                                        </Fragment>}
                                    <span className='quantity-label'>Quantity: </span>
                                    <div className='quantity-block'>
                                        <IconButton src={icons.downBlueIcon} styleName='no-caption quantity-increment'
                                            onClick={()=>decrementQuantity(item, index)}></IconButton>
                                        <input type='text' className='quantity-box' value={item.quantity} 
                                            onChange={(event)=>changeQuantity(event,index)}></input>
                                        <IconButton src={icons.upBlueIcon} styleName='no-caption quantity-increment'
                                            onClick={()=>incrementQuantity(item, index)}></IconButton>
                                    </div>
                                    <IconButton styleName='delete-button delete-item' src={icons.deleteIcon}
                                        caption='Remove' onClick={()=>setRemovalCandidate(index)}></IconButton>
                                    <div className='cart-spacer'></div>
                                </Fragment>
                            )
                        })}
                    </div>
                    <div className='cart-subtotal'>Subtotal: {sumSubtotal()}</div>
                    <IconButton styleName='proceed-checkout edit-button' src={icons.checkIcon}
                        caption='Proceed to checkout' onClick={()=>{window.location.href='/checkout'}}></IconButton>
                    {removalCandidate !== null &&
                        <Modal buttonText='Yes' onClick={removeQuantity}
                            buttonTwoText='No' onClickTwo={()=>setRemovalCandidate(null)}>
                            <div className='modal-text'>Remove <span className='remove-modal-title'>
                                {shoppingCart[removalCandidate].entityTitle + ' '}</span>from the shopping cart?
                            </div>
                        </Modal>}
                </Card>
            </ContentContainer>            
        </AuthFrame>
    )
}

export default ViewCart
