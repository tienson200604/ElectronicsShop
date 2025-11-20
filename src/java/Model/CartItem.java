package Model;

public class CartItem {
    private Product product;
    private int quantity;
    
    // Constructor
    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    // Phương thức tính tổng tiền của một mặt hàng
    public double getTotalPrice() {
        // Giả định Product có getEffectivePrice()
        return product.getEffectivePrice() * quantity; 
    }
}