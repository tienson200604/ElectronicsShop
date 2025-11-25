package com.electronics.shop.service;

import com.electronics.shop.entity.Product;
import com.electronics.shop.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    public List<Product> getNewProducts(int limit) {
        return productRepository
                .findByIsActiveTrueAndIsNewTrue(PageRequest.of(0, limit, Sort.by(Sort.Direction.DESC, "createdAt")));
    }

    public List<Product> getFeaturedProducts(int limit) {
        return productRepository
                .findByIsActiveTrueAndIsFeaturedTrue(PageRequest.of(0, limit, Sort.by(Sort.Direction.DESC, "id")));
    }

    public List<Product> getTopSellingProducts(int limit) {
        return productRepository
                .findByIsActiveTrueAndIsTopSellingTrue(PageRequest.of(0, limit, Sort.by(Sort.Direction.DESC, "id")));
    }

    public Page<Product> getAllProducts(int page, int size) {
        return productRepository.findByIsActiveTrue(PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "id")));
    }

    public Page<Product> searchProducts(Integer categoryId, String keyword, Double maxPrice, int page, int size,
            String sort) {
        Sort sortObj = Sort.by(Sort.Direction.DESC, "id");
        if ("priceAsc".equals(sort)) {
            sortObj = Sort.by(Sort.Direction.ASC, "productPrice.price"); // Note: This is a simplification, might need
                                                                         // custom query for effective price sort
        } else if ("priceDesc".equals(sort)) {
            sortObj = Sort.by(Sort.Direction.DESC, "productPrice.price");
        }

        return productRepository.searchProducts(categoryId, keyword, maxPrice, PageRequest.of(page, size, sortObj));
    }

    public Product getProductById(Integer id) {
        return productRepository.findById(id).orElse(null);
    }
}
