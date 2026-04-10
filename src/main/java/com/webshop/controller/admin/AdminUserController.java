package com.webshop.controller.admin;

import java.security.Principal;
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


@Controller
@RequestMapping("/admin/users")
public class AdminUserController {
	
	@Autowired
    private UserRepository userRepository;
    
    // NEM kell többé a session ellenőrzés, a SecurityConfig elintézi!
    
    @GetMapping("/list")
    public String listUsers(Model model) {
        List<User> users = userRepository.findAll();
        model.addAttribute("users", users);
        return "admin/users/list";
    }
    
    @PostMapping("/updateRole")
    public String updateUserRole(@RequestParam Long userId, @RequestParam String newRole) {
        userRepository.findById(userId).ifPresent(user -> {
            user.setRole(newRole);
            userRepository.save(user);
        });
        return "redirect:/admin/users/list?success=roleUpdated";
    }

    @PostMapping("/delete")
    public String deleteUser(@RequestParam Long userId, Principal principal) {
    	String loggedInUserEmail = principal.getName();
        
        userRepository.findByEmail(loggedInUserEmail).ifPresent(currentUser -> {
            if (!currentUser.getId().equals(userId)) {
                userRepository.deleteById(userId);
            }
        });
        return "redirect:/admin/users/list?success=userDeleted";
    }
	
	
	
	
		
}