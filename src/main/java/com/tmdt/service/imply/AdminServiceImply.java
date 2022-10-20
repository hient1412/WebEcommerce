/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.Admin;
import com.tmdt.repository.AdminRepository;
import com.tmdt.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class AdminServiceImply implements AdminService{
    @Autowired
    private AdminRepository adminRepository;

    @Override
    public boolean addAdmin(Admin ad) {
        return this.adminRepository.addAdmin(ad);
    }

    @Override
    public Admin getAdById(int id) {
        return this.adminRepository.getAdById(id);
    }

    @Override
    public boolean updateAdmin(Admin ad) {
        return this.adminRepository.updateAdmin(ad);
    }
    
}
