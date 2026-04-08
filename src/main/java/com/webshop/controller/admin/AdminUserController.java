package com.webshop.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.webshop.model.User;
import com.webshop.repository.UserRepository;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/admin/users")
public class AdminUserController {
	
	@Autowired
	private UserRepository userRepository;
	
	private boolean isNotAdmin(HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		return user == null || !"ADMIN".equals(user.getRole());
	}
	
	
	// Felhasználók listázása
	@GetMapping("/list")
	public String listUsers(HttpSession session, Model model) {
		if (isNotAdmin(session)) {
			return "redirect:/login";
		}
		
		List<User> users = userRepository.findAll();
		model.addAttribute("users", users);
		
		
		return "admin/users/list";
	}
	
	
	// Felhasználói szerepkör módosítása
	@PostMapping("/updateRole")
	public String updateUserRole(@RequestParam Long userId, @RequestParam String newRole, HttpSession session) {
		if (isNotAdmin(session)) {
			return "redirect:/login";
		}
			
			userRepository.findById(userId).ifPresent(user -> {
				user.setRole(newRole);
				userRepository.save(user);
			});
			
			return "redirect:/admin/users/list?success=roleUpdated";
	}
	
	// User törlése
	@PostMapping("/delete")
	public String deleteUser(@RequestParam Long userId, HttpSession session) {
		if (isNotAdmin(session)) {
			return "redirect:/login";
		}
		
		User currentUser = (User) session.getAttribute("user");
		if (!currentUser.getId().equals(userId)) {
			userRepository.deleteById(userId);
		}
		
		return "redirect:/admin/users/list?success=userDeleted";
	}
	
	
	
	
	
}