/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.Location;
import com.tmdt.repository.LocationRepository;
import com.tmdt.service.LocationService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class LocationServiceImply implements LocationService{

    @Autowired
    private LocationRepository locationRepository;
    
    @Override
    public List<Location> getLos() {
        return this.locationRepository.getLos();
    }
    
}
