package com.webshop.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Pattern;

@Entity
@Table(name = "addresses")
public class Address {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;
	
    // Boolean alapú megkülönböztetés
	@Column(name = "is_billing", nullable = false)
	private boolean billing; 

	@Column(name = "is_shipping", nullable = false)
	private boolean shipping;
	
	@Pattern(regexp = "^[a-zA-ZáéíóöőúüűÁÉÍÓÖŐÚÜŰ\\s\\-\\.]*$", message = "A város neve nem tartalmazhat speciális karaktereket (pl. % vagy $)")
	@Column(nullable = false)
	private String city;
	
	@Pattern(regexp = "^[0-9]{4}$", message = "Az irányítószám pontosan 4 számjegy lehet")
	@Column(name = "zip_code", nullable = false)
	private String zipCode;
	
	@Pattern(regexp = "^[a-zA-ZáéíóöőúüűÁÉÍÓÖŐÚÜŰ\\s\\-\\.]*$", message = "Az utca neve nem tartalmazhat speciális karaktereket (pl. % vagy $)")
	@Column(nullable = false)
	private String street;
	
	@Column(name ="house_number", nullable = false)
	private String houseNumber;
	
	private String apartment;
	private String building;
	private String door;
	private String floor;

	public Address() {}

	// --- GETTEREK ---
	public Long getId() { return id; }
	public User getUser() { return user; }
	public boolean isBilling() { return billing; } // Boolean-nál 'is' a szokásos kezdés
	public boolean isShipping() { return shipping; }
	public String getCity() { return city; }
	public String getZipCode() { return zipCode; }
	public String getStreet() { return street; }
	public String getHouseNumber() { return houseNumber; }
	public String getApartment() { return apartment; }
	public String getBuilding() { return building; }
	public String getDoor() { return door; }
	public String getFloor() { return floor; }

	// --- SETTEREK ---
	public void setId(Long id) { this.id = id; }
	public void setUser(User user) { this.user = user; }
	public void setBilling(boolean billing) { this.billing = billing; }
	public void setShipping(boolean shipping) { this.shipping = shipping; }
	public void setCity(String city) { this.city = city; }
	public void setZipCode(String zipCode) { this.zipCode = zipCode; }
	public void setStreet(String street) { this.street = street; }
	public void setHouseNumber(String houseNumber) { this.houseNumber = houseNumber; }
	public void setApartment(String apartment) { this.apartment = apartment; }
	public void setBuilding(String building) { this.building = building; }
	public void setDoor(String door) { this.door = door; }
	public void setFloor(String floor) { this.floor = floor; }
}