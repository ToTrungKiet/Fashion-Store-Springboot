package com.fashionstore.backend.service;

import com.fashionstore.backend.entity.Role;
import com.fashionstore.backend.entity.User;
import com.fashionstore.backend.repository.RoleRepository;
import com.fashionstore.backend.repository.UserRepository;
import com.fashionstore.backend.security.JwtUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
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

        Pattern emailRegex = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

        if (!emailRegex.matcher(email).matches()) {
            response.put("success", false);
            response.put("message", "Vui lòng nhập Email hợp lệ !");
            return response;
        }

        Pattern strongPassword = Pattern.compile(
                "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$");

        if (!strongPassword.matcher(password).matches()) {
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
}