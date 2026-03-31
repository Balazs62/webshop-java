package com.webshop;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.webshop.repository.UserRepository;

@SpringBootApplication
public class WebshopApplication {

    public static void main(String[] args) {
        SpringApplication.run(WebshopApplication.class, args);
    }

    public CommandLineRunner test(UserRepository userRepository) {
        return args -> {
            System.out.println("KAPCSOLÓDÁS TESZTELÉSE...");
            long darab = userRepository.count();
            System.out.println("SIKER! A tábla elérhető. Rekordok száma: " + darab);
        };
    }
}