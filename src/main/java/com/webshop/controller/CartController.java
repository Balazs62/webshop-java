package com.webshop.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.webshop.model.Address;
import com.webshop.model.CartItem;
import com.webshop.model.Order;
import com.webshop.model.OrderItem;
import com.webshop.model.Product;
import com.webshop.model.ProductVariant;
import com.webshop.model.User;
import com.webshop.repository.OrderItemRepository;
import com.webshop.repository.OrderRepository;
import com.webshop.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private com.webshop.repository.AddressRepository addressRepository;
    
    @Autowired
    private OrderRepository orderRepository;
    
    private int calculateTotalQuantity(List<CartItem> cart) {
        if (cart == null) return 0;
        return cart.stream().mapToInt(CartItem::getQuantity).sum();
    }

    @PostMapping("/api/add")
    @ResponseBody
    public java.util.Map<String, Object> addApi(@RequestParam Long productId, @RequestParam String size, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        java.util.Map<String, Object> response = new java.util.HashMap<>();
        Product product = productRepository.findById(productId).orElse(null);
        
        if (product != null) {
            boolean found = false;
            for (CartItem item : cart) {
                if (item.getProductId().equals(productId) && item.getSize().equals(size)) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    break;
                }
            }
            if (!found) {
                cart.add(new CartItem(productId, product.getName(), size, product.getBasePrice(), 1));
            }
            
            int newCount = calculateTotalQuantity(cart);
            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", newCount);
            
            response.put("success", true);
            response.put("cartCount", newCount);
            response.put("message", "Sikeresen hozzáadva!");
        } else {
            response.put("success", false);
            response.put("message", "Hiba: A termék nem található.");
        }
        
        return response;
    }

    @GetMapping("/view")
    public String viewCart(HttpSession session, Model model) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        java.math.BigDecimal total = java.math.BigDecimal.ZERO;

        if (cart != null) {
            for (CartItem item : cart) {
                
                java.math.BigDecimal quantityBD = java.math.BigDecimal.valueOf(item.getQuantity());
                java.math.BigDecimal itemTotal = item.getPrice().multiply(quantityBD);
                
                total = total.add(itemTotal);
            }
        }
        
        model.addAttribute("cart", cart != null ? cart : new ArrayList<>());
        model.addAttribute("totalPrice", total);
        return "cart/cart";
    }

    @PostMapping("/update")
    public String updateQuantity(@RequestParam Long productId, @RequestParam String size, 
                                 @RequestParam String action, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        Product product = productRepository.findById(productId).orElse(null);
        if (cart != null && product != null) {
            for (CartItem item : cart) {
                if (item.getProductId().equals(productId) && item.getSize().equals(size)) {
                    if ("increase".equals(action)) {
                        int stock = product.getProductVariants().stream()
                                    .filter(v -> v.getSize().equals(size))
                                    .mapToInt(v -> v.getStockQuantity()).findFirst().orElse(0);
                        if (item.getQuantity() < stock) item.setQuantity(item.getQuantity() + 1);
                    } else if ("decrease".equals(action) && item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                    }
                    break;
                }
            }
            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", calculateTotalQuantity(cart));
        }
        return "redirect:/cart/view";
    }

    @PostMapping("/api/remove")
    @ResponseBody
    public java.util.Map<String, Object> removeApi(@RequestParam Long productId, @RequestParam String size, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        java.util.Map<String, Object> response = new java.util.HashMap<>();

        if (cart != null) {
            // Típusbiztos törlés: productId most már Long mindenhol
            cart.removeIf(item -> item.getProductId().equals(productId) && item.getSize().equals(size));
            
            int newCount = calculateTotalQuantity(cart);
            
            // Pontos végösszeg számítás BigDecimal-el
            java.math.BigDecimal newTotal = cart.stream()
                .map(item -> item.getPrice().multiply(java.math.BigDecimal.valueOf(item.getQuantity())))
                .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);

            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", newCount);
            
            response.put("success", true);
            response.put("cartCount", newCount);
            response.put("totalPrice", newTotal.toString());
            response.put("isEmpty", cart.isEmpty());
        } else {
            response.put("success", false);
        }
        return response;
    }

    // --- PÉNZTÁR MEGJELENÍTÉSE ---
    @GetMapping("/checkout")
    public String showCheckout(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) return "redirect:/cart/view";


        java.math.BigDecimal subtotal = cart.stream()
            .map(item -> item.getPrice().multiply(java.math.BigDecimal.valueOf(item.getQuantity())))
            .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);


        java.math.BigDecimal shipping = java.math.BigDecimal.valueOf(1990);

        java.math.BigDecimal totalPrice = subtotal.add(shipping);

        List<Address> all = addressRepository.findByUser(user);
        
        model.addAttribute("shippingAddresses", all.stream().filter(Address::isShipping).toList());
        model.addAttribute("billingAddresses", all.stream().filter(Address::isBilling).toList());
        
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("shippingCost", shipping);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);

        return "cart/checkout";
    }

    @PostMapping("/checkout")
    @Transactional
    public String placeOrder(@RequestParam Long shippingAddressId,
                             @RequestParam Long billingAddressId,
                             @RequestParam String paymentMethod,
                             HttpSession session) {
        
        User user = (User) session.getAttribute("user");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (user == null || cart == null || cart.isEmpty()) return "redirect:/cart/view";

        try {
            // 1. Rendelés (Order) alapadatok beállítása
            Order order = new Order();
            order.setUser(user);
            order.setShippingAddress(addressRepository.findById(shippingAddressId).orElseThrow());
            order.setBillingAddress(addressRepository.findById(billingAddressId).orElseThrow());
            order.setPaymentMethod(paymentMethod);
            order.setStatus("PENDING");
            order.setOrderDate(java.time.LocalDateTime.now());

            java.math.BigDecimal subtotal = java.math.BigDecimal.ZERO;
            List<OrderItem> orderItems = new ArrayList<>();

            for (CartItem item : cart) {
                Product product = productRepository.findById(item.getProductId()).orElseThrow();
                ProductVariant variant = product.getProductVariants().stream()
                    .filter(v -> v.getSize().equals(item.getSize()))
                    .findFirst()
                    .orElseThrow();


                if (variant.getStockQuantity() < item.getQuantity()) {
                    return "redirect:/cart/view?error=outOfStock&product=" + product.getName();
                }


                variant.setStockQuantity(variant.getStockQuantity() - item.getQuantity());

                OrderItem orderItem = new OrderItem();
                orderItem.setOrder(order);
                orderItem.setProductVariant(variant);
                orderItem.setQuantity(item.getQuantity());
                orderItem.setPrice(item.getPrice()); 

                orderItems.add(orderItem);
                

                java.math.BigDecimal lineTotal = item.getPrice().multiply(java.math.BigDecimal.valueOf(item.getQuantity()));
                subtotal = subtotal.add(lineTotal);
            }


            java.math.BigDecimal shipping = java.math.BigDecimal.valueOf(1990);
            order.setTotalPrice(subtotal.add(shipping));
            order.setItems(orderItems);

            orderRepository.save(order);

            session.removeAttribute("cart");
            session.setAttribute("cartCount", 0);

            return "redirect:/cart/success";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/cart/checkout?error=serverError";
        }
    }
    
    @PostMapping("/add-quick-address")
    @ResponseBody
    public String addQuickDoubleAddress(
            @RequestParam String s_zipCode, @RequestParam String s_city, 
            @RequestParam String s_street, @RequestParam String s_houseNumber,
            @RequestParam(required = false) String sameAsShipping,
            @RequestParam(required = false) String b_zipCode, @RequestParam(required = false) String b_city,
            @RequestParam(required = false) String b_street, @RequestParam(required = false) String b_houseNumber,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "error";


        Address shipping = new Address();
        shipping.setUser(user);
        shipping.setZipCode(s_zipCode);
        shipping.setCity(s_city);
        shipping.setStreet(s_street);
        shipping.setHouseNumber(s_houseNumber);
        shipping.setShipping(true);
        shipping.setBilling("on".equals(sameAsShipping)); 
        addressRepository.save(shipping);

        if (!"on".equals(sameAsShipping)) {
            Address billing = new Address();
            billing.setUser(user);
            billing.setZipCode(b_zipCode);
            billing.setCity(b_city);
            billing.setStreet(b_street);
            billing.setHouseNumber(b_houseNumber);
            billing.setShipping(false);
            billing.setBilling(true);
            addressRepository.save(billing);
        }

        return "ok";
    }
}