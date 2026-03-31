package com.webshop.model;

import jakarta.persistence.*;

@Entity
@Table(name = "product_variants")
public class ProductVariant{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "product_id", nullable = false)
	private Product product;
	
	@Column(name = "size", nullable = false)
	private String size;
	
	@Column(name = "stock_quantity", nullable = false)
	private Integer stockQuantity;
	
	@Column(name = "color", nullable = false)
	private String color;
	
	public Long getId() {
		return id;
	}
	
	public Product getProduct() {
		return product;
	}
	
	public String getSize() {
		return size;
	}
	
	public Integer getStockQuantity() {
		return stockQuantity;
	}
	
	public String getColor() {
		return color;
	}
	
	
	public ProductVariant() {}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public void setProduct(Product product) {
		this.product = product;
	}
	
	public void setSize(String size) {
		this.size = size;
	}
	
	public void setStockQuantity(Integer stockQuantity) {
		this.stockQuantity = stockQuantity;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
}
