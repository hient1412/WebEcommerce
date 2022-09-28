/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.tmdt.pojos.Seller;
import com.tmdt.repository.SellerRepository;
import com.tmdt.service.SellerService;
import java.io.IOException;
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
}
