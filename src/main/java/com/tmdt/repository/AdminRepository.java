/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.repository;

import com.tmdt.pojos.Admin;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface AdminRepository {
    boolean addAdmin(Admin ad);
    Admin getAdById(int id);
    boolean updateAdmin(Admin ad);
    List<Admin> getAdEmail(String email);
    List<Admin> getAdPhone(String phone);
}
