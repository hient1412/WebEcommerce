/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.tmdt.pojos.Account;
import com.tmdt.pojos.Seller;
import com.tmdt.repository.SellerRepository;
import com.tmdt.service.SellerService;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class SellerServiceImply implements SellerService{
    @Autowired
    private SellerRepository sellerRepository;
    @Autowired
    private Cloudinary cloudinary;

    @Override
    public boolean addSel(Seller sel) {
        if (!sel.getFile().isEmpty() || (sel.getAvatar() != null)) {
            try {
                Map r = this.cloudinary.uploader().upload(sel.getFile().getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                sel.setAvatar((String) r.get("secure_url"));
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        } else{
            sel.setAvatar("https://png.pngtree.com/element_our/png_detail/20181229/vector-shop-icon-png_302739.jpg");
        }
        return this.sellerRepository.addSel(sel);
    }

    @Override
    public Seller getSellerById(int sellerId) {
        return this.sellerRepository.getSellerById(sellerId);
    }

    @Override
    public Object[] getgeneral(int sellerId) {
        return this.sellerRepository.getgeneral(sellerId);
    }

    @Override
    public List<Object[]> getSellers(String kw,int page) {
        return this.sellerRepository.getSellers(kw,page);
    }

    @Override
    public boolean updateSeller(Seller s) {
        if (!s.getFile().isEmpty()) {
            try {
                Map r = this.cloudinary.uploader().upload(s.getFile().getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                s.setAvatar((String) r.get("secure_url"));
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        } else{
            s.setAvatar(s.getAvatar());
        }
        return this.sellerRepository.updateSeller(s);
    }

    @Override
    public Object[] getSeller(int idOrder) {
        return this.sellerRepository.getSeller(idOrder);
    }

    @Override
    public List<Seller> getSelByEmail(String email) {
        return this.sellerRepository.getSelByEmail(email);
    }

    @Override
    public List<Seller> getSelByPhone(String phone) {
        return this.sellerRepository.getSelByPhone(phone);
    }

    @Override
    public int updateSellerBan(Seller s) {
        return this.sellerRepository.updateSellerBan(s);
    }

    @Override
    public List<Seller> getSelId(int sellerId) {
        return this.sellerRepository.getSelId(sellerId);
    }

}
