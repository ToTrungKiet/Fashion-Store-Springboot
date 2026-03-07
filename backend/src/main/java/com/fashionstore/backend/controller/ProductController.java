package com.fashionstore.backend.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.fashionstore.backend.dto.ProductRequest;
import com.fashionstore.backend.service.ProductService;

@RestController
@RequestMapping("/api/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping("/add")
    public ResponseEntity<?> addProduct(

            @RequestParam String name,
            @RequestParam String description,
            @RequestParam Double price,
            @RequestParam String category,
            @RequestParam String subCategory,
            @RequestParam String sizes,
            @RequestParam String bestseller,

            @RequestParam(required = false) MultipartFile image1,
            @RequestParam(required = false) MultipartFile image2,
            @RequestParam(required = false) MultipartFile image3,
            @RequestParam(required = false) MultipartFile image4

    ) {

        Map<String, Object> result = productService.addProduct(
                name,
                description,
                price,
                category,
                subCategory,
                sizes,
                bestseller,
                image1,
                image2,
                image3,
                image4);

        return ResponseEntity.ok(result);
    }

    @GetMapping("/list")
    public ResponseEntity<?> listProducts() {

        Map<String, Object> result = productService.listProducts();

        return ResponseEntity.ok(result);
    }

    @PostMapping("/single")
    public ResponseEntity<?> singleProduct(@RequestBody ProductRequest request) {

        Long productId = request.getProductId();

        Map<String, Object> result = productService.singleProduct(productId);

        return ResponseEntity.ok(result);
    }

    @PostMapping("/remove")
    public ResponseEntity<?> removeProduct(@RequestBody ProductRequest request) {

        Long productId = request.getProductId();

        Map<String, Object> result = productService.removeProduct(productId);

        return ResponseEntity.ok(result);
    }
}