package com.fashionstore.backend.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fashionstore.backend.dto.AddCartRequest;
import com.fashionstore.backend.dto.UpdateCartRequest;
import com.fashionstore.backend.service.CartService;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @PostMapping("/get")
    public ResponseEntity<?> getUserCart(HttpServletRequest request) {

        Long userId = Long.parseLong(request.getAttribute("userId").toString());

        Map<String, Object> result = cartService.getUserCart(userId);

        return ResponseEntity.ok(result);
    }

    @PostMapping("/add")
    public ResponseEntity<?> addToCart(
            HttpServletRequest request,
            @RequestBody AddCartRequest req) {

        Long userId = Long.parseLong(request.getAttribute("userId").toString());

        Map<String, Object> result = cartService.addToCart(userId, req.getItemId(), req.getSize(), req.getColor());

        return ResponseEntity.ok(result);
    }

    @PostMapping("/update")
    public ResponseEntity<?> updateCart(
            HttpServletRequest request,
            @RequestBody UpdateCartRequest req) {

        Long userId = Long.parseLong(request.getAttribute("userId").toString());

        Map<String, Object> result = cartService.updateCart(
                userId,
                req.getItemId(),
                req.getSize(),
                req.getColor(),
                req.getQuantity());

        return ResponseEntity.ok(result);
    }
}
