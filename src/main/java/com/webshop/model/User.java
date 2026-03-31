package com.webshop.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Pattern(regexp = "^[a-zA-Z0-9._-]{3,20}$", message = "A felhasználónév csak betűket, számokat és . _ - karaktereket tartalmazhat!")
    @Column(nullable = false)
    @NotBlank(message = "A felhasználónév nem lehet üres!")
    private String username;

    @Column(nullable = false)
    @NotBlank(message = "Az email nem lehet üres!")
    @Email(message = "Érvénytelen email")
    private String email;

    @Column(nullable = false)
    @NotBlank(message = "A jelszó nem lehet üres!")
    @Size(min = 8, message = "A jelszónak hosszabbnak kell lennie mint 8 karakter!")
    private String password;

    @Column(nullable = false)
    private String role;

    @Column(name = "createddate", nullable = false)
    private LocalDate createdDate;
 
    public Long getId() {
    	return id;
    }
    
    public String getUsername() {
    	return username;
    }
    
    public String getEmail() {
    	return email;
    }
    
    public String getPassword() {
		return password;
	}
    
    public String getRole() {
    	return role;
    }
    
    public LocalDate getCreatedDate() {
		return createdDate;
	}
    
    
    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setCreatedDate(LocalDate createdDate) {
        this.createdDate = createdDate;
    }
    
  
    public User() {}

}