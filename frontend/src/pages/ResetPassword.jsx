import { useState, useContext } from 'react'
import { useSearchParams } from 'react-router-dom'
import { ShopContext } from '../context/ShopContext'
import axios from 'axios'
import { toast } from 'react-toastify'

const ResetPassword = () => {
  const { backendUrl, navigate } = useContext(ShopContext)
  const [searchParams] = useSearchParams()
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)

  const token = searchParams.get('token') || ''

  const onSubmitHandler = async (e) => {
    e.preventDefault()

    if (!token) {
      toast.error('Link đặt lại mật khẩu không hợp lệ')
      return
    }

    setIsSubmitting(true)

    try {
      const response = await axios.post(backendUrl + '/api/user/reset-password', {
        token,
        password,
        confirmPassword,
      })

      if (response.data.success) {
        toast.success(response.data.message)
        setPassword('')
        setConfirmPassword('')
        navigate('/login')
      } else {
        toast.error(response.data.message)
      }
    } catch (error) {
      console.log(error)
      toast.error('Không thể đặt lại mật khẩu')
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
        <p className='prata-regular text-3xl'>Đặt lại mật khẩu</p>
        <hr className='border-none h-[1.5px] w-8 bg-gray-800' />
      </div>

      <input
        onChange={(e) => setPassword(e.target.value)}
        value={password}
        type='password'
        className='w-full px-3 py-2 border border-gray-800'
        placeholder='Mật khẩu mới'
        autoComplete='new-password'
        required
      />

      <input
        onChange={(e) => setConfirmPassword(e.target.value)}
        value={confirmPassword}
        type='password'
        className='w-full px-3 py-2 border border-gray-800'
        placeholder='Đặt lại mật khẩu'
        autoComplete='new-password'
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
        Đặt lại mật khẩu
      </button>
    </form>
  )
}

export default ResetPassword
