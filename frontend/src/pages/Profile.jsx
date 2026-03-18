import { useState, useEffect, useContext } from "react";
import axios from "axios";
import { ShopContext } from "../context/ShopContext";
import { toast } from "react-toastify";

const LOCATION_API_BASE = "https://provinces.open-api.vn/api/v1";

const Profile = () => {
  const { token, backendUrl } = useContext(ShopContext)

  const [form, setForm] = useState({
    firstName: "",
    lastName: "",
    email: "",
    address: "",
    ward: "",
    district: "",
    city: "",
    phone: ""
  });
  const [provinces, setProvinces] = useState([]);
  const [districts, setDistricts] = useState([]);
  const [wards, setWards] = useState([]);
  const [selectedProvinceCode, setSelectedProvinceCode] = useState("");
  const [selectedDistrictCode, setSelectedDistrictCode] = useState("");
  const [profileLoaded, setProfileLoaded] = useState(false);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const loadProvinces = async () => {
    try {
      const res = await axios.get(LOCATION_API_BASE + "/p/");
      setProvinces(res.data || []);
    } catch (error) {
      console.log(error);
      toast.error("Không thể tải danh sách tỉnh/thành");
    }
  };

  const loadDistricts = async (provinceCode) => {
    if (!provinceCode) {
      setDistricts([]);
      setWards([]);
      setSelectedDistrictCode("");
      return;
    }

    try {
      const res = await axios.get(LOCATION_API_BASE + `/p/${provinceCode}?depth=2`);
      setDistricts(res.data?.districts || []);
    } catch (error) {
      console.log(error);
      toast.error("Không thể tải danh sách quận/huyện");
    }
  };

  const loadWards = async (districtCode) => {
    if (!districtCode) {
      setWards([]);
      return;
    }

    try {
      const res = await axios.get(LOCATION_API_BASE + `/d/${districtCode}?depth=2`);
      setWards(res.data?.wards || []);
    } catch (error) {
      console.log(error);
      toast.error("Không thể tải danh sách phường/xã");
    }
  };

  const handleProvinceChange = async (e) => {
    const provinceCode = e.target.value;
    const province = provinces.find((item) => item.code.toString() === provinceCode);

    setSelectedProvinceCode(provinceCode);
    setSelectedDistrictCode("");
    setForm((prev) => ({
      ...prev,
      city: province?.name || "",
      district: "",
      ward: ""
    }));
    setWards([]);

    await loadDistricts(provinceCode);
  };

  const handleDistrictChange = async (e) => {
    const districtCode = e.target.value;
    const district = districts.find((item) => item.code.toString() === districtCode);

    setSelectedDistrictCode(districtCode);
    setForm((prev) => ({
      ...prev,
      district: district?.name || "",
      ward: ""
    }));

    await loadWards(districtCode);
  };

  const handleWardChange = (e) => {
    const wardCode = e.target.value;
    const ward = wards.find((item) => item.code.toString() === wardCode);

    setForm((prev) => ({
      ...prev,
      ward: ward?.name || ""
    }));
  };

  // LOAD PROFILE KHI MỞ TRANG
  const loadProfile = async () => {
    try {

      if (token) {
        const res = await axios.post(
          backendUrl + "/api/user/profile",
          {},
          { headers: { token } }
        );

        if (res.data.success) {

          const user = res.data.user;

          setForm({
            firstName: user.firstName || "",
            lastName: user.lastName || "",
            email: user.email || "",
            address: user.address || "",
            ward: user.ward || "",
            district: user.district || "",
            city: user.city || "",
            phone: user.phone || ""
          });
          setProfileLoaded(true);

        }
      }


    } catch (error) {

      console.log(error);

    }
  };

  // chạy khi mở trang
  useEffect(() => {
    loadProvinces();
  }, []);

  useEffect(() => {
    loadProfile();
  }, [token]);

  useEffect(() => {
    if (!profileLoaded || provinces.length === 0 || !form.city) {
      return;
    }

    const matchedProvince = provinces.find((item) => item.name === form.city);
    if (matchedProvince) {
      setSelectedProvinceCode(matchedProvince.code.toString());
      loadDistricts(matchedProvince.code.toString());
    }
  }, [profileLoaded, provinces, form.city]);

  useEffect(() => {
    if (!profileLoaded || districts.length === 0 || !form.district) {
      return;
    }

    const matchedDistrict = districts.find((item) => item.name === form.district);
    if (matchedDistrict) {
      setSelectedDistrictCode(matchedDistrict.code.toString());
      loadWards(matchedDistrict.code.toString());
    }
  }, [profileLoaded, districts, form.district]);

  // LƯU PROFILE
  const saveProfile = async () => {

    try {

      if (token) {
        const res = await axios.post(
          backendUrl + "/api/user/update-profile",
          {
            ...form
          },
          {
            headers: { token }
          }
        );

        if (res.data.success) {

          toast.success("Lưu thông tin thành công!");

          // load lại dữ liệu mới
          loadProfile();

        } else {

          toast.error(res.data.message);

        }
      }

    } catch (error) {

      console.log(error);
      toast.error("Có lỗi xảy ra");

    }

  };

  return (
    <div className="max-w-4xl mx-auto p-6">

      <h2 className="text-2xl font-semibold mb-6">
        Thông tin cá nhân
      </h2>

      <div className="grid grid-cols-2 gap-4">

        <input
          name="firstName"
          value={form.firstName}
          onChange={handleChange}
          placeholder="Họ"
          className="border p-3 rounded"
        />

        <input
          name="lastName"
          value={form.lastName}
          onChange={handleChange}
          placeholder="Tên"
          className="border p-3 rounded"
        />

        <input
          name="email"
          value={form.email}
          onChange={handleChange}
          placeholder="Email"
          className="border p-3 rounded col-span-2"
        />

        <input
          name="address"
          value={form.address}
          onChange={handleChange}
          placeholder="Số nhà, tên đường"
          className="border p-3 rounded col-span-2"
        />

        <select
          value={selectedProvinceCode}
          onChange={handleProvinceChange}
          className="border p-3 rounded col-span-2 bg-white"
        >
          <option value="">Chọn Tỉnh/Thành phố</option>
          {provinces.map((province) => (
            <option key={province.code} value={province.code}>
              {province.name}
            </option>
          ))}
        </select>

        <select
          value={selectedDistrictCode}
          onChange={handleDistrictChange}
          className="border p-3 rounded"
          disabled={!selectedProvinceCode}
        >
          <option value="">Chọn Quận/Huyện</option>
          {districts.map((district) => (
            <option key={district.code} value={district.code}>
              {district.name}
            </option>
          ))}
        </select>

        <select
          value={wards.find((ward) => ward.name === form.ward)?.code || ""}
          onChange={handleWardChange}
          className="border p-3 rounded"
          disabled={!selectedDistrictCode}
        >
          <option value="">Chọn Phường/Xã</option>
          {wards.map((ward) => (
            <option key={ward.code} value={ward.code}>
              {ward.name}
            </option>
          ))}
        </select>

        <input
          name="phone"
          value={form.phone}
          onChange={handleChange}
          placeholder="Số điện thoại"
          className="border p-3 rounded col-span-2"
        />

      </div>

      <button
        onClick={saveProfile}
        className="mt-6 bg-black text-white px-6 py-2 rounded"
      >
        Lưu thông tin
      </button>

    </div>
  );
};

export default Profile;
