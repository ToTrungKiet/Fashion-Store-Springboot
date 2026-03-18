import { useEffect, useMemo, useState } from 'react'
import axios from 'axios'
import { backendUrl, currency, formatPrice } from '../App.jsx'
import { toast } from 'react-toastify'

const LOW_STOCK_THRESHOLD = 20

const Inventory = ({ token }) => {
  const [products, setProducts] = useState([])
  const [topSelling, setTopSelling] = useState([])
  const [expandedProductId, setExpandedProductId] = useState(null)
  const [inventoryDrafts, setInventoryDrafts] = useState({})
  const [savingProductId, setSavingProductId] = useState(null)
  const [activeTab, setActiveTab] = useState('inventory')
  const [search, setSearch] = useState('')

  const getTotalStock = (inventory = {}) =>
    Object.values(inventory).reduce((sum, quantity) => sum + (quantity || 0), 0)

  const getInventoryBadgeClass = (totalStock) =>
    totalStock < LOW_STOCK_THRESHOLD
      ? 'border-red-200 bg-red-50'
      : 'border-emerald-200 bg-emerald-50'

  const sortVariants = (inventory = {}) =>
    Object.entries(inventory).sort(([variantA], [variantB]) => variantA.localeCompare(variantB, 'vi'))

  const fetchInventoryData = async () => {
    try {
      const productsRes = await axios.get(backendUrl + '/api/product/list')
      const ordersRes = await axios.post(backendUrl + '/api/order/list', {}, { headers: { token } })

      if (!productsRes.data.success) {
        toast.error(productsRes.data.message)
        return
      }

      const productList = productsRes.data.products || []
      setProducts(productList)
      setInventoryDrafts(
        productList.reduce((acc, product) => {
          acc[product.id] = { ...(product.inventory || {}) }
          return acc
        }, {})
      )

      if (ordersRes.data.success) {
        const salesMap = {}

        ;(ordersRes.data.orders || []).forEach((order) => {
          const items = JSON.parse(order.items || '[]')
          items.forEach((item) => {
            const productId = Number(item.id)
            salesMap[productId] = (salesMap[productId] || 0) + (item.quantity || 0)
          })
        })

        const ranking = productList
          .map((product) => ({
            ...product,
            soldCount: salesMap[product.id] || 0,
            totalStock: getTotalStock(product.inventory)
          }))
          .sort((a, b) => b.soldCount - a.soldCount)

        setTopSelling(ranking)
      }
    } catch (error) {
      console.log(error)
      toast.error('Không thể tải dữ liệu kho hàng')
    }
  }

  useEffect(() => {
    if (token) {
      fetchInventoryData()
    }
  }, [token])

  const updateDraftValue = (productId, variant, value) => {
    const numericValue = Number(value)
    setInventoryDrafts((prev) => ({
      ...prev,
      [productId]: {
        ...(prev[productId] || {}),
        [variant]: Number.isNaN(numericValue) ? 0 : Math.max(numericValue, 0)
      }
    }))
  }

  const saveInventory = async (productId) => {
    try {
      setSavingProductId(productId)
      const response = await axios.post(
        backendUrl + '/api/product/update-inventory',
        {
          productId,
          inventory: inventoryDrafts[productId] || {}
        },
        { headers: { token } }
      )

      if (response.data.success) {
        toast.success(response.data.message)
        await fetchInventoryData()
      } else {
        toast.error(response.data.message)
      }
    } catch (error) {
      console.log(error)
      toast.error('Không thể cập nhật tồn kho')
    } finally {
      setSavingProductId(null)
    }
  }

  const filteredProducts = useMemo(() => {
    const keyword = search.trim().toLowerCase()
    return products
      .map((product) => ({ ...product, totalStock: getTotalStock(product.inventory) }))
      .filter((product) => product.name.toLowerCase().includes(keyword))
  }, [products, search])

  const lowStockCount = filteredProducts.filter((product) => product.totalStock < LOW_STOCK_THRESHOLD).length

  return (
    <div className='flex flex-col gap-6'>
      <div>
        <h1 className='text-3xl font-bold text-gray-800'>Quản Lý Kho Hàng</h1>
      </div>

      <div className='flex flex-wrap gap-3 rounded-2xl bg-slate-100 p-2 w-fit shadow-sm border border-slate-300'>
        <button
          onClick={() => setActiveTab('inventory')}
          className={`px-5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-200 ${
            activeTab === 'inventory'
              ? 'bg-red-500 text-white border border-red-600 shadow-lg'
              : 'bg-white text-black border border-slate-400 hover:bg-slate-50'
          }`}
        >
          Tồn Kho ({filteredProducts.length})
        </button>
        <button
          onClick={() => setActiveTab('top-selling')}
          className={`px-5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-200 ${
            activeTab === 'top-selling'
              ? 'bg-red-500 text-white border border-red-600 shadow-lg'
              : 'bg-white text-black border border-slate-400 hover:bg-slate-50'
          }`}
        >
          Sản Phẩm Bán Chạy
        </button>
      </div>

      {activeTab === 'inventory' && (
        <>
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            type='text'
            placeholder='Tìm kiếm sản phẩm...'
            className='w-full border rounded px-4 py-3'
          />

          {lowStockCount > 0 && (
            <div className='rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-600'>
              Có {lowStockCount} sản phẩm đang có tổng tồn kho dưới {LOW_STOCK_THRESHOLD}.
            </div>
          )}

          <div className='flex flex-col gap-3'>
            {filteredProducts.map((product) => {
              const isExpanded = expandedProductId === product.id
              const totalStock = product.totalStock
              const variants = sortVariants(inventoryDrafts[product.id] || {})

              return (
                <div
                  key={product.id}
                  className={`rounded-xl border ${getInventoryBadgeClass(totalStock)} overflow-hidden`}
                >
                  <button
                    type='button'
                    onClick={() => setExpandedProductId(isExpanded ? null : product.id)}
                    className='w-full text-left px-4 py-4 flex items-center justify-between gap-4'
                  >
                    <div>
                      <p className='text-lg font-semibold text-gray-800'>{product.name}</p>
                      <p className='text-sm text-gray-500'>{formatPrice(product.price)} {currency}</p>
                    </div>

                    <div className='flex items-center gap-4'>
                      <div className='text-right'>
                        <p className={`text-3xl font-bold ${totalStock < LOW_STOCK_THRESHOLD ? 'text-red-500' : 'text-gray-700'}`}>
                          {totalStock}
                        </p>
                        <p className='text-xs text-gray-500'>sản phẩm</p>
                        <p className='text-xs text-gray-400'>Tất cả size</p>
                      </div>
                      <span className='text-2xl text-gray-500'>{isExpanded ? '▼' : '▶'}</span>
                    </div>
                  </button>

                  {isExpanded && (
                    <div className='border-t border-emerald-200 bg-white/50 px-4 py-4'>
                      <div className='grid grid-cols-1 xl:grid-cols-2 gap-3'>
                        {variants.map(([variant, quantity]) => (
                          <div key={variant} className='rounded-lg border border-emerald-200 bg-white px-3 py-3 flex items-center justify-between gap-3'>
                            <div>
                              <p className='font-medium text-gray-700'>{variant.replace('__', ' / ')}</p>
                              {quantity < LOW_STOCK_THRESHOLD && (
                                <p className='text-xs text-red-500'>Tồn kho thấp</p>
                              )}
                            </div>

                            <div className='flex items-center gap-2'>
                              <input
                                type='number'
                                min='0'
                                value={quantity}
                                onChange={(e) => updateDraftValue(product.id, variant, e.target.value)}
                                className='w-28 border rounded px-3 py-2'
                              />
                            </div>
                          </div>
                        ))}
                      </div>

                      <div className='mt-4'>
                        <button
                          type='button'
                          onClick={() => saveInventory(product.id)}
                          disabled={savingProductId === product.id}
                          className='bg-rose-500 hover:bg-rose-600 text-white px-8 py-3 rounded-xl disabled:opacity-60'
                        >
                          {savingProductId === product.id ? 'Đang lưu...' : 'Lưu tồn kho'}
                        </button>
                      </div>
                    </div>
                  )}
                </div>
              )
            })}
          </div>
        </>
      )}

      {activeTab === 'top-selling' && (
        <div className='bg-white border rounded-xl p-5'>
          <h2 className='text-xl font-semibold text-gray-800 mb-4'>Sản phẩm bán chạy</h2>
          <div className='flex flex-col gap-3'>
            {topSelling.length > 0 ? (
              topSelling.slice(0, 10).map((product, index) => (
                <div key={product.id} className='flex items-center justify-between border rounded-lg p-4 bg-amber-50'>
                  <div>
                    <p className='font-semibold text-gray-800'>{index + 1}. {product.name}</p>
                    <p className='text-sm text-amber-700'>Đã bán {product.soldCount} sản phẩm</p>
                  </div>
                  <div className='text-right'>
                    <p className='font-semibold text-gray-700'>{product.totalStock}</p>
                    <p className='text-xs text-gray-500'>còn trong kho</p>
                  </div>
                </div>
              ))
            ) : (
              <p className='text-gray-500'>Chưa có dữ liệu bán hàng.</p>
            )}
          </div>
        </div>
      )}
    </div>
  )
}

export default Inventory
