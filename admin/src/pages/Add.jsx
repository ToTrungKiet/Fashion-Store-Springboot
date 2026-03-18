import {useState} from 'react'
import { assets } from '../assets/assets.js'
import axios from 'axios'
import { backendUrl } from '../App.jsx'
import { toast } from 'react-toastify'

const COLORS = ['Đen', 'Trắng', 'Xám']

const Add = ({token}) => {

  const [image1, setImage1] = useState(false)
  const [image2, setImage2] = useState(false)
  const [image3, setImage3] = useState(false)
  const [image4, setImage4] = useState(false)

  const [name, setName] = useState('')
  const [description, setDescription] = useState('')
  const [price, setPrice] = useState('')
  const [category, setCategory] = useState('Nam')
  const [subCategory, setSubCategory] = useState('Áo')
  const [bestseller, setBestseller] = useState(false)
  const [sizes, setSizes] = useState([])
  const [inventory, setInventory] = useState({})

  const buildVariantKey = (size, color) => `${size}__${color}`

  const toggleSize = (size) => {
    setSizes((prev) =>
      prev.includes(size) ? prev.filter((item) => item !== size) : [...prev, size]
    )

    setInventory((prev) => {
      const next = { ...prev }
      COLORS.forEach((color) => {
        const key = buildVariantKey(size, color)
        if (!(key in next)) {
          next[key] = 0
        }
      })
      return next
    })
  }

  const updateInventory = (size, color, value) => {
    const numericValue = Number(value)
    setInventory((prev) => ({
      ...prev,
      [buildVariantKey(size, color)]: Number.isNaN(numericValue) ? 0 : Math.max(numericValue, 0)
    }))
  }

  const getInventoryPayload = () => {
    const payload = {}
    sizes.forEach((size) => {
      COLORS.forEach((color) => {
        const key = buildVariantKey(size, color)
        payload[key] = inventory[key] || 0
      })
    })
    return payload
  }

  const onSubmitHandler = async (e) => {
    e.preventDefault()
    try {
      const formData = new FormData()
      formData.append('name', name)
      formData.append('description', description)
      formData.append('price', price)
      formData.append('category', category)
      formData.append('subCategory', subCategory)
      formData.append('bestseller', bestseller)
      formData.append('sizes', JSON.stringify(sizes))
      formData.append('inventoryData', JSON.stringify(getInventoryPayload()))
      image1 && formData.append('image1', image1)
      image2 && formData.append('image2', image2)
      image3 && formData.append('image3', image3)
      image4 && formData.append('image4', image4)

      const response = await axios.post(backendUrl + '/api/product/add', formData, {headers: {token}})
      if (response.data.success) {
        toast.success(response.data.message)
        setName('')
        setDescription('')
        setImage1(false)
        setImage2(false)
        setImage3(false)
        setImage4(false)
        setPrice('')
        setSizes([])
        setInventory({})
        setBestseller(false)
      } else {
        toast.error(response.data.message)
      }
    } catch (error) {
      console.log('Error:', error.response?.data || error.message);
      toast.error(response?.data?.message || 'Lỗi kết nối');

    }
  }

  return (
    <div>
      <form onSubmit={onSubmitHandler} className='flex flex-col w-full items-start gap-3'>
        <p className='text-2xl font-bold mb-3 text-gray-800'>Thêm sản phẩm</p>
        <div>
          <p className='mb-2'>Tải hình ảnh</p>
          <div className='flex gap-4'>
            <label htmlFor="image1" className='cursor-pointer'>
              <img className='w-40' src={!image1 ? assets.upload_area : URL.createObjectURL(image1)} alt="" />
              <input onChange={(e) => setImage1(e.target.files[0])} type="file" id="image1" hidden />
            </label>
            <label htmlFor="image2" className='cursor-pointer'>
              <img className='w-40' src={!image2 ? assets.upload_area : URL.createObjectURL(image2)} alt="" />
              <input onChange={(e) => setImage2(e.target.files[0])} type="file" id="image2" hidden />
            </label>
            <label htmlFor="image3" className='cursor-pointer'>
              <img className='w-40' src={!image3 ? assets.upload_area : URL.createObjectURL(image3)} alt="" />
              <input onChange={(e) => setImage3(e.target.files[0])} type="file" id="image3" hidden />
            </label>
            <label htmlFor="image4" className='cursor-pointer'>
              <img className='w-40' src={!image4 ? assets.upload_area : URL.createObjectURL(image4)} alt="" />
              <input onChange={(e) => setImage4(e.target.files[0])} type="file" id="image4" hidden />
            </label>
          </div>
        </div>

        <div className='w-full'>
          <p className='mb-2'>Tên sản phẩm</p>
          <input onChange={(e) => setName(e.target.value)} value={name} className='w-full max-w-[500px] px-3 py-2' type="text" placeholder='Nhập tên sản phẩm' required />
        </div>
        <div className='w-full'>
          <p className='mb-2'>Mô tả sản phẩm</p>
          <textarea onChange={(e) => setDescription(e.target.value)} value={description} className='w-full max-w-[500px] px-3 py-2' placeholder='Nhập mô tả sản phẩm' required />
        </div>

        <div className='flex flex-col sm:flex-row gap-2 w-full sm:gap-8'>
          <div>
            <p className='mb-2'>Danh mục sản phẩm</p>
            <select onChange={(e) => setCategory(e.target.value)} className='w-full px-3 py-2 mb-2'>
              <option value="Nam">Nam</option>
              <option value="Nữ">Nữ</option>
              <option value="Trẻ em">Trẻ em</option>
            </select>
          </div>
          <div>
            <p className='mb-2'>Loại sản phẩm</p>
            <select onChange={(e) => setSubCategory(e.target.value)} className='w-full px-3 py-2 mb-2'>
              <option value="Áo">Áo</option>
              <option value="Quần">Quần</option>
              <option value="Áo khoác">Áo khoác</option>
            </select>
          </div>
          <div>
            <p className='mb-2'>Giá sản phẩm</p>
            <input onChange={(e) => setPrice(e.target.value)} className='w-full sm:w-[120px] px-3 py-2' type="Number" placeholder='100000' />
          </div>
        </div>
        <div>
          <p className='mb-2'>Kích cỡ sản phẩm</p>
          <div className='flex gap-3'>
            <div onClick={() => toggleSize('S')}>
              <p className={`${sizes.includes('S') ? 'bg-rose-300' : 'bg-slate-200'} px-3 py-1 cursor-pointer`}>S</p>
            </div>
            <div onClick={() => toggleSize('M')}>
              <p className={`${sizes.includes('M') ? 'bg-rose-300' : 'bg-slate-200'} px-3 py-1 cursor-pointer`}>M</p>
            </div>
            <div onClick={() => toggleSize('L')}>
              <p className={`${sizes.includes('L') ? 'bg-rose-300' : 'bg-slate-200'} px-3 py-1 cursor-pointer`}>L</p>
            </div>
            <div onClick={() => toggleSize('XL')}>
              <p className={`${sizes.includes('XL') ? 'bg-rose-300' : 'bg-slate-200'} px-3 py-1 cursor-pointer`}>XL</p>
            </div>
            <div onClick={() => toggleSize('XXL')}>
              <p className={`${sizes.includes('XXL') ? 'bg-rose-300' : 'bg-slate-200'} px-3 py-1 cursor-pointer`}>XXL</p>
            </div>
          </div>
        </div>
        {sizes.length > 0 && (
          <div className='w-full max-w-[700px]'>
            <p className='mb-2'>Kho hàng theo size và màu sắc</p>
            <div className='grid grid-cols-[100px_repeat(3,1fr)] gap-2 items-center'>
              <div className='font-medium'>Size</div>
              {COLORS.map((color) => (
                <div key={color} className='font-medium'>{color}</div>
              ))}
              {sizes.map((size) => (
                <>
                  <div key={`${size}-label`} className='font-medium'>{size}</div>
                  {COLORS.map((color) => (
                    <input
                      key={buildVariantKey(size, color)}
                      type='number'
                      min='0'
                      value={inventory[buildVariantKey(size, color)] ?? 0}
                      onChange={(e) => updateInventory(size, color, e.target.value)}
                      className='border px-3 py-2'
                    />
                  ))}
                </>
              ))}
            </div>
          </div>
        )}
        <div className='flex gap-2 mt-2'>
          <input onChange={() => setBestseller(prev => !prev)} checked={bestseller} type="checkbox" id='bestseller'/>
          <label htmlFor="bestseller" className='cursor-pointer'>Thêm vào sản phẩm nổi bật</label>
        </div>
        <button type="submit" className='w-36 py-3 mt-4 bg-rose-500 hover:bg-rose-600 active:bg-rose-700 cursor-pointer text-white rounded-full'>Thêm sản phẩm</button>
      </form>
    </div>
  )
}

export default Add
