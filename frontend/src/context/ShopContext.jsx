import { createContext, useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify'
import axios from 'axios';

export const ShopContext = createContext();

const ShopContextProvider = (props) => {

  const navigate = useNavigate();
  const currency = 'VND';
  const delivery_fee = 30000;
  const backendUrl = import.meta.env.VITE_BACKEND_URL;
  const [search, setSearch] = useState('');
  const [showSearch, setShowSearch] = useState(false);
  const [cartItems, setCartItems] = useState({})
  const [products, setProducts] = useState([]);
  const [token, setToken] = useState('')

  const parseVariantKey = (variantKey) => {
    const [size = '', color = ''] = variantKey.split('__');
    return { size, color };
  }

  const normalizeCartData = (rawCartData) => {
    if (!rawCartData) {
      return {};
    }

    return typeof rawCartData === 'string'
      ? JSON.parse(rawCartData)
      : rawCartData;
  }

  const getVariantStock = (itemId, size, color) => {
    const product = products.find((entry) => entry.id.toString() === itemId.toString());

    if (!product?.inventory) {
      return 0;
    }

    return product.inventory[`${size}__${color}`] || 0;
  }

  const getCartVariantQuantity = (itemId, size, color, sourceCartItems = cartItems) => {
    const variantKey = `${size}__${color}`;
    return sourceCartItems?.[itemId]?.[variantKey]
      || sourceCartItems?.[itemId?.toString?.()]?.[variantKey]
      || 0;
  }

  const addToCart = async (itemId, size, color) => {
    if (!token) {
      toast.error('Vui lòng đăng nhập !')
      navigate('/login')
      return;
    }
    if (!size) {
      toast.error('Vui lòng chọn size !')
      return;
    }
    if (!color) {
      toast.error('Vui lòng chọn màu sắc !')
      return;
    }

    try {
      const response = await axios.post(
        backendUrl + '/api/cart/add',
        { itemId, size, color },
        { headers: { token } }
      );

      if (!response.data?.success) {
        toast.error(response.data?.message || 'Không thể thêm vào giỏ hàng');
        return;
      }

      await getUserCart(token);
      toast.success(response.data.message);

    } catch (error) {

      console.log("Cart API error:", error.response || error);

      toast.error(error.response?.data?.message || 'Admin không được truy cập vào giỏ hàng !');

    }
  }

  const getCartCount = () => {
    let totalCount = 0;
    for (const items in cartItems) {
      for (const item in cartItems[items]) {
        try {
          if (cartItems[items][item] > 0) {
            totalCount += cartItems[items][item];
          }
        } catch (error) {
          console.log(error);
          toast.error('Lỗi kết nối');
        }
      }
    }
    return totalCount;
  }

  const updateQuantity = async (itemId, size, color, quantity) => {
    const variantStock = getVariantStock(itemId, size, color);

    if (quantity > variantStock) {
      toast.error(
        variantStock > 0
          ? `Số lượng còn lại không đủ. Chỉ còn ${variantStock} sản phẩm.`
          : 'Sản phẩm này hiện đã hết hàng.'
      );
      return;
    }

    if (token) {
      try {
        const response = await axios.post(
          backendUrl + '/api/cart/update',
          { itemId, size, color, quantity },
          { headers: { token } }
        );

        if (!response.data?.success) {
          toast.error(response.data?.message || 'Không thể cập nhật giỏ hàng');
          return;
        }

        await getUserCart(token);
      } catch (error) {
        console.log(error);
        toast.error(error.response?.data?.message || 'Lỗi kết nối');
      }
      return;
    }

    const variantKey = `${size}__${color}`;
    const nextCartData = structuredClone(cartItems);

    if (!nextCartData[itemId]) {
      return;
    }

    if (quantity <= 0) {
      delete nextCartData[itemId][variantKey];
      if (Object.keys(nextCartData[itemId]).length === 0) {
        delete nextCartData[itemId];
      }
    } else {
      nextCartData[itemId][variantKey] = quantity;
    }

    setCartItems(nextCartData);
  }

  const getCartAmount = () => {
    let totalAmount = 0;
    for (const items in cartItems) {
      let itemInfo = products.find((product) => product.id.toString() === items.toString());
      for (const item in cartItems[items]) {
        try {
          if (cartItems[items][item] > 0) {
            totalAmount += (itemInfo?.price || 0) * cartItems[items][item];
          }
        } catch (e) {
          console.log(e)
        }
      }
    }
    return totalAmount;
  }

  const formatPrice = (price) => {
    return price.toLocaleString('vi-VN');
  }

  const getProductsData = async () => {
    try {
      const response = await axios.get(backendUrl + '/api/product/list');
      if (response.data.success) {
        setProducts(response.data.products);
      } else {
        toast.error(response.data.message)
      }
    } catch (error) {
      console.log(error);
      toast.error('Lỗi kết nối');
    }
  }

  const getUserCart = async (token) => {
    try {
      const response = await axios.post(backendUrl + '/api/cart/get', {}, { headers: { token } });
      if (response.data.success) {
        setCartItems(normalizeCartData(response.data.cartData));
      }
    } catch (error) {

    }
  }

  useEffect(() => {
    getProductsData();
  }, [])

  useEffect(() => {
    if (!token && localStorage.getItem('token')) {
      setToken(localStorage.getItem('token'));
    }
  }, [])

  useEffect(() => {
    if (token) {
      getUserCart(token);
    }
  }, [token])

  const value = {
    products, currency, delivery_fee,
    search, setSearch, showSearch, setShowSearch,
    cartItems, setCartItems, addToCart, getCartCount,
    updateQuantity, getCartAmount, formatPrice,
    navigate, backendUrl, token, setToken, parseVariantKey, getCartVariantQuantity, getUserCart
  }

  return (
    <ShopContext.Provider value={value}>
      {props.children}
    </ShopContext.Provider>
  )
}

export default ShopContextProvider;
