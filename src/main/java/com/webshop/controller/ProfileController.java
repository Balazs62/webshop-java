package com.webshop.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.webshop.model.Address;
import com.webshop.model.User;
import com.webshop.repository.AddressRepository;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ProfileController {
	
	@Autowired
	private AddressRepository addressRepository;

	@GetMapping("/profile")
	public String showProfile (HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		
		if(user == null) {
			return "redirect:/login";
		}
		List<Address> allAddressList = addressRepository.findByUser(user);
		
		List<Address> shippingList = new ArrayList<>();
		List<Address> billingList = new ArrayList<>();
		
		for(Address addr : allAddressList) {
			if(addr.isBilling()) {
				billingList.add(addr);
			}
			if (addr.isShipping()) {
				shippingList.add(addr);
			}
		}

		model.addAttribute("shippingAddresses", shippingList);
		model.addAttribute("billingAddresses", billingList);
		
		model.addAttribute("newAddress", new Address() );
		
		return "auth/profile";
	}
	
	@PostMapping("/add-address")
	public String addAddress(
	        @Valid @ModelAttribute("newAddress") Address address, 
	        BindingResult bindingResult, 
	        @RequestParam(value = "addressCategory", required = false) String category, 
	        @RequestParam(value = "sameAsShipping", required = false) String sameAsShipping,
	        HttpSession session,
	        Model model) {

	    // 1. Validációs hiba ellenőrzése (RegEx/Pattern hiba esetén)
	    if (bindingResult.hasErrors()) {
	        return "redirect:/profile?error=invalidInput";
	    }
	    
	    try {
	        User user = (User) session.getAttribute("user");
	        if (user == null) return "redirect:/login";

	        address.setUser(user);
	        
	        if ("on".equals(sameAsShipping)) {
	            address.setBilling(true);
	            address.setShipping(true);
	        } else {
	            if ("BILLING".equals(category)) {
	                address.setBilling(true);
	                address.setShipping(false);
	            } else {
	                address.setBilling(false);
	                address.setShipping(true);
	            }
	        }
	        
	        addressRepository.save(address);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/profile?error=serverError";
	    }
	    
	    return "redirect:/profile?success=true";
	}
	@PostMapping("/delete-address")
	public String deleteAddress(@RequestParam("addressId")Long addressId, HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		addressRepository.findById(addressId).ifPresent(address -> {
			if(address.getUser().getId().equals(user.getId())) {
				addressRepository.delete(address);
			}
		});
		return "redirect:/profile";
		
	}
}