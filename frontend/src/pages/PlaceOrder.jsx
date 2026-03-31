import { useContext, useEffect, useMemo, useState } from 'react'
import { useLocation } from 'react-router-dom'
import Title from '../components/Title'
import CartTotal from '../components/CartTotal'
import { ShopContext } from '../context/ShopContext'
import { toast } from 'react-toastify'
import axios from 'axios'

const LOCATION_API_BASE = 'https://provinces.open-api.vn/api/v1'

const PlaceOrder = () => {
  const {
    navigate,
    backendUrl,
    token,
    cartItems,
    getCartAmount,
    delivery_fee,
    products,
    parseVariantKey,
    getUserCart
  } = useContext(ShopContext)
  const location = useLocation()

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
  const [provinces, setProvinces] = useState([])
  const [districts, setDistricts] = useState([])
  const [wards, setWards] = useState([])
  const [selectedProvinceCode, setSelectedProvinceCode] = useState('')
  const [selectedDistrictCode, setSelectedDistrictCode] = useState('')
  const [profileLoaded, setProfileLoaded] = useState(false)

  const selectedItemsFromCart = location.state?.selectedItems || null

  const orderItems = useMemo(() => {
    const items = []

    if (selectedItemsFromCart && selectedItemsFromCart.length > 0) {
      selectedItemsFromCart.forEach((selectedItem) => {
        const product = products.find((entry) => entry.id.toString() === selectedItem.productId.toString())

        if (!product) {
          return
        }

        const { size, color } = parseVariantKey(selectedItem.variantKey)
        const itemInfo = structuredClone(product)
        itemInfo.size = size
        itemInfo.color = color
        itemInfo.quantity = selectedItem.quantity
        items.push(itemInfo)
      })

      return items
    }

    for (const itemsKey in cartItems) {
      for (const variantKey in cartItems[itemsKey]) {
        if (cartItems[itemsKey][variantKey] > 0) {
          const { size, color } = parseVariantKey(variantKey)
          const itemInfo = structuredClone(
            products.find((product) => product.id === Number(itemsKey))
          )

          if (itemInfo) {
            itemInfo.size = size
            itemInfo.color = color
            itemInfo.quantity = cartItems[itemsKey][variantKey]
            items.push(itemInfo)
          }
        }
      }
    }

    return items
  }, [cartItems, parseVariantKey, products, selectedItemsFromCart])

  const orderSubtotal = useMemo(
    () => orderItems.reduce((total, item) => total + ((item.price || 0) * (item.quantity || 0)), 0),
    [orderItems]
  )

  const loadProvinces = async () => {
    try {
      const response = await axios.get(LOCATION_API_BASE + '/p/')
      setProvinces(response.data || [])
    } catch (error) {
      console.log(error)
      toast.error('Không thể tải danh sách tỉnh/thành')
    }
  }

  const loadDistricts = async (provinceCode) => {
    if (!provinceCode) {
      setDistricts([])
      setWards([])
      setSelectedDistrictCode('')
      return
    }

    try {
      const response = await axios.get(LOCATION_API_BASE + `/p/${provinceCode}?depth=2`)
      setDistricts(response.data?.districts || [])
    } catch (error) {
      console.log(error)
      toast.error('Không thể tải danh sách quận/huyện')
    }
  }

  const loadWards = async (districtCode) => {
    if (!districtCode) {
      setWards([])
      return
    }

    try {
      const response = await axios.get(LOCATION_API_BASE + `/d/${districtCode}?depth=2`)
      setWards(response.data?.wards || [])
    } catch (error) {
      console.log(error)
      toast.error('Không thể tải danh sách phường/xã')
    }
  }

  const handleProvinceChange = async (e) => {
    const provinceCode = e.target.value
    const province = provinces.find((item) => item.code.toString() === provinceCode)

    setSelectedProvinceCode(provinceCode)
    setSelectedDistrictCode('')
    setFormData((prev) => ({
      ...prev,
      city: province?.name || '',
      district: '',
      ward: ''
    }))
    setWards([])

    await loadDistricts(provinceCode)
  }

  const handleDistrictChange = async (e) => {
    const districtCode = e.target.value
    const district = districts.find((item) => item.code.toString() === districtCode)

    setSelectedDistrictCode(districtCode)
    setFormData((prev) => ({
      ...prev,
      district: district?.name || '',
      ward: ''
    }))

    await loadWards(districtCode)
  }

  const handleWardChange = (e) => {
    const wardCode = e.target.value
    const ward = wards.find((item) => item.code.toString() === wardCode)

    setFormData((prev) => ({
      ...prev,
      ward: ward?.name || ''
    }))
  }

  useEffect(() => {
    loadProvinces()
  }, [])

  useEffect(() => {
    const loadProfile = async () => {
      if (!token) {
        return
      }

      try {
        const response = await axios.post(
          backendUrl + '/api/user/profile',
          {},
          { headers: { token } }
        )

        if (!response.data?.success) {
          return
        }

        const user = response.data.user || {}

        setFormData({
          firstName: user.firstName || '',
          lastName: user.lastName || '',
          email: user.email || '',
          address: user.address || '',
          ward: user.ward || '',
          district: user.district || '',
          city: user.city || '',
          phone: user.phone || ''
        })
        setProfileLoaded(true)
      } catch (error) {
        console.log(error)
      }
    }

    loadProfile()
  }, [backendUrl, token])

  useEffect(() => {
    if (!profileLoaded || provinces.length === 0 || !formData.city) {
      return
    }

    const matchedProvince = provinces.find((item) => item.name === formData.city)

    if (matchedProvince) {
      setSelectedProvinceCode(matchedProvince.code.toString())
      loadDistricts(matchedProvince.code.toString())
    }
  }, [profileLoaded, provinces, formData.city])

  useEffect(() => {
    if (!profileLoaded || districts.length === 0 || !formData.district) {
      return
    }

    const matchedDistrict = districts.find((item) => item.name === formData.district)

    if (matchedDistrict) {
      setSelectedDistrictCode(matchedDistrict.code.toString())
      loadWards(matchedDistrict.code.toString())
    }
  }, [profileLoaded, districts, formData.district])

  const onChangeHandler = (e) => {
    const name = e.target.name
    const value = e.target.value
    setFormData((prev) => ({ ...prev, [name]: value }))
  }

  const onSubmitHandler = async (e) => {
    e.preventDefault()

    try {
      if (orderItems.length === 0) {
        toast.error('Giỏ hàng trống!')
        return
      }

      const orderData = {
        address: formData,
        items: orderItems,
        amount: orderSubtotal + delivery_fee,
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
            await getUserCart(token)
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

        <select
          value={selectedProvinceCode}
          onChange={handleProvinceChange}
          className='border border-gray-300 rounded py-1.5 px-3.5 w-full bg-white'
          required
        >
          <option value=''>Chọn Tỉnh/Thành phố</option>
          {provinces.map((province) => (
            <option key={province.code} value={province.code}>
              {province.name}
            </option>
          ))}
        </select>

        <div className='flex gap-3'>
          <select
            value={selectedDistrictCode}
            onChange={handleDistrictChange}
            className='border border-gray-300 rounded py-1.5 px-3.5 w-full bg-white'
            disabled={!selectedProvinceCode}
            required
          >
            <option value=''>Chọn Quận/Huyện</option>
            {districts.map((district) => (
              <option key={district.code} value={district.code}>
                {district.name}
              </option>
            ))}
          </select>

          <select
            value={wards.find((ward) => ward.name === formData.ward)?.code || ''}
            onChange={handleWardChange}
            className='border border-gray-300 rounded py-1.5 px-3.5 w-full bg-white'
            disabled={!selectedDistrictCode}
            required
          >
            <option value=''>Chọn Phường/Xã</option>
            {wards.map((ward) => (
              <option key={ward.code} value={ward.code}>
                {ward.name}
              </option>
            ))}
          </select>
        </div>

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
          <CartTotal amount={orderSubtotal} />
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
