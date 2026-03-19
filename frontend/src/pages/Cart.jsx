import { useContext, useEffect, useMemo, useState } from 'react'
import { ShopContext } from '../context/ShopContext'
import Title from '../components/Title'
import { assets } from '../assets/assets'
import CartTotal from '../components/CartTotal'

const Cart = () => {
  const { products, currency, cartItems, updateQuantity, formatPrice, navigate, parseVariantKey, delivery_fee } = useContext(ShopContext)
  const [selectedItems, setSelectedItems] = useState({})

  const cartData = useMemo(() => {
    const tempData = []

    for (const productId in cartItems) {
      for (const variantKey in cartItems[productId]) {
        if (cartItems[productId][variantKey] > 0) {
          const productData = products.find((product) => product.id.toString() === productId.toString())

          if (!productData) {
            continue
          }

          const { size, color } = parseVariantKey(variantKey)
          tempData.push({
            key: `${productId}__${variantKey}`,
            productId,
            variantKey,
            size,
            color,
            quantity: cartItems[productId][variantKey],
            product: productData
          })
        }
      }
    }

    return tempData
  }, [cartItems, products, parseVariantKey])

  useEffect(() => {
    setSelectedItems((prev) => {
      const next = {}

      cartData.forEach((item) => {
        if (prev[item.key]) {
          next[item.key] = true
        }
      })

      return next
    })
  }, [cartData])

  const getVariantStock = (product, size, color) => {
    if (!product?.inventory) {
      return 0
    }

    return product.inventory[`${size}__${color}`] || 0
  }

  const selectedCartData = cartData.filter((item) => selectedItems[item.key])
  const isAllSelected = cartData.length > 0 && selectedCartData.length === cartData.length

  const selectedSubtotal = selectedCartData.reduce(
    (total, item) => total + item.product.price * item.quantity,
    0
  )

  const selectedTotal = selectedSubtotal === 0 ? 0 : selectedSubtotal + delivery_fee

  const toggleSelectAll = () => {
    if (isAllSelected) {
      setSelectedItems({})
      return
    }

    const next = {}
    cartData.forEach((item) => {
      next[item.key] = true
    })
    setSelectedItems(next)
  }

  const toggleSelectItem = (key) => {
    setSelectedItems((prev) => ({
      ...prev,
      [key]: !prev[key]
    }))
  }

  const deleteSelectedItems = async () => {
    if (selectedCartData.length === 0) {
      return
    }

    for (const item of selectedCartData) {
      await updateQuantity(item.productId.toString(), item.size, item.color, 0)
    }

    setSelectedItems({})
  }

  const checkoutSelectedItems = () => {
    if (selectedCartData.length === 0) {
      return
    }

    navigate('/place-order', {
      state: {
        selectedItems: selectedCartData.map((item) => ({
          productId: item.productId,
          variantKey: item.variantKey,
          quantity: item.quantity
        }))
      }
    })
  }

  return (
    <div className='border-t pt-14'>
      <div className='text-2xl mb-3'>
        <Title text1={'KIỂM TRA'} text2={'ĐƠN HÀNG'} />
      </div>

      {cartData.length > 0 && (
        <div className='mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between'>
          <label className='flex items-center gap-2 text-sm text-gray-700'>
            <input type='checkbox' checked={isAllSelected} onChange={toggleSelectAll} />
            Chọn tất cả
          </label>
          <div className='flex flex-wrap gap-3'>
            <button
              onClick={deleteSelectedItems}
              disabled={selectedCartData.length === 0}
              className='border border-gray-300 px-4 py-2 text-sm rounded-sm disabled:opacity-50'
            >
              Xóa đã chọn
            </button>
            <button
              onClick={checkoutSelectedItems}
              disabled={selectedCartData.length === 0}
              className='bg-rose-500 hover:bg-rose-600 text-white px-4 py-2 text-sm rounded-sm disabled:opacity-50'
            >
              Thanh toán đã chọn
            </button>
          </div>
        </div>
      )}

      <div>
        {cartData.map((item) => {
          const availableStock = getVariantStock(item.product, item.size, item.color)

          return (
            <div key={item.key} className='py-4 border-t border-b text-gray-700 grid grid-cols-[auto_4fr_0.8fr_0.5fr] sm:grid-cols-[auto_4fr_2fr_0.5fr] items-center gap-4'>
              <input
                type='checkbox'
                checked={Boolean(selectedItems[item.key])}
                onChange={() => toggleSelectItem(item.key)}
                className='mt-1'
              />
              <div className='flex items-start gap-6'>
                <img className='w-16 sm:w-20' src={item.product.image[0]} alt='' />
                <div>
                  <p className='text-xs sm:text-lg font-medium'>{item.product.name}</p>
                  <div className='flex items-center gap-5 mt-2'>
                    <p>{formatPrice(item.product.price)} {currency}</p>
                    <p className='px-2 sm:px-3 sm:py-1 border bg-slate-50'>{item.size}</p>
                    <p className='px-2 sm:px-3 sm:py-1 border bg-slate-50'>{item.color}</p>
                  </div>
                  <p className='mt-2 text-sm text-gray-500'>Còn lại trong kho: {availableStock}</p>
                </div>
              </div>
              <input
                onChange={(e) => e.target.value === '' || e.target.value === '0' ? null : updateQuantity(item.productId.toString(), item.size, item.color, Number(e.target.value))}
                className='border max-w-10 sm:max-w-20 px-1 sm:px-2 py-1'
                type='number'
                min={1}
                max={availableStock}
                value={item.quantity}
              />
              <img onClick={() => updateQuantity(item.productId.toString(), item.size, item.color, 0)} className='w-4 mr-4 sm:w-5 cursor-pointer' src={assets.bin_icon} alt='' />
            </div>
          )
        })}
      </div>

      <div className='flex justify-end my-20'>
        <div className='w-full sm:w-[450px]'>
          <CartTotal />
          <div className='mt-4 rounded border border-gray-200 p-4 text-sm text-gray-700'>
            <div className='flex justify-between'>
              <span>Tạm tính đã chọn</span>
              <span>{formatPrice(selectedSubtotal)} {currency}</span>
            </div>
            <div className='flex justify-between mt-2'>
              <span>Tổng đã chọn</span>
              <span>{selectedTotal === 0 ? 0 : formatPrice(selectedTotal)} {currency}</span>
            </div>
          </div>
          <div className='w-full text-end'>
            <button
              onClick={checkoutSelectedItems}
              disabled={selectedCartData.length === 0}
              className='bg-rose-500 hover:bg-rose-600 text-white rounded-full my-8 px-8 py-3 text-sm active:bg-rose-700 disabled:opacity-50'
            >
              THANH TOÁN ĐÃ CHỌN
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}

export default Cart
