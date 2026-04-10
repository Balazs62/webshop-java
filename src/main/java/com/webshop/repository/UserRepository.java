package com.webshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.webshop.model.User;



@Repository
public interface UserRepository extends JpaRepository<User, Long> {
	
	Optional<User> findByEmail(String email);
	Optional<User> findByUsername(String username);
	
	Optional<User> findByEmailOrUsername(String email, String username);
	
	List<User> findByRoleNot(String role);
	
	long countByRoleNot(String role);
	
}