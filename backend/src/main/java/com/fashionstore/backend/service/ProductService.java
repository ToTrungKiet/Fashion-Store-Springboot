package com.fashionstore.backend.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fashionstore.backend.entity.Product;
import com.fashionstore.backend.repository.ProductRepository;

import lombok.RequiredArgsConstructor;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@RequiredArgsConstructor
public class ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CloudinaryService cloudinaryService;

    public Map<String, Object> addProduct(
            String name,
            String description,
            Double price,
            String category,
            String subCategory,
            String sizes,
            String bestseller,
            MultipartFile image1,
            MultipartFile image2,
            MultipartFile image3,
            MultipartFile image4) {

        Map<String, Object> response = new HashMap<>();

        List<String> imageUrls = new ArrayList<>();

        List<MultipartFile> images = new ArrayList<>();

        images.add(image1);
        images.add(image2);
        images.add(image3);
        images.add(image4);

        for (MultipartFile image : images) {
            if (image != null && !image.isEmpty()) {
                String url = cloudinaryService.upload(image);
                imageUrls.add(url);
            }
        }

        ObjectMapper mapper = new ObjectMapper();
        List<String> sizeList = new ArrayList<>();

        try {
            sizeList = mapper.readValue(sizes, new TypeReference<List<String>>() {
            });
        } catch (Exception e) {
            throw new RuntimeException("Size không hợp lệ !");
        }

        try {

            Product product = new Product();

            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setCategory(category);
            product.setSubCategory(subCategory);
            product.setBestseller(bestseller.equals("true"));
            product.setSizes(sizeList);
            product.setImage(imageUrls);

            productRepository.save(product);

            response.put("success", true);
            response.put("message", "Thêm sản phẩm thành công !");
            response.put("product", product);

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", "Lỗi khi thêm sản phẩm !");
        }

        return response;
    }

    public Map<String, Object> listProducts() {

        Map<String, Object> response = new HashMap<>();

        try {

            List<Product> products = productRepository.findAll();

            response.put("success", true);
            response.put("products", products);

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", "Lỗi khi lấy danh sách sản phẩm !");
        }

        return response;
    }

    public Map<String, Object> singleProduct(Long productId) {

        Map<String, Object> response = new HashMap<>();

        try {

            Product product = productRepository.findById(productId).orElse(null);

            if (product == null) {
                response.put("success", false);
                response.put("message", "Không tìm thấy sản phẩm !");
                return response;
            }

            response.put("success", true);
            response.put("product", product);

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", "Lỗi khi lấy sản phẩm !");
        }

        return response;
    }

    public Map<String, Object> removeProduct(Long productId) {

        Map<String, Object> response = new HashMap<>();

        try {

            Product product = productRepository.findById(productId).orElse(null);

            if (product == null) {
                response.put("success", false);
                response.put("message", "Không tìm thấy sản phẩm !");
                return response;
            }

            productRepository.delete(product);

            response.put("success", true);
            response.put("message", "Xóa sản phẩm thành công !");

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", "Lỗi khi xóa sản phẩm !");
        }

        return response;
    }
}
