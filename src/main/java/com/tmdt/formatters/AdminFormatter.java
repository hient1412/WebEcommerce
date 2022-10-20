/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.formatters;

import com.tmdt.pojos.Admin;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;

/**
 *
 * @author DELL
 */
public class AdminFormatter implements Formatter<Admin>{

    @Override
    public String print(Admin ad, Locale locale) {
        return String.valueOf(ad.getId());
    }

    @Override
    public Admin parse(String adId, Locale locale) throws ParseException {
        Admin ad = new Admin();
        ad.setId(Integer.parseInt(adId));
        return ad;
    }
}