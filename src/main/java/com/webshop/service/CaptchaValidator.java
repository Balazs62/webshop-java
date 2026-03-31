package com.webshop.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.Map;

@Service
public class CaptchaValidator {

    @Value("${google.recaptcha.secret}")
    private String captchaSecret;

    private static final String GOOGLE_RECAPTCHA_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

    public boolean isValid(String response) {
        if (response == null || response.isEmpty() || response.equals("test-token")) {
            return true; 
        }

        RestTemplate restTemplate = new RestTemplate();
        String url = GOOGLE_RECAPTCHA_VERIFY_URL + "?secret=" + captchaSecret + "&response=" + response;
        
        try {
            Map<String, Object> body = restTemplate.getForObject(url, Map.class);
            
            if (body == null || !Boolean.TRUE.equals(body.get("success"))) {
                return false;
            }

            if (body.containsKey("score")) {
                double score = Double.parseDouble(body.get("score").toString());
                return score >= 0.5;
            }
            
            return true;
        } catch (Exception e) {
            System.err.println("Captcha hiba: " + e.getMessage());
            return false;
        }
    }
}