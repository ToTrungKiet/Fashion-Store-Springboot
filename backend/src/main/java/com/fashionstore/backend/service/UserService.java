package com.fashionstore.backend.service;

import com.fashionstore.backend.entity.Role;
import com.fashionstore.backend.entity.User;
import com.fashionstore.backend.repository.RoleRepository;
import com.fashionstore.backend.repository.UserRepository;
import com.fashionstore.backend.security.JwtUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Pattern;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    @Value("${frontend.url}")
    private String frontendUrl;

    private static final Pattern STRONG_PASSWORD = Pattern.compile(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$");
    private static final Pattern EMAIL_REGEX = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final SecureRandom SECURE_RANDOM = new SecureRandom();

    public Map<String, Object> registerUser(String name, String email, String password) {

        Map<String, Object> response = new HashMap<>();

        if (userRepository.findByEmail(email).isPresent()) {
            response.put("success", false);
            response.put("message", "Người dùng này đã tồn tại !");
            return response;
        }

        String username = name.trim();

        if (username.length() < 3 || username.length() > 30) {
            response.put("success", false);
            response.put("message", "Tên người dùng phải từ 3 đến 30 ký tự !");
            return response;
        }

        Pattern usernameRegex = Pattern.compile("^[a-zA-Z]+$");

        if (!usernameRegex.matcher(username).matches()) {
            response.put("success", false);
            response.put("message", "Tên người dùng chỉ được chứa chữ cái !");
            return response;
        }

        if (!EMAIL_REGEX.matcher(email).matches()) {
            response.put("success", false);
            response.put("message", "Vui lòng nhập Email hợp lệ !");
            return response;
        }

        if (!STRONG_PASSWORD.matcher(password).matches()) {
            response.put("success", false);
            response.put("message", "Mật khẩu phải mạnh !");
            return response;
        }

        String hashedPassword = passwordEncoder.encode(password);

        User user = new User();
        user.setName(username);
        user.setEmail(email);
        user.setPassword(hashedPassword);

        Role roleUser = roleRepository
                .findByName("ROLE_USER")
                .orElseThrow(() -> new RuntimeException("ROLE_USER không tồn tại"));

        user.getRoles().add(roleUser);

        userRepository.save(user);

        // TẠO TOKEN
        String token = jwtUtil.generateToken(user.getId());

        response.put("success", true);
        response.put("message", "Đăng ký thành công !");
        response.put("token", token);

        return response;
    }

    public Map<String, Object> loginUser(String email, String password) {

        Map<String, Object> response = new HashMap<>();

        Optional<User> userOptional = userRepository.findByEmail(email);

        if (userOptional.isEmpty()) {
            response.put("success", false);
            response.put("message", "Người dùng không tồn tại !");
            return response;
        }

        User user = userOptional.get();

        if (passwordEncoder.matches(password, user.getPassword())) {

            String token = jwtUtil.generateToken(user.getId());

            response.put("success", true);
            response.put("message", "Đăng nhập thành công !");
            response.put("token", token);

        } else {

            response.put("success", false);
            response.put("message", "Mật khẩu không đúng !");
        }

        return response;
    }

    public Map<String, Object> adminLogin(String email, String password) {

        Map<String, Object> response = new HashMap<>();

        Optional<User> userOptional = userRepository.findByEmail(email);

        if (userOptional.isEmpty()) {
            response.put("success", false);
            response.put("message", "Người dùng không tồn tại !");
            return response;
        }

        User user = userOptional.get();

        if (!passwordEncoder.matches(password, user.getPassword())) {
            response.put("success", false);
            response.put("message", "Mật khẩu không đúng !");
            return response;
        }

        // ===== KIỂM TRA ROLE ADMIN =====
        boolean isAdmin = user.getRoles()
                .stream()
                .anyMatch(role -> role.getName().equals("ROLE_ADMIN"));

        if (!isAdmin) {
            response.put("success", false);
            response.put("message", "Bạn không có quyền truy cập trang admin !");
            return response;
        }

        String token = jwtUtil.generateToken(user.getId());

        response.put("success", true);
        response.put("message", "Đăng nhập admin thành công !");
        response.put("token", token);

        return response;
    }

    public Map<String, Object> forgotPassword(String email) {

        Map<String, Object> response = new HashMap<>();

        if (email == null || email.isBlank() || !EMAIL_REGEX.matcher(email).matches()) {
            response.put("success", false);
            response.put("message", "Vui lòng nhập Email hợp lệ !");
            return response;
        }

        Optional<User> userOptional = userRepository.findByEmail(email.trim());

        if (userOptional.isEmpty()) {
            response.put("success", false);
            response.put("message", "Email không tồn tại trong hệ thống !");
            return response;
        }

        User user = userOptional.get();
        String rawResetToken = generateResetToken();
        String hashedResetToken = hashToken(rawResetToken);

        user.setResetPasswordToken(hashedResetToken);
        user.setResetPasswordExpiresAt(LocalDateTime.now().plusHours(1));
        userRepository.save(user);

        String resetLink = frontendUrl + "/reset-password?token=" + rawResetToken;
        emailService.sendResetPasswordEmail(user.getEmail(), resetLink);

        response.put("success", true);
        response.put("message", "Email đặt lại mật khẩu đã được gửi. Vui lòng kiểm tra email của bạn !");

        return response;
    }

    public Map<String, Object> resetPassword(String token, String newPassword, String confirmPassword) {

        Map<String, Object> response = new HashMap<>();

        if (token == null || token.isBlank()) {
            response.put("success", false);
            response.put("message", "Token không được cung cấp !");
            return response;
        }

        if (newPassword == null || newPassword.isBlank() || confirmPassword == null || confirmPassword.isBlank()) {
            response.put("success", false);
            response.put("message", "Vui lòng nhập mật khẩu mới !");
            return response;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.put("success", false);
            response.put("message", "Mật khẩu xác nhận không khớp !");
            return response;
        }

        if (!STRONG_PASSWORD.matcher(newPassword).matches()) {
            response.put("success", false);
            response.put("message", "Mật khẩu ít nhất 8 ký tự, phải có chữ hoa, chữ thường, số và ký tự đặc biệt !");
            return response;
        }

        Optional<User> userOptional = userRepository.findByResetPasswordToken(hashToken(token));

        if (userOptional.isEmpty()) {
            response.put("success", false);
            response.put("message", "Token không hợp lệ hoặc đã hết hạn !");
            return response;
        }

        User user = userOptional.get();

        if (user.getResetPasswordExpiresAt() == null
                || user.getResetPasswordExpiresAt().isBefore(LocalDateTime.now())) {
            response.put("success", false);
            response.put("message", "Token không hợp lệ hoặc đã hết hạn !");
            return response;
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        user.setResetPasswordToken(null);
        user.setResetPasswordExpiresAt(null);
        userRepository.save(user);

        response.put("success", true);
        response.put("message", "Mật khẩu đã được đặt lại thành công !");

        return response;
    }

    public Map<String, Object> getProfile(Long userId) {

        Map<String, Object> response = new HashMap<>();
        User user = userRepository.findById(userId).orElse(null);

        if (user == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy user");
            return response;
        }

        response.put("success", true);
        response.put("user", sanitizeUser(user));

        return response;
    }

    public Map<String, Object> updateProfile(
            Long userId,
            String firstName,
            String lastName,
            String email,
            String address,
            String ward,
            String district,
            String city,
            String phone) {

        Map<String, Object> response = new HashMap<>();
        User user = userRepository.findById(userId).orElse(null);

        if (user == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy user");
            return response;
        }

        if (email != null && !email.isBlank()) {
            if (!EMAIL_REGEX.matcher(email).matches()) {
                response.put("success", false);
                response.put("message", "Vui lòng nhập Email hợp lệ !");
                return response;
            }

            Optional<User> existingUser = userRepository.findByEmail(email.trim());
            if (existingUser.isPresent() && !existingUser.get().getId().equals(userId)) {
                response.put("success", false);
                response.put("message", "Email đã được sử dụng !");
                return response;
            }
            user.setEmail(email.trim());
        }

        user.setFirstName(defaultString(firstName));
        user.setLastName(defaultString(lastName));
        user.setAddress(defaultString(address));
        user.setWard(defaultString(ward));
        user.setDistrict(defaultString(district));
        user.setCity(defaultString(city));
        user.setPhone(defaultString(phone));

        userRepository.save(user);

        response.put("success", true);
        response.put("message", "Cập nhật thành công");
        response.put("user", sanitizeUser(user));

        return response;
    }

    public Map<String, Object> changePassword(
            Long userId,
            String currentPassword,
            String newPassword,
            String confirmPassword) {

        Map<String, Object> response = new HashMap<>();

        if (currentPassword == null || currentPassword.isBlank()
                || newPassword == null || newPassword.isBlank()
                || confirmPassword == null || confirmPassword.isBlank()) {
            response.put("success", false);
            response.put("message", "Vui lòng nhập đầy đủ thông tin !");
            return response;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.put("success", false);
            response.put("message", "Mật khẩu xác nhận không khớp !");
            return response;
        }

        if (!STRONG_PASSWORD.matcher(newPassword).matches()) {
            response.put("success", false);
            response.put("message", "Mật khẩu ít nhất 8 ký tự, phải có chữ hoa, chữ thường, số và ký tự đặc biệt !");
            return response;
        }

        User user = userRepository.findById(userId).orElse(null);

        if (user == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy người dùng !");
            return response;
        }

        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            response.put("success", false);
            response.put("message", "Mật khẩu hiện tại không đúng !");
            return response;
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        response.put("success", true);
        response.put("message", "Mật khẩu đã được thay đổi thành công !");

        return response;
    }

    private String generateResetToken() {
        byte[] bytes = new byte[32];
        SECURE_RANDOM.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    private String hashToken(String token) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = digest.digest(token.getBytes(StandardCharsets.UTF_8));
            StringBuilder builder = new StringBuilder();
            for (byte hashedByte : hashedBytes) {
                builder.append(String.format("%02x", hashedByte));
            }
            return builder.toString();
        } catch (Exception e) {
            throw new RuntimeException("Không thể tạo reset token !", e);
        }
    }

    private Map<String, Object> sanitizeUser(User user) {
        Map<String, Object> userData = new HashMap<>();
        userData.put("id", user.getId());
        userData.put("name", user.getName());
        userData.put("email", user.getEmail());
        userData.put("firstName", user.getFirstName());
        userData.put("lastName", user.getLastName());
        userData.put("address", user.getAddress());
        userData.put("ward", user.getWard());
        userData.put("district", user.getDistrict());
        userData.put("city", user.getCity());
        userData.put("phone", user.getPhone());
        userData.put("createdAt", user.getCreatedAt());
        userData.put("updatedAt", user.getUpdatedAt());
        return userData;
    }

    private String defaultString(String value) {
        return value == null ? "" : value.trim();
    }
}
