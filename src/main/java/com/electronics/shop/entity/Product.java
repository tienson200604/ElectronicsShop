package com.electronics.shop.entity;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;

    @Column(name = "short_description")
    private String shortDescription;

    private String description;

    @Column(name = "warranty_months")
    private Integer warrantyMonths;

    @Column(name = "stock_quantity")
    private Integer stockQuantity;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "is_new")
    private Boolean isNew;

    @Column(name = "is_featured")
    private Boolean isFeatured;

    @Column(name = "is_top_selling")
    private Boolean isTopSelling;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    @OneToOne(mappedBy = "product", fetch = FetchType.EAGER)
    private ProductPrice productPrice;

    @OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
    private List<ProductImage> productImages;

    // Transient fields for easier access in views
    @Transient
    public Double getPrice() {
        return productPrice != null ? productPrice.getPrice() : null;
    }

    @Transient
    public Double getSalePrice() {
        return productPrice != null ? productPrice.getSalePrice() : null;
    }

    @Transient
    public Double getEffectivePrice() {
        if (getSalePrice() != null && getSalePrice() > 0) {
            return getSalePrice();
        }
        return getPrice();
    }

    @Transient
    public String getImagePath() {
        if (productImages != null) {
            for (ProductImage img : productImages) {
                if (Boolean.TRUE.equals(img.getIsMain())) {
                    return img.getImageUrl();
                }
            }
        }
        return "img/default-product.png";
    }

    @Transient
    public Integer getCategoryId() {
        return category != null ? category.getId() : null;
    }

    @Transient
    public String getCategoryName() {
        return category != null ? category.getName() : null;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getWarrantyMonths() {
        return warrantyMonths;
    }

    public void setWarrantyMonths(Integer warrantyMonths) {
        this.warrantyMonths = warrantyMonths;
    }

    public Integer getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(Integer stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public Boolean getIsNew() {
        return isNew;
    }

    public void setIsNew(Boolean isNew) {
        this.isNew = isNew;
    }

    public Boolean getIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(Boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public Boolean getIsTopSelling() {
        return isTopSelling;
    }

    public void setIsTopSelling(Boolean isTopSelling) {
        this.isTopSelling = isTopSelling;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public ProductPrice getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(ProductPrice productPrice) {
        this.productPrice = productPrice;
    }

    public List<ProductImage> getProductImages() {
        return productImages;
    }

    public void setProductImages(List<ProductImage> productImages) {
        this.productImages = productImages;
    }
}
