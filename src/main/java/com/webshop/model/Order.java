package com.webshop.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "orders")
public class Order {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
	private User user;

	@ManyToOne
	@JoinColumn(name = "shipping_address_id", nullable = false)
	private Address shippingAddress;

	@ManyToOne
	@JoinColumn(name = "billing_address_id", nullable = false)
	private Address billingAddress;
	
	@Column(name = "status", nullable = false)
	private String status;
	
	@Column(name = "total_price", nullable = false, precision = 12, scale = 2)
	private BigDecimal totalPrice;
	
	@Column(name = "payment_method", nullable = false)
	private String paymentMethod;
	
	@Column(name = "order_date", nullable = false)
	private LocalDateTime orderDate;

	// CascadeType.ALL: Ha mentjük az Order-t, mentse az OrderItem-eket is!
	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
	private List<OrderItem> items;
	
	public Order() {}

	// --- GETTEREK ---
	public Long getId() { return id; }
	public User getUser() { return user; }
	public Address getShippingAddress() { return shippingAddress; }
	public Address getBillingAddress() { return billingAddress; }
	public String getStatus() { return status; }
	public BigDecimal getTotalPrice() { return totalPrice; }
	public String getPaymentMethod() { return paymentMethod; }
	public LocalDateTime getOrderDate() { return orderDate; }
	public List<OrderItem> getItems() { return items; }

	// --- SETTEREK (Ezeket keresi a Controller) ---
	public void setId(Long id) { this.id = id; }
	public void setUser(User user) { this.user = user; }
	public void setShippingAddress(Address shippingAddress) { this.shippingAddress = shippingAddress; }
	public void setBillingAddress(Address billingAddress) { this.billingAddress = billingAddress; }
	public void setStatus(String status) { this.status = status; }
	public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }
	public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
	public void setOrderDate(LocalDateTime orderDate) { this.orderDate = orderDate; }
	public void setItems(List<OrderItem> items) { this.items = items; }
}