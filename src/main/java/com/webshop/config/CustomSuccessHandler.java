package com.webshop.config;

import java.io.IOException;
import java.util.Set;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        // 1. Lekérjük a bejelentkezett felhasználó jogosultságait (Role-jait)
        Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());

        // 2. Logika az átirányításhoz
        if (roles.contains("ROLE_ADMIN")) {
            // Ha ADMIN, akkor az admin irányítópultra küldjük
            response.sendRedirect("/admin/dashboard");
        } else {
            // Mindenki mást a webshop főoldalára küldünk
            response.sendRedirect("/");
        }
    }
}