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

  const formatOrderDate = (date) => new Date(date).toLocaleDateString('vi-VN')

  const getPaymentLabel = (paymentMethod) => {
    if (paymentMethod === 'cod') {
      return 'COD'
    }

    if (paymentMethod === 'vnpay') {
      return 'VNPAY'
    }

    return (paymentMethod || '').toUpperCase()
  }

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
              <div key={order.id} className='border-b py-4 text-gray-700'>
                <div className='flex flex-col gap-4'>
                  {order.parsedItems.map((item, index) => (
                    <div
                      key={`${order.id}-${index}`}
                      className='grid grid-cols-1 gap-4 text-sm lg:grid-cols-[minmax(0,1.8fr)_minmax(180px,0.9fr)_auto] lg:items-center'
                    >
                      <div className='flex items-start gap-4'>
                        <img className='w-16 sm:w-20 shrink-0' src={item.image[0]} alt={item.name} />
                        <div className='min-w-0'>
                          <p className='sm:text-base font-medium text-gray-800'>{item.name}</p>
                          <div className='mt-2 flex flex-wrap items-center gap-x-3 gap-y-1 text-sm sm:text-base text-gray-700'>
                            <p>{formatPrice(item.price)} {currency}</p>
                            <p>Số lượng: {item.quantity}</p>
                            <p>Kích cỡ: {item.size}</p>
                            <p>Màu: {item.color}</p>
                          </div>
                          <div className='mt-2 space-y-1 text-xs sm:text-sm text-gray-500'>
                            <p>Ngày: {formatOrderDate(order.createdAt)}</p>
                            <p>Phương thức thanh toán: {getPaymentLabel(order.paymentMethod)}</p>
                            <p>
                              Trạng thái thanh toán:{' '}
                              <span className={order.payment ? 'text-green-600' : 'text-orange-500'}>
                                {order.payment ? 'Đã thanh toán' : 'Chưa thanh toán'}
                              </span>
                            </p>
                          </div>
                        </div>
                      </div>

                      <div className='flex items-center gap-2 text-sm sm:text-base text-gray-600 lg:justify-center'>
                        <span className='h-2 w-2 rounded-full bg-indigo-400'></span>
                        <p>{order.status}</p>
                      </div>

                      <div className='flex lg:justify-end'>
                        {canRetryVnPay ? (
                          <button
                            onClick={() => retryVnPayPayment(order.id)}
                            className='border border-rose-500 bg-rose-500 px-4 py-2 text-sm font-medium text-white transition hover:bg-rose-600'
                          >
                            Thanh toán lại
                          </button>
                        ) : (
                          <button
                            onClick={loadOrderData}
                            className='border border-gray-300 px-4 py-2 text-sm font-medium text-gray-700 transition hover:bg-gray-50'
                          >
                            Theo dõi đơn hàng
                          </button>
                        )}
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
