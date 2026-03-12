package com.fashionstore.backend.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.fashionstore.backend.entity.User;
import com.fashionstore.backend.repository.UserRepository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

@Service
public class CartService {

    @Autowired
    private UserRepository userRepository;

    private final ObjectMapper objectMapper = new ObjectMapper();

    public Map<String, Object> getUserCart(Long userId) {

        Map<String, Object> response = new HashMap<>();

        try {

            User user = userRepository.findById(userId).orElse(null);

            if (user == null) {

                response.put("success", false);
                response.put("message", "Không tìm thấy user!");

                return response;
            }

            Map<String, Map<String, Integer>> cartData = objectMapper.readValue(
                    user.getCartData(),
                    new TypeReference<Map<String, Map<String, Integer>>>() {
                    });

            response.put("success", true);
            response.put("cartData", cartData);

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", "Lỗi khi lấy giỏ hàng!");

        }

        return response;
    }

    public Map<String, Object> addToCart(Long userId, String itemId, String size) {

        Map<String, Object> response = new HashMap<>();

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        boolean isAdmin = auth.getAuthorities()
                .stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

        // Chặn ADMIN đặt hàng
        if (isAdmin) {
            response.put("success", false);
            response.put("message", "Admin không được thêm sản phẩm !");
            return response;
        }

        try {

            User user = userRepository.findById(userId).orElse(null);

            if (user == null) {
                response.put("success", false);
                response.put("message", "User không tồn tại");
                return response;
            }

            Map<String, Map<String, Integer>> cartData;

            if (user.getCartData() == null || user.getCartData().isEmpty()) {

                cartData = new HashMap<>();

            } else {

                cartData = objectMapper.readValue(
                        user.getCartData(),
                        new TypeReference<Map<String, Map<String, Integer>>>() {
                        });
            }

            if (cartData.containsKey(itemId)) {

                Map<String, Integer> sizeMap = cartData.get(itemId);

                if (sizeMap.containsKey(size)) {

                    sizeMap.put(size, sizeMap.get(size) + 1);

                } else {

                    sizeMap.put(size, 1);
                }

            } else {

                Map<String, Integer> sizeMap = new HashMap<>();
                sizeMap.put(size, 1);

                cartData.put(itemId, sizeMap);
            }

            String updatedCart = objectMapper.writeValueAsString(cartData);

            user.setCartData(updatedCart);

            userRepository.save(user);

            response.put("success", true);
            response.put("message", "Đã thêm vào giỏ hàng!");

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    public Map<String, Object> updateCart(Long userId, String itemId, String size, Integer quantity) {

        Map<String, Object> response = new HashMap<>();

        try {

            User user = userRepository.findById(userId).orElse(null);

            if (user == null) {
                response.put("success", false);
                response.put("message", "User không tồn tại");
                return response;
            }

            Map<String, Map<String, Integer>> cartData;

            if (user.getCartData() == null || user.getCartData().isEmpty()) {

                cartData = new HashMap<>();

            } else {

                cartData = objectMapper.readValue(
                        user.getCartData(),
                        new TypeReference<Map<String, Map<String, Integer>>>() {
                        });
            }

            if (cartData.containsKey(itemId)) {

                Map<String, Integer> sizeMap = cartData.get(itemId);

                sizeMap.put(size, quantity);

            }

            String updatedCart = objectMapper.writeValueAsString(cartData);

            user.setCartData(updatedCart);

            userRepository.save(user);

            response.put("success", true);
            response.put("message", "Đã cập nhật giỏ hàng!");

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }
}