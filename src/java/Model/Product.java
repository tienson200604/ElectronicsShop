package Model;

public class Product {

    private int id; // Đổi từ productId thành id
    private String name;
    private String shortDescription; // Thêm trường này
    private double price; // Giá gốc
    private double salePrice; // Giá khuyến mãi
    private String imagePath; // Lấy từ product_images.image_url
    private int categoryId;
    private String categoryName;
    private double effectivePrice;
    private String description;
    private int warrantyMonths;
    private String brandName;
    private int stockQuantity;
    

    public Product() {
    }

    public Product(int id, String name, String shortDescription, double price, double salePrice, String imagePath, int categoryId, String categoryName, double effectivePrice, String description, int warrantyMonths, String brandName, int stockQuantity) {
        this.id = id;
        this.name = name;
        this.shortDescription = shortDescription;
        this.price = price;
        this.salePrice = salePrice;
        this.imagePath = imagePath;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.effectivePrice = effectivePrice;
        this.description = description;
        this.warrantyMonths = warrantyMonths;
        this.brandName = brandName;
        this.stockQuantity = stockQuantity;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    

    public String getDescription() {
        return description;
    }

    public int getWarrantyMonths() {
        return warrantyMonths;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setWarrantyMonths(int warrantyMonths) {
        this.warrantyMonths = warrantyMonths;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public double getEffectivePrice() {
        return (salePrice > 0) ? salePrice : price;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setEffectivePrice(double effectivePrice) {
        this.effectivePrice = effectivePrice;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    // Phương thức tiện ích để lấy giá hiển thị (ưu tiên Sale Price nếu có)
    public double getDisplayPrice() {
        return (salePrice > 0) ? salePrice : price;
    }
}
