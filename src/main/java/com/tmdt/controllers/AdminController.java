/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Admin;
import com.tmdt.pojos.Category;
import com.tmdt.pojos.Customer;
import com.tmdt.pojos.Seller;
import com.tmdt.service.AccountService;
import com.tmdt.service.AdminService;
import com.tmdt.service.CategoryService;
import com.tmdt.service.CustomerService;
import com.tmdt.service.SellerService;
import com.tmdt.service.StatsService;
import com.tmdt.validator.AccountValidator;
import com.tmdt.validator.AdminValidator;
import com.tmdt.validator.CategoryValidator;
import java.util.List;
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
import org.springframework.web.servlet.ModelAndView;
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
    private CategoryService categoryService;
    @Autowired
    private Environment env;
    @Autowired
    private AccountService userDetailsService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private CategoryValidator categoryValidator;
    @Autowired
    private AdminValidator adminValidator;
    @Autowired
    private AccountValidator accountValidator;
    @Autowired
    private SellerService sellerService;
    @Autowired
    private AdminService adminService;

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
        model.addAttribute("count", env.getProperty("page.size"));
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
                errMessage = String.format("???? x??c nh???n th??nh c??ng ng?????i b??n c?? t??i kho???n: '%s'", ac.getUsername());
            } else {
                errMessage = String.format("C?? l???i x???y ra khi x??c nh???n ng?????i b??n c?? t??i kho???n: '%s'", ac.getUsername());
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
            errMessage = "C?? l???i x???y ra khi x??c nh???n t???t c??? ng?????i b??n";
        }

        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/admin/seller-confirm";
    }

    @GetMapping("/stats/role")
    public String statsRole(Model model) {
        model.addAttribute("countRole", this.statsService.countRole());
        return "stats-role";
    }

    @GetMapping("/stats/categories")
    public String adminStatsCategories(Model model) {
        model.addAttribute("countAdminProCate", this.statsService.countAdminProCategories());
        return "admin-stats-cate";
    }

    @GetMapping("/product-cate")
    public String productCate(Model model, @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        List<Category> cate = this.categoryService.getCates(page);
        List<Category> size = this.categoryService.getCates(0);

        model.addAttribute("cate", cate);
        model.addAttribute("counterS", size.size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "product-cate";
    }

    @GetMapping("/product-cate/add")
    public String productCateAddView(Model model) {
        model.addAttribute("category", new Category());
        return "product-cate-add";
    }

    @PostMapping("/product-cate/add")
    public String productCateAdd(Model model, @ModelAttribute(value = "category") Category cate,
            RedirectAttributes r, BindingResult br) {
        categoryValidator.validate(cate, br);
        if (br.hasErrors()) {
            return "product-cate-add";
        } else {
            if (this.categoryService.getCates(cate.getName()).size() > 0) {
                model.addAttribute("errMessage", "T??n lo???i s???n ph???m n??y ???? t???n t???i!!");
            } else {
                cate.setIsDelete(0);
                if (this.categoryService.addCate(cate) == true) {
                    r.addFlashAttribute("errMessage", String.format("Th??m th??nh c??ng lo???i s???n ph???m '%s'", cate.getName()));
                    return "redirect:/admin/product-cate";
                } else {
                    model.addAttribute("errMessage", String.format("C?? l???i x???y ra kh??ng th??? th??m lo???i s???n ph???m '%s'", cate.getName()));
                }
            }
        }
        return "product-cate-add";
    }

    @GetMapping("/product-cate/edit")
    public String productCateEditView(Model model, @RequestParam(name = "id") int id) {
        model.addAttribute("category", this.categoryService.getCateById(id));
        return "product-cate-edit";
    }

    @PostMapping("/product-cate/edit")
    public String productCateEdit(Model model, @ModelAttribute(value = "category") Category cate,
            RedirectAttributes r, BindingResult br) {
        Category cateOld = this.categoryService.getCateById(cate.getId());
        categoryValidator.validate(cate, br);
        if (br.hasErrors()) {
            return "product-cate-edit";
        } else {
            if (!cateOld.getName().equals(cate.getName())) {
                if (this.categoryService.getCates(cate.getName()).size() > 0) {
                    model.addAttribute("errMessage", "T??n lo???i s???n ph???m n??y ???? t???n t???i!!");
                } else {
                    cate.setIsDelete(0);
                    if (this.categoryService.updateCate(cate) == true) {
                        r.addFlashAttribute("errMessage", String.format("Ch???nh s???a th??nh c??ng lo???i s???n ph???m '%s'", cate.getName()));
                        return "redirect:/admin/product-cate";
                    } else {
                        model.addAttribute("errMessage", "C?? l???i x???y ra kh??ng th??? ch???nh s???a lo???i s???n ph???m");
                    }
                }
            } else {
                cate.setIsDelete(0);
                if (this.categoryService.updateCate(cate) == true) {
                    r.addFlashAttribute("errMessage", String.format("Ch???nh s???a th??nh c??ng lo???i s???n ph???m '%s'", cate.getName()));
                    return "redirect:/admin/product-cate";
                } else {
                    model.addAttribute("errMessage", "C?? l???i x???y ra kh??ng th??? ch???nh s???a lo???i s???n ph???m");
                }
            }
        }
        return "product-cate-edit";
    }

    @GetMapping("/product-cate/delete")
    public String productCateDelete(Model model, @RequestParam(name = "id") int id,
            RedirectAttributes r) {
        String errMessage = "";
        Category c = this.categoryService.getCateById(id);
        c.setIsDelete(1);
        if (this.categoryService.updateCate(c) == true) {
            r.addFlashAttribute("errMessage", String.format("X??a th??nh c??ng lo???i s???n ph???m '%s'", c.getName()));
        } else {
            r.addFlashAttribute("errMessage", "C?? l???i x???y ra kh??ng th??? x??a lo???i s???n ph???m");
        }
        return "redirect:/admin/product-cate";
    }

    @GetMapping("/edit")
    public String adminEditView(Model model, Authentication authentication) {
        Account ac = this.userDetailsService.getAcByUsername(authentication.getName());
        model.addAttribute("admin", ac.getAdmin());
        return "admin-edit";
    }

    @PostMapping("/edit")
    public String adminEdit(Model model, @ModelAttribute(value = "admin") Admin admin,
            RedirectAttributes r, BindingResult br) {
        Admin adminOld = this.adminService.getAdById(admin.getId());
        adminValidator.validate(admin, br);
        if (br.hasErrors()) {
            return "admin-edit";
        } else {
            if (!adminOld.getEmail().equals(admin.getEmail())) {
                if (this.adminService.getAdEmail(admin.getEmail()).size() > 0) {
                    model.addAttribute("errMessage", "Email ???? t???n t???i!!");
                } else {
                    if (this.adminService.updateAdmin(admin) == true) {
                        r.addFlashAttribute("errMessage", "C???p nh???t th??ng tin th??nh c??ng");
                        return "redirect:/personal";
                    } else {
                        model.addAttribute("errMessage", "C?? l???i x???y ra kh??ng th??? c???p nh???t th??ng tin");
                    }
                }
            } else if (!adminOld.getPhone().equals(admin.getPhone())) {
                if (this.adminService.getAdPhone(admin.getPhone()).size() > 0) {
                    model.addAttribute("errMessage", "S??? ??i???n tho???i ???? t???n t???i!!");
                } else {
                    if (this.adminService.updateAdmin(admin) == true) {
                        r.addFlashAttribute("errMessage", "C???p nh???t th??ng tin th??nh c??ng");
                        return "redirect:/personal";
                    } else {
                        model.addAttribute("errMessage", "C?? l???i x???y ra kh??ng th??? c???p nh???t th??ng tin");
                    }
                }
            } else if (this.adminService.updateAdmin(admin) == true) {
                r.addFlashAttribute("errMessage", "C???p nh???t th??ng tin th??nh c??ng");
                return "redirect:/personal";
            } else {
                model.addAttribute("errMessage", "C?? l???i x???y ra kh??ng th??? c???p nh???t th??ng tin");
            }
        }
        return "admin-edit";
    }

    @GetMapping("/account")
    public String account(Model model, @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));

        List<Account> list = this.userDetailsService.getAccount(page);
        List<Account> listSize = this.userDetailsService.getAccount(0);

        model.addAttribute("list", list);
        model.addAttribute("counterS", listSize.size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "admin-account";
    }

    @GetMapping("/account/add")
    public String addAccountView(Model model) {
        model.addAttribute("ac", new Account());
        return "admin-account-add";
    }

    @PostMapping("/account/add")
    public String addAccount(Model model, @ModelAttribute(value = "ac") Account ac,
            RedirectAttributes r, BindingResult br) {
        accountValidator.validate(ac, br);
        if (br.hasErrors()) {
            return "admin-account-add";
        } else {
            if (this.userDetailsService.getAcUserNameList(ac.getUsername()).size() > 0) {
                model.addAttribute("errMessage", "T??n ????ng nh???p ???? t???n t???i!!");
            } else if (this.userDetailsService.addAccount(ac)) {
                if (ac.getRole().equals("ROLE_CUSTOMER")) {
                    return "redirect:/registry/cus?id=" + this.userDetailsService.getAcByUsername(ac.getUsername()).getId();
                } else if (ac.getRole().equals("ROLE_SELLER")) {
                    return "redirect:/registry/sel?id=" + this.userDetailsService.getAcByUsername(ac.getUsername()).getId();
                } else {
                    return "redirect:/registry/admin?id=" + this.userDetailsService.getAcByUsername(ac.getUsername()).getId();
                }
            } else {
                model.addAttribute("errMessage", "C?? l???i x???y ra kh??ng th??? th??m t??i kho???n");
            }
        }
        return "admin-account-add";
    }

    @GetMapping("/account/edit")
    public String updateAccountView(Model model, @RequestParam(name = "id") int id) {
        Account ac = this.userDetailsService.getAcById(id);
        model.addAttribute("ac", ac);
        return "admin-account-edit";
    }

    @PostMapping("/account/edit")
    public String updateAccount(Model model, @ModelAttribute(value = "ac") Account account,
            RedirectAttributes r, BindingResult br) {
        Account accountOld = this.userDetailsService.getAcById(account.getId());
        accountValidator.validate(account, br);
        if (br.hasErrors()) {
            return "admin-account-edit";
        } else {
            if (!accountOld.getUsername().equals(account.getUsername())) {
                if (this.userDetailsService.getAcUserNameList(account.getUsername()).size() > 0) {
                    model.addAttribute("errMessage", "T??n ????ng nh???p ???? t???n t???i!!");
                } else {
                    if (this.userDetailsService.updateAc(account) == true) {
                        r.addFlashAttribute("errMessage", String.format("Ch???nh s???a th??nh c??ng t??i kho???n '%s'", account.getUsername()));
                        return "redirect:/admin/account";
                    } else {
                        model.addAttribute("errMessage", "C?? l???i x???y ra kh??ng th??? ch???nh s???a t??i kho???n");
                    }
                }
            } else if (this.userDetailsService.updateAc(account) == true) {
                r.addFlashAttribute("errMessage", String.format("Ch???nh s???a th??nh c??ng t??i kho???n '%s'", account.getUsername()));
                return "redirect:/admin/account";
            } else {
                model.addAttribute("errMessage", "C?? l???i x???y ra kh??ng th??? ch???nh s???a t??i kho???n");
            }
        }
        return "admin-account-edit";
    }

    @GetMapping("/account/delete")
    public String deleteTK(Model model, @RequestParam(name = "id") int id,
            RedirectAttributes r) {
        String errMessage = "";
        Account ac = this.userDetailsService.getAcById(id);
        if (this.userDetailsService.deleteAc(ac) == true) {
            errMessage = String.format("???? x??a th??nh c??ng t??i kho???n: '%s'", ac.getUsername());
        } else {
            errMessage = String.format("C?? l???i x???y ra kh??ng th??? x??a t??i kho???n: '%s'", ac.getUsername());
        }
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/admin/account";
    }

}
