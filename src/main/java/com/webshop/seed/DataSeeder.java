package com.webshop.seed;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.webshop.model.User;
import com.webshop.repository.UserRepository;

@Component
public class DataSeeder implements CommandLineRunner {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;
	
	@Value("${ADMIN_EMAIL}")
	private String adminEmail;
	
	@Value("${ADMIN_PWD}")
	private String adminPassword;
	
	@Value("${ADMIN_USER}")
	private String adminUsername;
	
	public DataSeeder(UserRepository userRepository, PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
	}
	
	@Override
	public void run(String... args) throws Exception {
		Optional<User> existingAdmin = userRepository.findByEmail(adminEmail);
		if (existingAdmin.isEmpty()) {
			
			User admin = new User();
			admin.setEmail(adminEmail);
			admin.setUsername(adminUsername);
			admin.setPassword(passwordEncoder.encode(adminPassword));
			admin.setRole("ADMIN");
			admin.setCreatedDate(LocalDate.now());
			
			userRepository.save(admin);
			System.out.println("Admin user created: " + adminEmail);
		} else {
			System.out.println("Admin user already exists: " + adminEmail);
		}
	}
	
	
}
