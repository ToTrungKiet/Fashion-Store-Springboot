import { useContext } from 'react'
import { ShopContext } from '../context/ShopContext'
import Title from './Title';

const CartTotal = ({ amount }) => {

  const { currency, delivery_fee, getCartAmount, formatPrice } = useContext(ShopContext);
  const cartAmount = amount ?? getCartAmount();

  return (
    <div className='w-full'>
      <div className='text-2xl'>
        <Title text1={'TỔNG'} text2={'ĐƠN HÀNG'} />
      </div>
      <div className='flex flex-col gap-2 mt-2 text-sm'>
        <div className='flex justify-between'>
            <p>TỔNG TIỀN HÀNG</p>
            <p>{formatPrice(cartAmount)} {currency}</p>
        </div>
        <hr />
        <div className='flex justify-between'>
            <p>PHÍ VẬN CHUYỂN</p>
            {cartAmount === 0 ? '0 VND' : <p>{formatPrice(delivery_fee)} {currency}</p>}
        </div>
        <hr />
        <div className='flex justify-between'>
            <b>TỔNG</b>
            <b>{cartAmount === 0 ? 0 : formatPrice(cartAmount + delivery_fee)} {currency}</b>
        </div>
      </div>
    </div>
  )
}

export default CartTotal
