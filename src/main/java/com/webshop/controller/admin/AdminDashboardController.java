package com.webshop.controller.admin;

import java.math.BigDecimal; // Fontos import!
import java.security.Principal;
import java.util.List; // Fontos import!

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.webshop.model.Order; // Be kell importálni az Order modellt!
import com.webshop.model.User;
import com.webshop.repository.OrderRepository;
import com.webshop.repository.ProductRepository;
import com.webshop.repository.UserRepository;
import com.webshop.service.ActiveUserStore;

@RequestMapping("/admin")
@Controller
public class AdminDashboardController {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private ProductRepository productRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	@Autowired
	private ActiveUserStore activeUserStore;
	
	@GetMapping("/dashboard")
	public String dashBoard(Model model, Principal principal) {

		long totalUsers = userRepository.count();
		long totalProducts = productRepository.count();
		long totalOrders = orderRepository.count();
		
		BigDecimal revenue = orderRepository.getTotalRevenueNative().orElse(BigDecimal.ZERO);
		
		int liveUsers = activeUserStore.getActiveUsers();
		
		
		model.addAttribute("totalUsers", totalUsers);
		model.addAttribute("totalProducts", totalProducts);
		model.addAttribute("totalOrders", totalOrders);
		model.addAttribute("liveUsers", liveUsers);
		model.addAttribute("totalRevenue", revenue);
		
		String adminName = (principal != null) ? principal.getName() : "Adminisztrátor";
	    model.addAttribute("adminName", adminName);
		
		return "admin/dashboard";
	}
	
	@GetMapping("/profile")
	public String showAdminProfile(Model model, Principal principal) {
		User user = userRepository.findByEmailOrUsername(principal.getName(), principal.getName()).get();
		model.addAttribute("user", user);
		return "admin/profile";
	}
}