package com.webshop.controller;

import com.webshop.model.Product;
import com.webshop.repository.*;
import org.springframework.ui.Model;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;



@Controller
public class MainController {
	
	@Autowired
    private ProductRepository productRepository;
	
    @GetMapping("/")
    public String index(Model model) {
    	List<Product> products = productRepository.findAll();

        model.addAttribute("products", products);
        return "home/index";
    }
}