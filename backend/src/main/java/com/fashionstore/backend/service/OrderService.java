package com.fashionstore.backend.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.fashionstore.backend.entity.Order;
import com.fashionstore.backend.entity.Product;
import com.fashionstore.backend.entity.User;
import com.fashionstore.backend.repository.OrderRepository;
import com.fashionstore.backend.repository.ProductRepository;
import com.fashionstore.backend.repository.UserRepository;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

    private final ObjectMapper objectMapper = new ObjectMapper();

    public Map<String, Object> placeOrder(
            Long userId,
            List<Map<String, Object>> items,
            Map<String, Object> address,
            Double amount,
            String paymentMethod) {

        Map<String, Object> response = new HashMap<>();

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        boolean isAdmin = auth.getAuthorities()
                .stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

        if (isAdmin) {
            response.put("success", false);
            response.put("message", "Admin không được phép đặt hàng");
            return response;
        }

        try {
            if (items == null || items.isEmpty()) {
                response.put("success", false);
                response.put("message", "Giỏ hàng trống");
                return response;
            }

            for (Map<String, Object> item : items) {
                Long productId = Long.valueOf(String.valueOf(item.get("id")));
                String size = String.valueOf(item.get("size"));
                String color = String.valueOf(item.get("color"));
                Integer quantity = Integer.valueOf(String.valueOf(item.get("quantity")));

                Product product = productRepository.findById(productId).orElse(null);

                if (product == null) {
                    response.put("success", false);
                    response.put("message", "Có sản phẩm không còn tồn tại");
                    return response;
                }

                String variantKey = buildVariantKey(size, color);
                int availableStock = product.getInventory().getOrDefault(variantKey, 0);

                if (availableStock < quantity) {
                    response.put("success", false);
                    response.put("message", "Sản phẩm " + product.getName() + " không đủ tồn kho");
                    return response;
                }
            }

            for (Map<String, Object> item : items) {
                Long productId = Long.valueOf(String.valueOf(item.get("id")));
                String size = String.valueOf(item.get("size"));
                String color = String.valueOf(item.get("color"));
                Integer quantity = Integer.valueOf(String.valueOf(item.get("quantity")));

                Product product = productRepository.findById(productId).orElse(null);
                String variantKey = buildVariantKey(size, color);
                int availableStock = product.getInventory().getOrDefault(variantKey, 0);
                product.getInventory().put(variantKey, availableStock - quantity);
                productRepository.save(product);
            }

            Order order = new Order();
            order.setUserId(userId);
            order.setItems(objectMapper.writeValueAsString(items));
            order.setAddress(objectMapper.writeValueAsString(address));
            order.setAmount(amount);
            order.setPaymentMethod(paymentMethod);

            if ("vnpay".equalsIgnoreCase(paymentMethod)) {
                order.setPayment(false);
                order.setStatus("Chờ thanh toán");
            } else {
                order.setPayment(false);
                order.setStatus("Đơn hàng đã đặt");
            }

            orderRepository.save(order);

            order.setTransactionRef(String.valueOf(order.getId()));
            orderRepository.save(order);

            if (!"vnpay".equalsIgnoreCase(paymentMethod)) {
                removeOrderedItemsFromCart(userId, items);
            }

            response.put("success", true);
            response.put("message", "Tạo đơn hàng thành công!");
            response.put("orderId", order.getId());

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    public void clearUserCart(Long userId) {
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            user.setCartData("{}");
            userRepository.save(user);
        }
    }

    public void removeOrderedItemsFromCart(Long userId, List<Map<String, Object>> items) {
        if (items == null || items.isEmpty()) {
            return;
        }

        User user = userRepository.findById(userId).orElse(null);

        if (user == null || user.getCartData() == null || user.getCartData().isBlank()) {
            return;
        }

        try {
            Map<String, Map<String, Integer>> cartData = objectMapper.readValue(
                    user.getCartData(),
                    new TypeReference<Map<String, Map<String, Integer>>>() {
                    });

            for (Map<String, Object> item : items) {
                String productId = String.valueOf(item.get("id"));
                String size = String.valueOf(item.get("size"));
                String color = String.valueOf(item.get("color"));
                Integer quantity = Integer.valueOf(String.valueOf(item.get("quantity")));
                String variantKey = buildVariantKey(size, color);

                if (!cartData.containsKey(productId)) {
                    continue;
                }

                Map<String, Integer> variantMap = cartData.get(productId);
                int currentQuantity = variantMap.getOrDefault(variantKey, 0);
                int remainingQuantity = currentQuantity - quantity;

                if (remainingQuantity > 0) {
                    variantMap.put(variantKey, remainingQuantity);
                } else {
                    variantMap.remove(variantKey);
                }

                if (variantMap.isEmpty()) {
                    cartData.remove(productId);
                }
            }

            user.setCartData(objectMapper.writeValueAsString(cartData));
            userRepository.save(user);
        } catch (Exception e) {
            throw new RuntimeException("Không thể cập nhật giỏ hàng sau khi đặt đơn", e);
        }
    }

    public void removeOrderedItemsFromCart(Long userId, String orderItemsJson) {
        try {
            List<Map<String, Object>> items = objectMapper.readValue(
                    orderItemsJson,
                    new TypeReference<List<Map<String, Object>>>() {
                    });
            removeOrderedItemsFromCart(userId, items);
        } catch (Exception e) {
            throw new RuntimeException("Không thể xử lý danh sách sản phẩm của đơn hàng", e);
        }
    }

    public Map<String, Object> userOrders(Long userId) {
        Map<String, Object> response = new HashMap<>();

        try {
            List<Order> orders = orderRepository.findByUserId(userId);

            if (!orders.isEmpty()) {
                response.put("success", true);
                response.put("orders", orders);
            } else {
                response.put("success", false);
                response.put("message", "Không tìm thấy đơn hàng nào !");
            }

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    public Map<String, Object> listOrders() {
        Map<String, Object> response = new HashMap<>();

        try {
            List<Order> orders = orderRepository.findAll();

            if (!orders.isEmpty()) {
                response.put("success", true);
                response.put("orders", orders);
            } else {
                response.put("success", false);
                response.put("message", "Không có đơn hàng nào");
            }

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    public Map<String, Object> updateStatus(Long orderId, String status) {
        Map<String, Object> response = new HashMap<>();

        try {
            Order order = orderRepository.findById(orderId).orElse(null);

            if (order == null) {
                response.put("success", false);
                response.put("message", "Order không tồn tại");
                return response;
            }

            order.setStatus(status);
            orderRepository.save(order);

            response.put("success", true);
            response.put("message", "Cập nhật trạng thái thành công");

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    private String buildVariantKey(String size, String color) {
        return size.trim() + "__" + color.trim();
    }
}
