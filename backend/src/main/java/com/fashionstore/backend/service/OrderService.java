package com.fashionstore.backend.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fashionstore.backend.entity.Order;
import com.fashionstore.backend.entity.User;
import com.fashionstore.backend.repository.OrderRepository;
import com.fashionstore.backend.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserRepository userRepository;

    private final ObjectMapper objectMapper = new ObjectMapper();

    public Map<String, Object> placeOrder(
            Long userId,
            List<Map<String, Object>> items,
            Map<String, Object> address,
            Double amount) {

        Map<String, Object> response = new HashMap<>();

        try {

            if (items == null || items.isEmpty()) {
                response.put("success", false);
                response.put("message", "Giỏ hàng trống");
                return response;
            }

            Order order = new Order();

            order.setUserId(userId);
            order.setItems(objectMapper.writeValueAsString(items));
            order.setAddress(objectMapper.writeValueAsString(address));
            order.setAmount(amount);
            order.setPaymentMethod("cod");
            order.setPayment(false);

            orderRepository.save(order);

            User user = userRepository.findById(userId).orElse(null);

            if (user != null) {
                user.setCartData("{}");
                userRepository.save(user);
            }

            response.put("success", true);
            response.put("message", "Đặt hàng thành công!");

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
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
}
