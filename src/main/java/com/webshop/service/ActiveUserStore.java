package com.webshop.service;

import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

 @Component
public class ActiveUserStore implements HttpSessionListener {
	
	private final AtomicInteger activeSessions = new AtomicInteger(0);
	
	public void increment() {
		activeSessions.incrementAndGet();
	}
	
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		Object isCounted = event.getSession().getAttribute("isCountedUser");
		if (isCounted != null && (boolean) isCounted) {
			if (activeSessions.get() > 0) {
			activeSessions.decrementAndGet();
			}
		}
	}
	

	public int getActiveUsers() {
		return activeSessions.get();	
	}
	
}
