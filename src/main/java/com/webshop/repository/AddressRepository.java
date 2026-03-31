package com.webshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.webshop.model.Address;
import com.webshop.model.User;

@Repository
public interface AddressRepository extends JpaRepository<Address, Long> {
	
	List<Address> findByUser(User user);
}