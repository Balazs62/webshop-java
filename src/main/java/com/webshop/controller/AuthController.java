package com.webshop.controller;

import com.webshop.model.User;
import com.webshop.repository.UserRepository;
import com.webshop.service.CaptchaValidator;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
public class AuthController {
	
    @Autowired
    private UserRepository userRepository;
	
    @Autowired
    private PasswordEncoder passwordEncoder; 
    
    @Autowired
    private CaptchaValidator captchaValidator;
	
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "auth/register";
    }
	
    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") User user, 
                               BindingResult result, 
                               @RequestParam String confirmPassword,
                               @RequestParam("g-recaptcha-response") String captchaResponse,
                               Model model) {
	    
        if (!captchaValidator.isValid(captchaResponse)) {
            model.addAttribute("captchaError", "A biztonsági ellenőrzés sikertelen!");
            return "auth/register";
        }

        if (result.hasErrors()) {
            return "auth/register";
        }

        if (!user.getPassword().equals(confirmPassword)) {
            model.addAttribute("passwordError", "A két jelszó nem egyezik meg!");
            return "auth/register";
        }

        if (userRepository.findByEmail(user.getEmail()) != null) {
            model.addAttribute("emailError", "Ez az email már regisztrálva van!");
            return "auth/register";
        }

        if (userRepository.findByUsername(user.getUsername()) != null) {
            model.addAttribute("usernameError", "Ez a felhasználónév már foglalt!");
            return "auth/register";
        }
	    
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole("USER");
        user.setCreatedDate(LocalDate.now());
        userRepository.save(user);
	    
        return "redirect:/login?success";
    }
	
    @GetMapping("/login")
    public String showLoginForm() {
        return "auth/login";
    }
	
    @PostMapping("/login")
    public String loginUser(@RequestParam String email, 
                            @RequestParam String password, 
                            HttpSession session, 
                            Model model) {
        
        if (email == null || !email.contains("@") || email.length() > 100) {
            model.addAttribute("loginError", "Érvénytelen email formátum!");
            return "auth/login";
        }

        User user = userRepository.findByEmail(email);
        
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            session.setAttribute("user", user);
            return "redirect:/";
        }
        
        model.addAttribute("loginError", "Hibás email vagy jelszó!");
        return "auth/login";
    }
	
    @GetMapping("/account/profile")
    public String showProfile(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login"; 
        }
        return "account/profile";
    }
	
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}