package com.webshop.repository;

import com.webshop.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    // Itt nem kell metódusokat írnod, 
    // a JpaRepository-ból megkapod a save(), findAll(), count() stb. parancsokat.
}