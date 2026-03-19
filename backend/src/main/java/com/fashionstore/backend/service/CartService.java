package com.fashionstore.backend.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.fashionstore.backend.entity.User;
import com.fashionstore.backend.entity.Product;
import com.fashionstore.backend.repository.ProductRepository;
import com.fashionstore.backend.repository.UserRepository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

@Service
public class CartService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

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

    public Map<String, Object> addToCart(Long userId, String itemId, String size, String color) {

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
            if (size == null || size.isBlank() || color == null || color.isBlank()) {
                response.put("success", false);
                response.put("message", "Vui lòng chọn size và màu sắc !");
                return response;
            }

            User user = userRepository.findById(userId).orElse(null);

            if (user == null) {
                response.put("success", false);
                response.put("message", "User không tồn tại");
                return response;
            }

            Product product = productRepository.findById(Long.parseLong(itemId)).orElse(null);

            if (product == null) {
                response.put("success", false);
                response.put("message", "Sản phẩm không tồn tại");
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

            String variantKey = buildVariantKey(size, color);
            int availableStock = product.getInventory().getOrDefault(variantKey, 0);
            int currentQuantity = cartData.getOrDefault(itemId, new HashMap<>()).getOrDefault(variantKey, 0);

            if (currentQuantity + 1 > availableStock) {
                response.put("success", false);
                response.put("availableStock", availableStock);
                response.put("message", buildInsufficientStockMessage(availableStock));
                return response;
            }

            if (cartData.containsKey(itemId)) {

                Map<String, Integer> sizeMap = cartData.get(itemId);

                if (sizeMap.containsKey(variantKey)) {

                    sizeMap.put(variantKey, sizeMap.get(variantKey) + 1);

                } else {

                    sizeMap.put(variantKey, 1);
                }

            } else {

                Map<String, Integer> sizeMap = new HashMap<>();
                sizeMap.put(variantKey, 1);

                cartData.put(itemId, sizeMap);
            }

            String updatedCart = objectMapper.writeValueAsString(cartData);

            user.setCartData(updatedCart);

            userRepository.save(user);

            response.put("success", true);
            response.put("message", "Đã thêm vào giỏ hàng!");
            response.put("cartData", cartData);

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    public Map<String, Object> updateCart(Long userId, String itemId, String size, String color, Integer quantity) {

        Map<String, Object> response = new HashMap<>();

        try {
            if (size == null || size.isBlank() || color == null || color.isBlank()) {
                response.put("success", false);
                response.put("message", "Thiếu biến thể sản phẩm");
                return response;
            }

            if (quantity == null) {
                response.put("success", false);
                response.put("message", "Số lượng không hợp lệ");
                return response;
            }

            User user = userRepository.findById(userId).orElse(null);

            if (user == null) {
                response.put("success", false);
                response.put("message", "User không tồn tại");
                return response;
            }

            Product product = productRepository.findById(Long.parseLong(itemId)).orElse(null);

            if (product == null) {
                response.put("success", false);
                response.put("message", "Sản phẩm không tồn tại");
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

            String variantKey = buildVariantKey(size, color);
            int availableStock = product.getInventory().getOrDefault(variantKey, 0);

            if (quantity > availableStock) {
                response.put("success", false);
                response.put("availableStock", availableStock);
                response.put("message", buildInsufficientStockMessage(availableStock));
                return response;
            }

            if (cartData.containsKey(itemId)) {

                Map<String, Integer> sizeMap = cartData.get(itemId);

                if (quantity <= 0) {
                    sizeMap.remove(variantKey);
                } else {
                    sizeMap.put(variantKey, quantity);
                }

                if (sizeMap.isEmpty()) {
                    cartData.remove(itemId);
                }

            }

            String updatedCart = objectMapper.writeValueAsString(cartData);

            user.setCartData(updatedCart);

            userRepository.save(user);

            response.put("success", true);
            response.put("message", "Đã cập nhật giỏ hàng!");
            response.put("cartData", cartData);

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    private String buildVariantKey(String size, String color) {
        return size.trim() + "__" + color.trim();
    }

    private String buildInsufficientStockMessage(int availableStock) {
        if (availableStock <= 0) {
            return "Sản phẩm này hiện đã hết hàng.";
        }

        return "Số lượng còn lại không đủ. Chỉ còn " + availableStock + " sản phẩm.";
    }
}
