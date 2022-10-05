/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Account;
import com.tmdt.service.AccountService;
import com.tmdt.service.StatsService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author DELL
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private StatsService statsService;
    @Autowired
    private Environment env;
    @Autowired
    private AccountService userDetailsService;
    
    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard-admin";
    }
    
    @GetMapping("/seller-confirm")
    public String sellerConfirm(Model model,
            @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));

        List<Account> listAc = this.userDetailsService.getRole(Account.SELLER, page, 0);
        List<Account> listSize = this.userDetailsService.getRole(Account.SELLER, 0, 0);

        model.addAttribute("listAc", listAc);
        model.addAttribute("size", listSize.size());
        model.addAttribute("count",env.getProperty("page.size"));
        return "seller-confirm";
    }

    @GetMapping("/seller-confirm/1")
    public String sellerConfirm1(Model model, RedirectAttributes r,
            @RequestParam(name = "id") int id) {
        String errMessage = "";
        Account ac = this.userDetailsService.getAcById(id);
        ac.setActive(1);
        if (this.userDetailsService.updateAc(ac) == true) {
            if (ac.getActive() == 1) {
                errMessage = String.format("Đã xác nhận thành công người bán có tài khoản: '%s'", ac.getUsername());
            } else {
                errMessage = String.format("Có lỗi xảy ra khi xác nhận người bán có tài khoản: '%s'", ac.getUsername());
            }
        }
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/admin/seller-confirm";
    }

    @GetMapping("/seller-confirm/all")
    public String sellerConfirmAll(Model model, RedirectAttributes r) {

        String errMessage = "";

        List<Account> acs = this.userDetailsService.getRole(Account.SELLER, 0, 0);
        acs.forEach(ac -> {
            ac.setActive(1);
            this.userDetailsService.updateAc(ac);
        });

        int size = this.userDetailsService.getRole(Account.SELLER, 0, 0).size();

        if (size != 0) {
            errMessage = "Có lỗi xảy ra khi xác nhận tất cả người bán";
        }

        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/admin/seller-confirm";
    }
    @GetMapping("/stats/role")
    public String statsRole(Model model) {
        model.addAttribute("countRole",this.statsService.countRole());
        return "stats-role";
    }
}
