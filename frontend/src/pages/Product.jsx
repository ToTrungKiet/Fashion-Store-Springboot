import { useContext, useState, useEffect } from 'react'
import { useParams } from 'react-router-dom'
import { ShopContext } from '../context/ShopContext'
import { assets } from '../assets/assets'
import RelatedProducts from '../components/RelatedProducts'

const Product = () => {

  const { productId } = useParams();
  const { products, currency, addToCart, formatPrice, getCartVariantQuantity } = useContext(ShopContext);
  const [productData, setProductData] = useState(false);
  const [image, setImage] = useState('');
  const [size, setSize] = useState('');
  const [color, setColor] = useState('');

  const colors = ['Đen', 'Trắng', 'Xám'];

  const getVariantStock = (selectedSize, selectedColor) => {
    if (!productData?.inventory || !selectedSize || !selectedColor) {
      return 0;
    }

    return productData.inventory[`${selectedSize}__${selectedColor}`] || 0;
  };

  const isAvailableColor = (selectedColor) => {
    if (!size || !productData?.inventory) {
      return false;
    }
    return getVariantStock(size, selectedColor) > 0;
  };

  const selectedVariantStock = size && color ? getVariantStock(size, color) : 0;
  const selectedVariantCartQuantity = size && color
    ? getCartVariantQuantity(productData?.id, size, color)
    : 0;
  const remainingStock = Math.max(selectedVariantStock - selectedVariantCartQuantity, 0);
  const canAddToCart = Boolean(size && color && remainingStock > 0);

  const fetchProductData = async () => {
    products.map((item) => {
      if (item.id === Number(productId)) {
        setProductData(item)
        setImage(item.image[0])
        setSize('')
        setColor('')
        return null;
      }
    })
  }

  useEffect(() => {
    fetchProductData();
  }, [productId, products])

  return productData ? (
    <div>
      <div className='border-t-2 pt-10 transition-opacity ease-in duration-500 opacity-100'>
        {/* Dữ liệu sản phẩm */}
        <div className='flex gap-12 sm:gap-12 flex-col sm:flex-row'>
          {/* Ảnh sản phẩm */}
          <div className='flex-1 flex flex-col-reverse gap-3 sm:flex-row'>
            <div className='flex sm:flex-col overflow-x-auto sm:overflow-y-scroll justify-between sm:justify-normal sm:w-[18.7%] w-full'>
              {
                productData.image.map((item, index) => (
                  <img onClick={() => setImage(item)} src={item} alt='' key={index} className='w-[24%] sm:w-full sm:mb-3 flex-shrink-0 cursor-pointer' />
                ))
              }
            </div>
            <div className='w-full sm:w-[80%]'>
              <img className='w-full h-auto' src={image} alt='' />
            </div>
          </div>
          {/* Thông tin sản phẩm */}
          <div className='flex-1'>
            <h1 className='font-medium text-2xl mt-2'>{productData.name}</h1>
            <div className='flex items-center gap-1 mt-2'>
              <img src={assets.star_icon} alt='' className="w-3 5" />
              <img src={assets.star_icon} alt='' className="w-3 5" />
              <img src={assets.star_icon} alt='' className="w-3 5" />
              <img src={assets.star_icon} alt='' className="w-3 5" />
              <img src={assets.star_dull_icon} alt='' className="w-3 5" />
              <p className='pl-2'>(122)</p>
            </div>
            <p className='mt-5 text-3xl font-medium'>{formatPrice(productData.price)} {currency}</p>
            <p className='mt-5 text-gray-500 md:w-4/5'>{productData.description}</p>
            <div className='flex flex-col gap-4 my-8'>
              <p>Chọn kích cỡ</p>
              <div className='flex gap-2'>
                {productData.sizes.map((item, index) => (
                  <button onClick={() => { setSize(item); setColor(''); }} className={`border py-2 px-4 bg-gray-100 ${item === size ? 'border-rose-500 text-white bg-rose-400' : ''} cursor-pointer`} key={index}>{item}</button>
                ))}
              </div>
            </div>
            <div className='flex flex-col gap-4 mb-8'>
              <p>Chọn màu sắc</p>
              <div className='flex gap-2 flex-wrap'>
                {colors.map((item) => {
                  const available = isAvailableColor(item);
                  return (
                    <button
                      key={item}
                      onClick={() => available && setColor(item)}
                      disabled={!available}
                      className={`border py-2 px-4 rounded-full ${
                        item === color ? 'border-rose-500 text-white bg-rose-400' : 'bg-gray-100'
                      } ${!available ? 'opacity-40 cursor-not-allowed' : 'cursor-pointer'}`}
                    >
                      {item}
                    </button>
                  );
                })}
              </div>
              {size && color ? (
                <p className='text-sm text-gray-500'>
                  Tồn kho: {selectedVariantStock} | Đã có trong giỏ: {selectedVariantCartQuantity} | Có thể thêm: {remainingStock}
                </p>
              ) : (
                <p className='text-sm text-gray-400'>Hãy chọn đầy đủ size và màu sắc để mua hàng.</p>
              )}
            </div>
            <button
              onClick={() => canAddToCart && addToCart(productData.id, size, color)}
              disabled={!canAddToCart}
              className={`px-8 py-3 text-sm rounded-full ${
                canAddToCart
                  ? 'bg-rose-500 hover:bg-rose-600 text-white active:bg-rose-700 cursor-pointer'
                  : 'bg-gray-300 text-gray-500 cursor-not-allowed'
              }`}
            >
              THÊM VÀO GIỎ HÀNG
            </button>
            <hr className='mt-8 sm:w-4/5' />
            <div className='text-sm text-gray-500 mt-5 flex flex-col gap-1'>
              <p>100% sản phẩm chính hãng.</p>
              <p>Hỗ trợ thanh toán khi nhận hàng (COD).</p>
              <p>Đổi trả dễ dàng trong vòng 7 ngày.</p>
            </div>
          </div>
        </div>
        {/* Mô tả & Phần đánh giá */}
        <div className='mt-20'>
          <div className='flex'>
            <b className='border px-5 py-3 text-sm'>Mô tả</b>
            <p className='border px-5 py-3 text-sm'>Đánh giá (122)</p>
          </div>
        </div>
        <div className='flex flex-col gap-4 border px-6 py-6 text-sm text-gray-500'>
          <p>Sản phẩm có chất liệu tốt, đường may chắc chắn và form mặc rất đẹp.
            Màu sắc giống hình, không bị phai sau khi giặt.
            Thời gian giao hàng nhanh, đóng gói cẩn thận.
            Rất đáng tiền và sẽ ủng hộ shop trong những lần mua tiếp theo.
          </p>
          <p>
            Mình mua về mặc rất vừa, vải mềm và không bị nóng.
            Shop tư vấn nhiệt tình, giao hàng nhanh.
            Nói chung là rất hài lòng 👍
          </p>
        </div>
      </div>
      {/* Hiển thị sản phẩm liên quan */}
      <RelatedProducts category={productData.category} subCategory={productData.subCategory} />
    </div>
  ) : <div className='opacity-0'></div>
}

export default Product
