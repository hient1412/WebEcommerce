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
import com.tmdt.service.OrderDetailService;
import com.tmdt.service.OrderService;
import com.tmdt.service.SellerService;
import com.tmdt.validator.CustomerValidator;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
    @Autowired
    private SellerService sellerService;
    @Autowired
    private CustomerValidator customerValidator;
    @Autowired
    private Environment env;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderDetailService orderDetailService;

    @GetMapping("/edit")
    public String customerEditView(Model model, Authentication authentication) {
        Account ac = this.accountService.getAcByUsername(authentication.getName());
        model.addAttribute("locations", this.locationService.getLos());
        model.addAttribute("customer", ac.getCustomer());
        return "customer-edit";
    }

    @PostMapping("/edit")
    public String customerEdit(Model model, @ModelAttribute(value = "customer") Customer customer, RedirectAttributes r,
            BindingResult br) {
        model.addAttribute("locations", this.locationService.getLos());
        Customer cusOld = this.customerService.getCusById(customer.getId());
        customerValidator.validate(customer, br);
        if (br.hasErrors()) {
            return "customer-edit";
        } else {
            if (customer.getFile().isEmpty()) {
                customer.setAvatar(cusOld.getAvatar());
            }
            if (!cusOld.getEmail().equals(customer.getEmail())) {
                if (this.customerService.getCusEmail(customer.getEmail()).size() > 0) {
                    model.addAttribute("errMessage", "Email đã tồn tại!!");
                } else {
                    if (this.customerService.updateCustomer(customer) == true) {
                        r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
                        return "redirect:/personal";
                    } else {
                        model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
                    }
                }
            } else if (!cusOld.getPhone().equals(customer.getPhone())) {
                if (this.customerService.getCusPhone(customer.getPhone()).size() > 0) {
                    model.addAttribute("errMessage", "Số điện thoại đã tồn tại!!");
                } else {
                    if (this.customerService.updateCustomer(customer) == true) {
                        r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
                        return "redirect:/personal";
                    } else {
                        model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
                    }
                }
            } else if (this.customerService.updateCustomer(customer) == true) {
                r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
                return "redirect:/personal";
            } else {
                model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
            }
        }
        return "customer-edit";
    }

    @GetMapping("/list-cus-order")
    public String listView(Model model, @RequestParam(required = false) Map<String, String> params, Authentication a) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        Account ac = this.accountService.getAcByUsername(a.getName());
        int id = ac.getCustomer().getId();
        Map<String, String> pre = new HashMap<>();
        pre.put("idOrder", params.getOrDefault("idOrder", ""));
        pre.put("namePro", params.getOrDefault("namePro", ""));
        pre.put("nameSel", params.getOrDefault("nameSel", ""));
        pre.put("active", params.getOrDefault("active", ""));
        model.addAttribute("orderDetail", this.orderDetailService);
        model.addAttribute("seller", this.sellerService);
        model.addAttribute("orders", this.orderService.getOrderByCusId(pre, id, page));
        model.addAttribute("counterS", this.orderService.getOrderByCusId(pre, id, 0).size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "list-cus-order";
    }
}
