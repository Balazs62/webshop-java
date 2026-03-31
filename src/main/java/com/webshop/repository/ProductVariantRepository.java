package com.webshop.repository;

import com.webshop.model.ProductVariant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductVariantRepository extends JpaRepository<ProductVariant, Long> {
    // Itt nem kell metódusokat írnod, 
    // a JpaRepository-ból megkapod a save(), findAll(), count() stb. parancsokat.
}