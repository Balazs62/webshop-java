package com.webshop.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.webshop.model.User;
import com.webshop.repository.UserRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	private final UserRepository userRepository;
	
	public CustomUserDetailsService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	
	@Override
	public UserDetails loadUserByUsername(String identifier) throws UsernameNotFoundException {
	    System.out.println("--- LOGIN PRÓBÁLKOZÁS: " + identifier); // Ez meg fog jelenni a konzolon!
	    
	    User user = userRepository.findByEmailOrUsername(identifier, identifier)
	            .orElseThrow(() -> {
	                System.out.println("--- HIBA: Nem található ilyen user az adatbázisban!");
	                return new UsernameNotFoundException("Nem található: " + identifier);
	            });

	    System.out.println("--- SIKER: User megtalálva, jelszó ellenőrzése következik...");
	    return org.springframework.security.core.userdetails.User.withUsername(user.getEmail())
	        .password(user.getPassword())
	        .roles(user.getRole())
	        .build();
	}
}
