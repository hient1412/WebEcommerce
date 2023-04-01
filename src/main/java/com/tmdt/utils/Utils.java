/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.utils;

import com.tmdt.pojos.Cart;
import com.tmdt.pojos.Seller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author DELL
 */
public class Utils {

    public static int countCart(Map<Integer, Cart> cart) {
        int count = 0;
        if (cart != null) {
            for (Cart c : cart.values()) {
                count += 1;
            }
        }
        return count;
    }

    public static Map<String, String> cartAmount(Map<Integer, Cart> cart) {
        Long sum = 0l;
        Long sumWithShip = 0l;
        int quantity = 0;
        if (cart != null) {
            for (Cart c : cart.values()) {
                quantity += c.getCount();
                sum += c.getCount() * c.getPrice();
            }
            sumWithShip = sum + 0;
        }
        Map<String, String> r = new HashMap<>();
        r.put("counter", String.valueOf(quantity));
        r.put("amount", String.valueOf(sum));
        r.put("amountWithShip", String.valueOf(sumWithShip));
        return r;
    }

    public static Map<String, String> cartAmountSeller(Map<Integer, Cart> cart, Seller s) {
        Long sum = 0l;
        int quantity = 0;
        if (cart != null) {
            for (Cart c : cart.values()) {
                if (s.equals(c.getSeller())) {
                    quantity += c.getCount();
                    sum += c.getCount() * c.getPrice();

                }
            }
        }
        Map<String, String> r = new HashMap<>();
        r.put("counter", String.valueOf(quantity));
        r.put("amount", String.valueOf(sum));
        return r;
    }
}
