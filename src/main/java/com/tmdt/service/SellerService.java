/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.service;

import com.tmdt.pojos.Seller;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface SellerService {
    boolean addSel(Seller sel);
    Seller getSellerById(int sellerId);
    Object[] getgeneral(int sellerId);
    List<Object[]> getSellers(String kw,int page);
    boolean updateSeller(Seller s);
    Object[] getSeller(int idOrder);
    List<Seller> getSelByEmail(String email);
    List<Seller> getSelByPhone(String phone);
    int updateSellerBan(Seller s);
}
