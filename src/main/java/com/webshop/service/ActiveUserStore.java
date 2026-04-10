package com.webshop.service;

import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

 @Component
public class ActiveUserStore implements HttpSessionListener {
	
	private final AtomicInteger activeSessions = new AtomicInteger(0);
	
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		activeSessions.incrementAndGet();
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		if(activeSessions.get() > 0) {
		activeSessions.decrementAndGet();
		}
	}
	

	public int getActiveUsers() {
		return activeSessions.get();	
	}
	
}
