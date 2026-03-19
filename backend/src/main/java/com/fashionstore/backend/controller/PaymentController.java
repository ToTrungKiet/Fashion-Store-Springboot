package com.fashionstore.backend.controller;

import com.fashionstore.backend.entity.Order;
import com.fashionstore.backend.repository.OrderRepository;
import com.fashionstore.backend.service.OrderService;
import com.fashionstore.backend.service.VnPayService;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/payment")
public class PaymentController {

    @Autowired
    private VnPayService vnPayService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderService orderService;

    @Value("${frontend.url}")
    private String frontendUrl;

    @PostConstruct
    public void init() {
        System.out.println("=== PaymentController DA DUOC LOAD ===");
    }

    @GetMapping("/ping")
    public Map<String, Object> ping() {
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("message", "PaymentController OK");
        return res;
    }

    @PostMapping("/create-vnpay")
    public Map<String, Object> createVnPayPayment(
            @RequestBody Map<String, Object> data,
            HttpServletRequest request) {

        Map<String, Object> response = new HashMap<>();

        try {
            System.out.println("=== GOI API CREATE VNPAY ===");
            System.out.println("DATA NHAN DUOC: " + data);

            Long orderId = Long.parseLong(data.get("orderId").toString());

            Order order = orderRepository.findById(orderId).orElse(null);

            if (order == null) {
                response.put("success", false);
                response.put("message", "Không tìm thấy đơn hàng");
                return response;
            }

            Long userId = Long.parseLong(request.getAttribute("userId").toString());

            if (!order.getUserId().equals(userId)) {
                response.put("success", false);
                response.put("message", "Bạn không có quyền thanh toán đơn hàng này");
                return response;
            }

            if (!"vnpay".equalsIgnoreCase(order.getPaymentMethod())) {
                response.put("success", false);
                response.put("message", "Đơn hàng này không sử dụng VNPAY");
                return response;
            }

            if (Boolean.TRUE.equals(order.getPayment())) {
                response.put("success", false);
                response.put("message", "Đơn hàng này đã được thanh toán");
                return response;
            }

            String paymentUrl = vnPayService.createPaymentUrl(order.getId(), order.getAmount(), request);

            response.put("success", true);
            response.put("paymentUrl", paymentUrl);
            return response;

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
            return response;
        }
    }

    @GetMapping("/vnpay-return")
    public void vnpayReturn(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Map<String, String[]> params = request.getParameterMap();
            Map<String, String> fields = new HashMap<>();

            for (Map.Entry<String, String[]> entry : params.entrySet()) {
                fields.put(entry.getKey(), entry.getValue()[0]);
            }

            String txnRef = fields.get("vnp_TxnRef");
            String responseCode = fields.get("vnp_ResponseCode");

            boolean valid = vnPayService.validateCallback(new HashMap<>(fields));
            Order order = orderRepository.findByTransactionRef(txnRef).orElse(null);

            if (order == null) {
                response.sendRedirect(frontendUrl + "/orders?payment=notfound");
                return;
            }

            if (valid && "00".equals(responseCode)) {
                order.setPayment(true);
                order.setStatus("Đơn hàng đã đặt");
                orderRepository.save(order);

                orderService.removeOrderedItemsFromCart(order.getUserId(), order.getItems());

                response.sendRedirect(frontendUrl + "/orders?payment=success");
            } else {
                order.setPayment(false);
                order.setStatus("Chờ thanh toán");
                orderRepository.save(order);

                response.sendRedirect(frontendUrl + "/orders?payment=failed");
            }

        } catch (Exception e) {
            response.sendRedirect(frontendUrl + "/orders?payment=error");
        }
    }
}
