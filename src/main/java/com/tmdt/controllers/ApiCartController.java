/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Cart;
import com.tmdt.pojos.Product;
import com.tmdt.service.ProductService;
import com.tmdt.utils.Utils;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author DELL
 */
@RestController
public class ApiCartController {

    @PostMapping("/api/cart")
    public int addProductIntoCart(@RequestBody Cart params, HttpSession session) {

        Map<Integer, Cart> cartProduct = (Map<Integer, Cart>) session.getAttribute("cartProduct");

        if (cartProduct == null) {
            cartProduct = new HashMap<>();
        }

        int productId = params.getProductId();
        if (cartProduct.containsKey(productId) == true) {
            Cart c = cartProduct.get(productId);
            c.setCount(c.getCount()+ 1);
        } else {
            cartProduct.put(productId, params);
        }

        session.setAttribute("cartProduct", cartProduct);

        return Utils.countCart(cartProduct);
    }

    @PutMapping("/api/cart")
    public int updateItemInCart(@RequestBody Cart params, HttpSession session) {
        Map<Integer, Cart> cartProduct = (Map<Integer, Cart>) session.getAttribute("cartProduct");

        if (cartProduct == null) {
            cartProduct = new HashMap<>();
        }

        int productId = params.getProductId();
        if (cartProduct.containsKey(productId) == true) {
            Cart c = cartProduct.get(productId);
            c.setCount(params.getCount());
        }

        session.setAttribute("cartProduct", cartProduct);

        return Utils.countCart(cartProduct);
    }

    @DeleteMapping("/api/cart/{productId}")
    public int deleteItemInCart(@PathVariable(value = "productId") int productId, HttpSession session) {
        Map<Integer, Cart> cartProduct = (Map<Integer, Cart>) session.getAttribute("cartProduct");
        if (cartProduct != null && cartProduct.containsKey(productId)) {
            cartProduct.remove(productId);
            session.setAttribute("cartProduct", cartProduct);
        }
        return Utils.countCart(cartProduct);
    }
}
