/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Cart;
import com.tmdt.service.AccountService;
import com.tmdt.service.CustomerService;
import com.tmdt.service.SellerService;
import com.tmdt.utils.Utils;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

/**
 *
 * @author DELL
 */
@Controller
public class CartController {

    @Autowired
    private AccountService userDetailsService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private SellerService sellerService;
    
    @GetMapping("/cart")
    public String cart(Model model, HttpSession session) {
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) session.getAttribute("cartProduct")));
        Map<Integer, Cart> cartProduct = (Map<Integer, Cart>) session.getAttribute("cartProduct");

        if (cartProduct != null) {
            model.addAttribute("cartProducts", cartProduct.values());
        } else {
            model.addAttribute("cartProducts", null);
        }
         model.addAttribute("cart", cartProduct);
        model.addAttribute("cartAmount", Utils.cartAmount(cartProduct));
        model.addAttribute("seller", this.sellerService);
        return "cart";
    }
}
