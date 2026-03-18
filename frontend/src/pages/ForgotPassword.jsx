import { useState, useContext } from 'react'
import { ShopContext } from '../context/ShopContext'
import axios from 'axios'
import { toast } from 'react-toastify'

const ForgotPassword = () => {
  const { backendUrl, navigate } = useContext(ShopContext)
  const [email, setEmail] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)

  const onSubmitHandler = async (e) => {
    e.preventDefault()
    setIsSubmitting(true)

    try {
      const response = await axios.post(backendUrl + '/api/user/forgot-password', { email })

      if (response.data.success) {
        toast.success(response.data.message)
        setEmail('')
      } else {
        toast.error(response.data.message)
      }
    } catch (error) {
      console.log(error)
      toast.error('Không thể gửi email đặt lại mật khẩu')
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <form
      onSubmit={onSubmitHandler}
      className='flex flex-col items-center w-[90%] sm:max-w-96 m-auto mt-14 gap-4 text-gray-800'
    >
      <div className='inline-flex items-center gap-2 mb-2 mt-10'>
        <p className='prata-regular text-3xl'>Quên mật khẩu</p>
        <hr className='border-none h-[1.5px] w-8 bg-gray-800' />
      </div>

      <p className='text-sm text-center text-gray-500'>
        Nhập email tài khoản để đặt lại mật khẩu.
      </p>

      <input
        onChange={(e) => setEmail(e.target.value)}
        value={email}
        type='email'
        className='w-full px-3 py-2 border border-gray-800'
        placeholder='Email'
        required
      />

      <div className='w-full flex justify-between text-sm mt-[-8px]'>
        <p
          onClick={() => navigate('/login')}
          className='hover:text-rose-600 active:text-rose-700 cursor-pointer'
        >
          Quay lại đăng nhập
        </p>
      </div>

      <button
        disabled={isSubmitting}
        className='bg-rose-500 hover:bg-rose-600 active:bg-rose-700 cursor-pointer rounded-full text-white font-light px-8 py-2 mt-4 disabled:opacity-60'
      >
        Gửi link
      </button>
    </form>
  )
}

export default ForgotPassword
