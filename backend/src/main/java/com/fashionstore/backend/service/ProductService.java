package com.fashionstore.backend.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
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

    private static final List<String> DEFAULT_COLORS = List.of("Đen", "Trắng", "Xám");

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
            String inventoryData,
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
            product.setInventory(parseInventory(inventoryData, sizeList));

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

    public Map<String, Object> updateProduct(
            Long id,
            String name,
            String description,
            Double price,
            String category,
            String subCategory,
            String sizes,
            String inventoryData,
            String bestseller,
            MultipartFile image1,
            MultipartFile image2,
            MultipartFile image3,
            MultipartFile image4) {

        Map<String, Object> response = new HashMap<>();

        try {

            Product product = productRepository.findById(id).orElse(null);

            if (product == null) {

                response.put("success", false);
                response.put("message", "Không tìm thấy sản phẩm !");
                return response;

            }

            if (name != null)
                product.setName(name);

            if (description != null)
                product.setDescription(description);

            if (price != null)
                product.setPrice(price);

            if (category != null)
                product.setCategory(category);

            if (subCategory != null)
                product.setSubCategory(subCategory);

            if (bestseller != null)
                product.setBestseller(bestseller.equals("true"));


            if (sizes != null) {

                ObjectMapper mapper = new ObjectMapper();

                List<String> sizeList = mapper.readValue(
                        sizes,
                        new TypeReference<List<String>>() {
                        });

                product.setSizes(sizeList);

            }

            if (inventoryData != null) {
                product.setInventory(parseInventory(
                        inventoryData,
                        product.getSizes() == null ? List.of() : product.getSizes()));
            }

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

            if (!imageUrls.isEmpty()) {

                product.setImage(imageUrls);

            }

            productRepository.save(product);

            response.put("success", true);
            response.put("message", "Cập nhật sản phẩm thành công !");
            response.put("product", product);

        } catch (Exception e) {

            response.put("success", false);
            response.put("message", "Lỗi khi cập nhật sản phẩm !");

        }

        return response;
    }

    public Map<String, Object> updateInventory(Long productId, Map<String, Integer> inventoryData) {

        Map<String, Object> response = new HashMap<>();

        try {
            Product product = productRepository.findById(productId).orElse(null);

            if (product == null) {
                response.put("success", false);
                response.put("message", "Không tìm thấy sản phẩm !");
                return response;
            }

            List<String> baseSizes = product.getSizes() == null ? List.of() : product.getSizes();
            Map<String, Integer> normalizedInventory = parseInventoryMap(inventoryData, baseSizes);
            product.setInventory(normalizedInventory);
            productRepository.save(product);

            response.put("success", true);
            response.put("message", "Cập nhật tồn kho thành công !");
            response.put("product", product);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi cập nhật tồn kho !");
        }

        return response;
    }

    private Map<String, Integer> parseInventory(String inventoryData, List<String> sizes) {
        Map<String, Integer> normalizedInventory = initializeInventory(sizes);

        if (inventoryData == null || inventoryData.isBlank()) {
            return normalizedInventory;
        }

        try {
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> rawInventory = mapper.readValue(
                    inventoryData,
                    new TypeReference<Map<String, Object>>() {
                    });

            for (Map.Entry<String, Object> entry : rawInventory.entrySet()) {
                String variantKey = entry.getKey();
                int quantity = Integer.parseInt(String.valueOf(entry.getValue()));

                if (normalizedInventory.containsKey(variantKey)) {
                    normalizedInventory.put(variantKey, Math.max(quantity, 0));
                }
            }

            return normalizedInventory;
        } catch (Exception e) {
            throw new RuntimeException("Dữ liệu tồn kho không hợp lệ !");
        }
    }

    private Map<String, Integer> parseInventoryMap(Map<String, Integer> inventoryData, List<String> sizes) {
        Map<String, Integer> normalizedInventory = initializeInventory(sizes);

        if (inventoryData == null || inventoryData.isEmpty()) {
          return normalizedInventory;
        }

        for (Map.Entry<String, Integer> entry : inventoryData.entrySet()) {
            if (normalizedInventory.containsKey(entry.getKey())) {
                normalizedInventory.put(entry.getKey(), Math.max(entry.getValue() == null ? 0 : entry.getValue(), 0));
            }
        }

        return normalizedInventory;
    }

    private Map<String, Integer> initializeInventory(List<String> sizes) {
        Map<String, Integer> normalizedInventory = new LinkedHashMap<>();

        for (String size : sizes) {
            for (String color : DEFAULT_COLORS) {
                normalizedInventory.put(buildVariantKey(size, color), 0);
            }
        }

        return normalizedInventory;
    }

    private String buildVariantKey(String size, String color) {
        return size.trim() + "__" + color.trim();
    }
}
