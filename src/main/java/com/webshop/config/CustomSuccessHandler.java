package com.webshop.config;

import java.io.IOException;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.webshop.service.ActiveUserStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private ActiveUserStore activeUserStore;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
	                                    Authentication authentication) throws IOException, ServletException {

Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());
        
        boolean isAdmin = roles.contains("ADMIN") || roles.contains("ROLE_ADMIN");

        if (isAdmin) {
            response.sendRedirect("/admin/dashboard");
        } else {
            activeUserStore.increment();
            request.getSession().setAttribute("isCountedUser", true);
            response.sendRedirect("/");
        }
	}
}