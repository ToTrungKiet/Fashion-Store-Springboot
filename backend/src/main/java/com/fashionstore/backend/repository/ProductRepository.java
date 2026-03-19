package com.fashionstore.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fashionstore.backend.entity.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {

    boolean existsByName(String name);
}
