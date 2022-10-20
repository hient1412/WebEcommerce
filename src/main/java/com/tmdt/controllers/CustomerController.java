/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Customer;
import com.tmdt.service.AccountService;
import com.tmdt.service.CustomerService;
import com.tmdt.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author DELL
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private AccountService accountService;
    @Autowired
    private LocationService locationService;
    @Autowired
    private CustomerService customerService;
    
    @GetMapping("/edit")
    public String customerEditView(Model model, Authentication authentication) {
        Account ac = this.accountService.getAcByUsername(authentication.getName());
        model.addAttribute("locations", this.locationService.getLos());
        model.addAttribute("customer", ac.getCustomer());
        return "customer-edit";
    }

    @PostMapping("/edit")
    public String customerEdit(Model model, @ModelAttribute(value = "customer") Customer customer, RedirectAttributes r,Authentication a) {
        Account ac = this.accountService.getAcByUsername(a.getName());
        Customer cusOld = this.customerService.getCusById(ac.getCustomer().getId());
        if(customer.getFile().isEmpty()){
            customer.setAvatar(cusOld.getAvatar());
        }
        if (this.customerService.updateCustomer(customer) == true) {
            r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
            return "redirect:/personal";
        } else {
            model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
        }
        return "customer-edit";
    }
}
