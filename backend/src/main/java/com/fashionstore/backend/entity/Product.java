package com.fashionstore.backend.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Entity
@Table(name = "products")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String description;

    private Double price;

    private String category;

    private String subCategory;

    private Boolean bestseller;

    @ElementCollection
    private List<String> sizes;

    @ElementCollection
    private List<String> image;

    @ElementCollection
    @CollectionTable(name = "product_inventory", joinColumns = @JoinColumn(name = "product_id"))
    @MapKeyColumn(name = "variant_key")
    @Column(name = "quantity")
    private Map<String, Integer> inventory = new HashMap<>();

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @PrePersist
    public void prePersist(){
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate(){
        updatedAt = LocalDateTime.now();
    }
}
