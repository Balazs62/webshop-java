package com.webshop.repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.webshop.model.Order;
import com.webshop.model.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
	
    @Query(value = "SELECT SUM(total_price) FROM orders", nativeQuery = true)
    Optional<BigDecimal> getTotalRevenueNative();
	
    List<Order> findByUserOrderByOrderDateDesc(User user);
    
    List<Order> findTop5ByOrderByOrderDateDesc();
}