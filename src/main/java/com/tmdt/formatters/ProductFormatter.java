/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.formatters;

import com.tmdt.pojos.Product;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;

/**
 *
 * @author DELL
 */
public class ProductFormatter implements Formatter<Product>{

    @Override
    public String print(Product product, Locale locale) {
        return String.valueOf(product.getId());
    }

    @Override
    public Product parse(String productId, Locale locale) throws ParseException {
        Product pro = new Product();
        pro.setId(Integer.parseInt(productId));
        return pro;
    }
    
}
