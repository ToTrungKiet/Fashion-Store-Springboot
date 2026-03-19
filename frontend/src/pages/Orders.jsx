import { useContext, useEffect, useState } from 'react'
import { useLocation } from 'react-router-dom'
import { toast } from 'react-toastify'
import axios from 'axios'
import { ShopContext } from '../context/ShopContext'
import Title from '../components/Title'

const Orders = () => {
  const { backendUrl, token, currency, formatPrice, getUserCart } = useContext(ShopContext)
  const location = useLocation()
  const [orders, setOrders] = useState([])

  const loadOrderData = async () => {
    try {
      if (!token) {
        return
      }

      const response = await axios.post(
        backendUrl + '/api/order/user-orders',
        {},
        { headers: { token } }
      )

      if (!response.data.success) {
        setOrders([])
        return
      }

      const normalizedOrders = (response.data.orders || []).map((order) => ({
        ...order,
        parsedItems: JSON.parse(order.items || '[]')
      }))

      setOrders(normalizedOrders.reverse())
    } catch (error) {
      console.log(error)
      toast.error('Không thể tải đơn hàng')
    }
  }

  const retryVnPayPayment = async (orderId) => {
    try {
      const response = await axios.post(
        backendUrl + '/api/payment/create-vnpay',
        { orderId },
        { headers: { token } }
      )

      if (!response.data?.success) {
        toast.error(response.data?.message || 'Không thể tạo lại thanh toán VNPAY')
        return
      }

      window.location.href = response.data.paymentUrl
    } catch (error) {
      console.log(error)
      toast.error(error.response?.data?.message || 'Không thể tạo lại thanh toán VNPAY')
    }
  }

  useEffect(() => {
    loadOrderData()
  }, [token])

  useEffect(() => {
    const params = new URLSearchParams(location.search)
    const paymentStatus = params.get('payment')

    if (!paymentStatus) {
      return
    }

    if (paymentStatus === 'success') {
      toast.success('Thanh toán VNPAY thành công')
      getUserCart(token)
    } else if (paymentStatus === 'failed') {
      toast.error('Thanh toán VNPAY thất bại. Bạn có thể thanh toán lại trong đơn hàng.')
    } else if (paymentStatus === 'error') {
      toast.error('Có lỗi xảy ra khi xử lý kết quả thanh toán VNPAY')
    } else if (paymentStatus === 'notfound') {
      toast.error('Không tìm thấy đơn hàng cần thanh toán')
    }

    loadOrderData()
  }, [location.search, token])

  return (
    <div className='border-t pt-16'>
      <div className='text-2xl'>
        <Title text1={'ĐƠN HÀNG'} text2={'CỦA TÔI'} />
      </div>
      <div>
        {orders.length > 0 ? (
          orders.map((order) => {
            const canRetryVnPay = order.paymentMethod === 'vnpay' && !order.payment

            return (
              <div key={order.id} className='py-5 border-b text-gray-700'>
                <div className='flex flex-col gap-2 md:flex-row md:items-center md:justify-between'>
                  <div className='text-sm'>
                    <p>Mã đơn: <span className='text-gray-500'>#{order.id}</span></p>
                    <p>Ngày đặt: <span className='text-gray-500'>{new Date(order.createdAt).toLocaleDateString('vi-VN')}</span></p>
                    <p>Phương thức thanh toán: <span className='text-gray-500 uppercase'>{order.paymentMethod}</span></p>
                    <p>Thanh toán: <span className='text-gray-500'>{order.payment ? 'Đã thanh toán' : 'Chưa thanh toán'}</span></p>
                  </div>
                  <div className='flex items-center gap-3'>
                    <div className='flex items-center gap-2'>
                      <p className={`min-w-2 h-2 rounded-full ${order.payment ? 'bg-green-500' : 'bg-amber-500'}`}></p>
                      <p className='text-sm md:text-base'>{order.status}</p>
                    </div>
                    {canRetryVnPay && (
                      <button
                        onClick={() => retryVnPayPayment(order.id)}
                        className='bg-rose-500 hover:bg-rose-600 text-white px-4 py-2 text-sm rounded-sm'
                      >
                        Thanh toán lại
                      </button>
                    )}
                  </div>
                </div>

                <div className='mt-4 flex flex-col gap-4'>
                  {order.parsedItems.map((item, index) => (
                    <div key={`${order.id}-${index}`} className='flex items-start gap-6 text-sm'>
                      <img className='w-16 sm:w-20' src={item.image[0]} alt='' />
                      <div>
                        <p className='sm:text-base font-medium'>{item.name}</p>
                        <div className='flex flex-wrap items-center gap-3 mt-2 text-base text-gray-700'>
                          <p className='text-lg'>{formatPrice(item.price)} {currency}</p>
                          <p>Số lượng: {item.quantity}</p>
                          <p>Kích cỡ: {item.size}</p>
                          <p>Màu: {item.color}</p>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )
          })
        ) : (
          <p className='text-center text-gray-500 py-8 text-2xl'>KHÔNG CÓ ĐƠN HÀNG NÀO</p>
        )}
      </div>
    </div>
  )
}

export default Orders
