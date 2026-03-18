import { useContext, useState } from 'react'
import Title from '../components/Title'
import CartTotal from '../components/CartTotal'
import { ShopContext } from '../context/ShopContext'
import { toast } from 'react-toastify'
import axios from 'axios'

const PlaceOrder = () => {
  const {
    navigate,
    backendUrl,
    token,
    cartItems,
    setCartItems,
    getCartAmount,
    delivery_fee,
    products,
    parseVariantKey
  } = useContext(ShopContext)

  const [method, setMethod] = useState('cod')

  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    address: '',
    ward: '',
    district: '',
    city: '',
    phone: ''
  })

  const onChangeHandler = (e) => {
    const name = e.target.name
    const value = e.target.value
    setFormData((prev) => ({ ...prev, [name]: value }))
  }

  const onSubmitHandler = async (e) => {
    e.preventDefault()

    try {
      let orderItems = []

      for (const items in cartItems) {
        for (const item in cartItems[items]) {
          if (cartItems[items][item] > 0) {
            const { size, color } = parseVariantKey(item)
            const itemInfo = structuredClone(
              products.find((product) => product.id === Number(items))
            )

            if (itemInfo) {
              itemInfo.size = size
              itemInfo.color = color
              itemInfo.quantity = cartItems[items][item]
              orderItems.push(itemInfo)
            }
          }
        }
      }

      if (orderItems.length === 0) {
        toast.error('Giỏ hàng trống!')
        return
      }

      const orderData = {
        address: formData,
        items: orderItems,
        amount: getCartAmount() + delivery_fee,
        paymentMethod: method
      }

      switch (method) {
        case 'cod': {
          const codResponse = await axios.post(
            backendUrl + '/api/order/place',
            orderData,
            { headers: { token } }
          )

          if (codResponse.data.success) {
            setCartItems({})
            toast.success(codResponse.data.message)
            navigate('/orders')
          } else {
            toast.error(codResponse.data.message)
          }
          break
        }

        case 'vnpay': {
          const orderRes = await axios.post(
            backendUrl + '/api/order/place',
            orderData,
            { headers: { token } }
          )

          if (!orderRes.data.success) {
            toast.error(orderRes.data.message)
            return
          }

          const paymentRes = await axios.post(
            backendUrl + '/api/payment/create-vnpay',
            { orderId: orderRes.data.orderId },
            { headers: { token } }
          )

          if (paymentRes.data.success) {
            window.location.href = paymentRes.data.paymentUrl
          } else {
            toast.error(paymentRes.data.message)
          }
          break
        }

        default:
          toast.error('Phương thức thanh toán chưa hỗ trợ')
          break
      }
    } catch (error) {
      console.log('FULL ERROR:', error)
      console.log('ERROR RESPONSE:', error.response)
      console.log('ERROR DATA:', error.response?.data)
      console.log('ERROR STATUS:', error.response?.status)
    
      toast.error(
        error.response?.data?.message ||
        error.response?.data?.error ||
        `Lỗi: ${error.response?.status || 'không xác định'}`
      )
    }
  }

  return (
    <form
      onSubmit={onSubmitHandler}
      className='flex flex-col sm:flex-row justify-between gap-4 pt-5 sm:pt-14 min-h-[80vh] border-t'
    >
      {/* BÊN TRÁI */}
      <div className='flex flex-col gap-4 w-full sm:max-w-[480px]'>
        <div className='text-xl sm:text-2xl my-3'>
          <Title text1={'THÔNG TIN'} text2={'GIAO HÀNG'} />
        </div>

        <div className='flex gap-3'>
          <input
            onChange={onChangeHandler}
            name='firstName'
            value={formData.firstName}
            className='border border-gray-300 rounded py-1.5 px-3.5 w-full'
            type='text'
            placeholder='Họ'
            required
          />
          <input
            onChange={onChangeHandler}
            name='lastName'
            value={formData.lastName}
            className='border border-gray-300 rounded py-1.5 px-3.5 w-full'
            type='text'
            placeholder='Tên'
            required
          />
        </div>

        <input
          onChange={onChangeHandler}
          name='email'
          value={formData.email}
          className='border border-gray-300 rounded py-1.5 px-3.5 w-full'
          type='email'
          placeholder='Email'
          required
        />

        <input
          onChange={onChangeHandler}
          name='address'
          value={formData.address}
          className='border border-gray-300 rounded py-1.5 px-3.5 w-full'
          type='text'
          placeholder='Số nhà, tên đường'
          required
        />

        <div className='flex gap-3'>
          <input
            onChange={onChangeHandler}
            name='ward'
            value={formData.ward}
            className='border border-gray-300 rounded py-1.5 px-3.5 w-full'
            type='text'
            placeholder='Phường/Xã'
            required
          />
          <input
            onChange={onChangeHandler}
            name='district'
            value={formData.district}
            className='border border-gray-300 rounded py-1.5 px-3.5 w-full'
            type='text'
            placeholder='Quận/Huyện'
            required
          />
        </div>

        <input
          onChange={onChangeHandler}
          name='city'
          value={formData.city}
          className='border border-gray-300 rounded py-1.5 px-3.5 w-full'
          type='text'
          placeholder='Tỉnh/Thành phố'
          required
        />

        <input
          onChange={onChangeHandler}
          name='phone'
          value={formData.phone}
          className='border border-gray-300 rounded py-1.5 px-3.5 w-full'
          type='tel'
          placeholder='Số điện thoại'
          pattern='0[0-9]{9}'
          required
        />
      </div>

      {/* BÊN PHẢI */}
      <div className='mt-8'>
        <div className='mt-8 min-w-80'>
          <CartTotal />
        </div>

        <div className='mt-12'>
          <Title text1={'PHƯƠNG THỨC'} text2={'THANH TOÁN'} />

          {/* CHỌN PHƯƠNG THỨC THANH TOÁN */}
          <div className='flex gap-3 flex-col lg:flex-row'>
            <div
              onClick={() => setMethod('vnpay')}
              className='flex items-center gap-3 border p-2 px-3 cursor-pointer'
            >
              <p
                className={`min-w-3.5 h-3.5 border rounded-full ${
                  method === 'vnpay' ? 'bg-red-500' : ''
                }`}
              ></p>
              <p className='text-gray-500 text-sm font-medium mx-4'>VNPAY</p>
            </div>

            <div
              onClick={() => setMethod('cod')}
              className='flex items-center gap-3 border p-2 px-3 cursor-pointer'
            >
              <p
                className={`min-w-3.5 h-3.5 border rounded-full ${
                  method === 'cod' ? 'bg-red-500' : ''
                }`}
              ></p>
              <p className='text-gray-500 text-sm font-medium mx-4'>COD</p>
            </div>
          </div>

          <div className='w-full text-end mt-8'>
            <button
              type='submit'
              className='bg-rose-500 hover:bg-rose-600 rounded-full text-white px-16 py-3 text-sm active:bg-rose-700 cursor-pointer'
            >
              ĐẶT HÀNG
            </button>
          </div>
        </div>
      </div>
    </form>
  )
}

export default PlaceOrder
