package com.webshop.config;

import java.io.IOException;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component 
public class RateLimitingFilter implements Filter{

	private final Map<String, Bucket> buckets = new ConcurrentHashMap<>();
	
	private Bucket createNewBucket() {
		Bandwidth limit = Bandwidth.builder()
				.capacity(10)
				.refillIntervally(10, Duration.ofMinutes(1))
				.build();
		
		return Bucket.builder()
				.addLimit(limit)
				.build();
	}
	
	@Override
	@Order(1)
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest servletRequest = (HttpServletRequest) request;
		String path = servletRequest.getRequestURI();
		String method = servletRequest.getMethod();
		
		boolean isAuthEndpont = (path.equals("/login") || path.equals("/register"))
								&& method.equalsIgnoreCase("POST");
		
		if(!isAuthEndpont) {
			chain.doFilter(request, response);
			return;
		}
		
		
		String ip = request.getRemoteAddr();
		Bucket bucket = buckets.computeIfAbsent(ip, k -> createNewBucket());
		
		if(bucket.tryConsume(1)) {
			chain.doFilter(request, response);
		} else {
			HttpServletResponse servletResponse = (HttpServletResponse) response;
			servletResponse.setStatus(429);
			servletResponse.setContentType("text/plain; charset:utf-8");
			servletResponse.getWriter().write("Túl sok kérés! Próbáld újra később!");
		}
		
		}
}