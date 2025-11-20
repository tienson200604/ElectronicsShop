package Model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
    // Map lưu trữ: <Product ID, CartItem>
    private Map<Integer, CartItem> items;
    
    public Cart() {
        items = new LinkedHashMap<>();
    }
    
    public Map<Integer, CartItem> getItems() {
        return items;
    }
    
    // Thêm hoặc cập nhật số lượng
    public void addItem(Product product, int quantity) {
        CartItem item = items.get(product.getId());
        if (item == null) {
            items.put(product.getId(), new CartItem(product, quantity));
        } else {
            item.setQuantity(item.getQuantity() + quantity);
        }
    }
    
    // Cập nhật số lượng mới (từ trang giỏ hàng)
    public void updateQuantity(int productId, int quantity) {
        CartItem item = items.get(productId);
        if (item != null) {
            item.setQuantity(quantity);
            if (quantity <= 0) {
                items.remove(productId);
            }
        }
    }
    
    // Xóa một mặt hàng
    public void removeItem(int productId) {
        items.remove(productId);
    }
    
    // Tính tổng tiền
    public double getSubtotal() {
        double total = 0;
        for (CartItem item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }
    
    // Giữ nguyên tổng cuối cùng bằng subtotal (có thể thêm phí ship sau)
    public double getFinalTotal() {
        return getSubtotal(); 
    }
}