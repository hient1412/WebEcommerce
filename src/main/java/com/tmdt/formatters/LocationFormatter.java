/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.formatters;

import com.tmdt.pojos.Location;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;

/**
 *
 * @author DELL
 */
public class LocationFormatter  implements Formatter<Location> {

    @Override
    public String print(Location location, Locale locale) {
        return String.valueOf(location.getId());
    }

    @Override
    public Location parse(String locationId, Locale locale) throws ParseException {
        Location loc = new Location();
        loc.setId(Integer.parseInt(locationId));
        return loc;
    }
    
}
