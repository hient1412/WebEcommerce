/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.tmdt.pojos.Cart;
import com.tmdt.pojos.Customer;
import com.tmdt.repository.CustomerRepository;
import org.springframework.stereotype.Service;
import com.tmdt.service.CustomerService;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author DELL
 */
@Service
public class CustomerServiceImply implements CustomerService {

    @Autowired
    private Cloudinary cloudinary;
    @Autowired
    private CustomerRepository customerRepository;

    @Override
    public boolean addCus(Customer cus) {
        if (!cus.getFile().isEmpty() || (cus.getAvatar() != null)) {
            try {
                Map r = this.cloudinary.uploader().upload(cus.getFile().getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                cus.setAvatar((String) r.get("secure_url"));
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        } else if ("Nam".equals(cus.getGender())) {
            cus.setAvatar("https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg");
        } else if ("Nữ".equals(cus.getGender())) {
            cus.setAvatar("https://scr.vn/wp-content/uploads/2020/07/%E1%BA%A2nh-%C4%91%E1%BA%A1i-di%E1%BB%87n-FB-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-n%E1%BB%AF.jpg");
        } else {
            cus.setAvatar("https://scr.vn/wp-content/uploads/2020/07/%E1%BA%A2nh-%C4%91%E1%BA%A1i-di%E1%BB%87n-FB-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-n%E1%BB%AF.jpg");
        }
        return this.customerRepository.addCus(cus);
    }

    @Override
    public Customer getCusById(int id) {
        return this.customerRepository.getCusById(id);
    }

    @Override
    public boolean updateCustomer(Customer c) {
        if (!c.getFile().isEmpty()) {
            try {
                Map r = this.cloudinary.uploader().upload(c.getFile().getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                c.setAvatar((String) r.get("secure_url"));
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        } else {
            c.setAvatar(c.getAvatar());
        }
        return this.customerRepository.updateCustomer(c);
    }

    @Override
    public List<Customer> getCusEmail(String email) {
        return this.customerRepository.getCusEmail(email);
    }

    @Override
    public List<Customer> getCusPhone(String phone) {
        return this.customerRepository.getCusPhone(phone);
    }

}
