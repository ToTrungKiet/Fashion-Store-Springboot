package com.fashionstore.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.fashionstore.backend.service.OrderService;

import jakarta.servlet.http.HttpServletRequest;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @PostMapping("/place")
    public ResponseEntity<?> placeOrder(
            HttpServletRequest request,
            @RequestBody Map<String, Object> data) {

        Long userId = Long.parseLong(request.getAttribute("userId").toString());
        List<Map<String, Object>> items = (List<Map<String, Object>>) data.get("items");
        Map<String, Object> address = (Map<String, Object>) data.get("address");
        Double amount = Double.valueOf(data.get("amount").toString());
        String paymentMethod = data.get("paymentMethod").toString();

        Map<String, Object> result = orderService.placeOrder(userId, items, address, amount, paymentMethod);

        return ResponseEntity.ok(result);
    }

    @PostMapping("/user-orders")
    public Map<String, Object> userOrders(HttpServletRequest request) {
        Long userId = Long.parseLong(request.getAttribute("userId").toString());
        return orderService.userOrders(userId);
    }

    @PostMapping("/list")
    public Map<String, Object> listOrders() {
        return orderService.listOrders();
    }

    @PostMapping("/status")
    public Map<String, Object> updateStatus(@RequestBody Map<String, Object> data) {
        Long orderId = Long.parseLong(data.get("orderId").toString());
        String status = data.get("status").toString();
        return orderService.updateStatus(orderId, status);
    }
}