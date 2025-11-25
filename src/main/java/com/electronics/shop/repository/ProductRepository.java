package com.electronics.shop.repository;

import com.electronics.shop.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findByIsActiveTrue();

    List<Product> findByIsActiveTrueAndIsNewTrue(Pageable pageable);

    List<Product> findByIsActiveTrueAndIsFeaturedTrue(Pageable pageable);

    List<Product> findByIsActiveTrueAndIsTopSellingTrue(Pageable pageable);

    Page<Product> findByIsActiveTrue(Pageable pageable);

    // Search and Filter
    @Query("SELECT p FROM Product p WHERE p.isActive = true " +
            "AND (:categoryId IS NULL OR p.category.id = :categoryId) " +
            "AND (:keyword IS NULL OR p.name LIKE %:keyword%) " +
            "AND (:maxPrice IS NULL OR (p.productPrice.salePrice > 0 AND p.productPrice.salePrice <= :maxPrice) OR (p.productPrice.salePrice IS NULL AND p.productPrice.price <= :maxPrice))")
    Page<Product> searchProducts(Integer categoryId, String keyword, Double maxPrice, Pageable pageable);
}
