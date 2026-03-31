package com.webshop.model;

import java.math.BigDecimal;

public class CartItem {
	private Long productId;
	private String name;
	private String size;
	private BigDecimal price;
	private Integer quantity;
	
public CartItem(Long productId, String name, String size, BigDecimal price, Integer quantity) {
    this.productId = productId;
    this.name = name;
    this.size = size;
    this.price = price;
    this.quantity = quantity;
}

	public Long getProductId() { return productId; }
	public String getName() { return name; }
	public String getSize() { return size; }
	public BigDecimal getPrice() { return price; }
	public Integer getQuantity() { return quantity; }
	
	public void setProductId(Long productId) {
		this.productId = productId;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setSize(String size) {
		this.size = size;
	}
	
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	
	public void setQuantity(int quantity) {
		if (quantity > 0) {
	        this.quantity = quantity;
		}
	}

}

