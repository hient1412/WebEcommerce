/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.formatters;

import com.tmdt.pojos.Customer;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;

/**
 *
 * @author DELL
 */
public class CustomerFormatter implements Formatter<Customer>{

    @Override
    public String print(Customer customer, Locale locale) {
        return String.valueOf(customer.getId());
    }

    @Override
    public Customer parse(String cusId, Locale locale) throws ParseException {
        Customer cus = new Customer();
        cus.setId(Integer.parseInt(cusId));
        return cus;
    }
    
}
