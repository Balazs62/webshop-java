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
import com.webshop.model.Order;
import com.webshop.model.OrderItem;
import com.webshop.model.User;
import com.webshop.repository.AddressRepository;
import com.webshop.repository.OrderRepository;
import com.webshop.repository.ProductVariantRepository;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ProfileController {
	
	@Autowired
	private ProductVariantRepository productVariantRepository;
	
	@Autowired
	private AddressRepository addressRepository;
	
	@Autowired
	private OrderRepository orderRepository;

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
	        @Valid @ModelAttribute("newAddress") Address submittedAddress, 
	        BindingResult bindingResult, 
	        @RequestParam(value = "addressCategory", required = false) String category, 
	        @RequestParam(value = "sameAsShipping", required = false, defaultValue = "off") String sameAsShipping,
	        HttpSession session) {

	    // 1. Validációs hiba ellenőrzése
	    if (bindingResult.hasErrors()) {
	        return "redirect:/profile?error=invalidInput";
	    }
	    
	    try {
	        User user = (User) session.getAttribute("user");
	        if (user == null) return "redirect:/login";

	        boolean isCombined = "on".equals(sameAsShipping);

	        // 2. Lekérjük a felhasználó JELENLEGI címeit
	        List<Address> existingAddresses = addressRepository.findByUser(user);
	        
	        Address shipping = existingAddresses.stream()
	                .filter(Address::isShipping)
	                .findFirst()
	                .orElse(new Address());
	                
	        Address billing = existingAddresses.stream()
	                .filter(a -> a.isBilling() && !a.isShipping())
	                .findFirst()
	                .orElse(null);

	        // 3. Kombinált cím mentése / frissítése
	        if (isCombined) {
	            updateAddressFields(shipping, submittedAddress);
	            shipping.setUser(user);
	            shipping.setShipping(true);
	            shipping.setBilling(true);
	            addressRepository.save(shipping);

	            // Ha korábban volt külön számlázási címe, azt töröljük
	            if (billing != null) {
	                addressRepository.delete(billing);
	            }
	        } 
	        // 4. Különálló címek mentése / frissítése
	        else {
	            if ("SHIPPING".equals(category)) {
	                updateAddressFields(shipping, submittedAddress);
	                shipping.setUser(user);
	                shipping.setShipping(true);
	                shipping.setBilling(false);
	                addressRepository.save(shipping);
	                
	            } else if ("BILLING".equals(category)) {
	                if (billing == null) {
	                    billing = new Address();
	                    billing.setUser(user);
	                }
	                updateAddressFields(billing, submittedAddress);
	                billing.setShipping(false);
	                billing.setBilling(true);
	                addressRepository.save(billing);
	                
	                // Biztosítjuk, hogy a szállítási cím ne legyen többé számlázási is
	                if (shipping.getId() != null && shipping.isBilling()) {
	                    shipping.setBilling(false);
	                    addressRepository.save(shipping);
	                }
	            }
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/profile?error=serverError";
	    }
	    
	    return "redirect:/profile?success=true";
	}

	@PostMapping("/delete-address")
	public String deleteAddress(@RequestParam("addressId") Long addressId, HttpSession session) {
		
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

	// SEGÉDMETÓDUS: Átmásolja az űrlapból jött adatokat az adatbázisból betöltött címbe
	private void updateAddressFields(Address target, Address source) {
	    target.setZipCode(source.getZipCode() != null ? source.getZipCode().trim() : null);
	    target.setCity(source.getCity() != null ? source.getCity().trim() : null);
	    target.setStreet(source.getStreet() != null ? source.getStreet().trim() : null);
	    
	    String houseNum = source.getHouseNumber();
	    target.setHouseNumber((houseNum == null || houseNum.isBlank()) ? "-" : houseNum.trim());
	    
	    target.setBuilding(source.getBuilding() != null && !source.getBuilding().isBlank() ? source.getBuilding().trim() : null);
	    target.setApartment(source.getApartment() != null && !source.getApartment().isBlank() ? source.getApartment().trim() : null);
	    target.setFloor(source.getFloor() != null && !source.getFloor().isBlank() ? source.getFloor().trim() : null);
	    target.setDoor(source.getDoor() != null && !source.getDoor().isBlank() ? source.getDoor().trim() : null);
	}
	
	
	@org.springframework.transaction.annotation.Transactional(readOnly = true)
	@GetMapping("/my-orders")
	public String showMyOrders(HttpSession session, Model model) {
	    User user = (User) session.getAttribute("user");
	    if (user == null) return "redirect:/login";

	    List<Order> orders = orderRepository.findByUserOrderByOrderDateDesc(user);
	    
	    if (orders != null) {
	        for (Order order : orders) {
	            // Előre betöltjük a címeket és a tételeket
	            if (order.getShippingAddress() != null) order.getShippingAddress().getCity();
	            
	            if (order.getItems() != null) {
	                for (OrderItem item : order.getItems()) {
	                	
	                    if (item.getProductVariant() != null && item.getProductVariant().getProduct() != null) {
	                        item.getProductVariant().getProduct().getName();
	                        item.getProductVariant().getSize();
	                    }
	                }
	            }
	        }
	    }

	    model.addAttribute("orders", orders);
	    return "auth/orders";
	}
}