package com.webshop.model;

import java.math.BigDecimal;

import jakarta.persistence.*;

@Entity
@Table(name = "order_items")
public class OrderItem{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "order_id", nullable = false)
	private Order order;
	
	@ManyToOne
	@JoinColumn(name = "variant_id", nullable = false)
	private ProductVariant variant;
	
	@Column(nullable = false)
	private Integer quantity;
	
	@Column(nullable = false)
	private BigDecimal price;
	
	public OrderItem() {}
	
	public Long getId() {
		return id;
	}
	
	public Order getOrder() {
		return order;
	}
	
	public ProductVariant getVariant() {
		return variant;
	}
	
	public Integer getQuantity() {
		return quantity;
	}
	
	public BigDecimal getPrice() {
		return price;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public void setOrder(Order order) {
		this.order = order;
	}
	
	public void setProductVariant(ProductVariant variant) {
		this.variant = variant;
	}
	
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	
}