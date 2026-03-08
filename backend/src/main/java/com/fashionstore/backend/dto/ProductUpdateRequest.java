package com.fashionstore.backend.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class ProductUpdateRequest {

    private String id;

    private String name;

    private String description;

    private Double price;

    private String category;

    private String subCategory;

    private Boolean bestseller;

    private String sizes;

    private MultipartFile image1;
    private MultipartFile image2;
    private MultipartFile image3;
    private MultipartFile image4;
}