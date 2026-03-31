package com.webshop.model;

import java.math.BigDecimal;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "products")
public class Product{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private List<ProductVariant> productVariants;
	
	@Column(name = "name", nullable = false)
	private String name;
	
	@Column(name = "description", nullable = false)
	private String description;
	
	@Column(name = "baseprice", nullable = false)
	private BigDecimal baseprice;
	
	
	public String getName() {
	    return name;
	}

	public String getDescription() {
		return description;
	}
	
	public BigDecimal getBasePrice() {
	    return baseprice;
	}
	
	public Long getId() {
	    return id;
	}

	public List<ProductVariant> getProductVariants() {
	    return productVariants;
	}
	
	public Product() {
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public void setBasePrice(BigDecimal baseprice) {
		this.baseprice = baseprice;
	}
	
	public void setProductVariants(List<ProductVariant> productVariants) {
		this.productVariants = productVariants;		
	}
	
}