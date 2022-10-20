/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.formatters;

import com.tmdt.pojos.Seller;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;

/**
 *
 * @author DELL
 */
public class SellerFormatter implements Formatter<Seller>{

    @Override
    public String print(Seller seller, Locale locale) {
        return String.valueOf(seller.getId());
    }

    @Override
    public Seller parse(String selId, Locale locale) throws ParseException {
        Seller sel = new Seller();
        sel.setId(Integer.parseInt(selId));
        return sel;
    }
}
