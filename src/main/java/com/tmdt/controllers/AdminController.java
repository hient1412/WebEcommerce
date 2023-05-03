/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Admin;
import com.tmdt.pojos.Category;
import com.tmdt.pojos.Customer;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Report;
import com.tmdt.pojos.Seller;
import com.tmdt.service.AccountService;
import com.tmdt.service.AdminService;
import com.tmdt.service.CategoryService;
import com.tmdt.service.CustomerService;
import com.tmdt.service.ImageService;
import com.tmdt.service.MailService;
import com.tmdt.service.ProductService;
import com.tmdt.service.SellerService;
import com.tmdt.service.StatsService;
import com.tmdt.validator.AccountValidator;
import com.tmdt.validator.AdminValidator;
import com.tmdt.validator.CategoryValidator;
import java.text.SimpleDateFormat;
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
    private ImageService imageService;
    @Autowired
    private CategoryValidator categoryValidator;
    @Autowired
    private AdminValidator adminValidator;
    @Autowired
    private AccountValidator accountValidator;
    @Autowired
    private ProductService productService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private SellerService sellerService;
    @Autowired
    private MailService mailService;

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

    @GetMapping("/seller-confirm/see")
    public String sellerConfirmSee(Model model, @RequestParam(name = "id") int id) {
        Seller s = this.userDetailsService.getAcById(id).getSeller();
        model.addAttribute("sel", s);
        return "seller-confirm-see";
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
                model.addAttribute("errMessage", "Tên loại sản phẩm này đã tồn tại!!");
            } else {
                cate.setIsDelete(0);
                if (this.categoryService.addCate(cate) == true) {
                    r.addFlashAttribute("errMessage", String.format("Thêm thành công loại sản phẩm '%s'", cate.getName()));
                    return "redirect:/admin/product-cate";
                } else {
                    model.addAttribute("errMessage", String.format("Có lỗi xảy ra không thể thêm loại sản phẩm '%s'", cate.getName()));
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
                    model.addAttribute("errMessage", "Tên loại sản phẩm này đã tồn tại!!");
                } else {
                    cate.setIsDelete(0);
                    if (this.categoryService.updateCate(cate) == true) {
                        r.addFlashAttribute("errMessage", String.format("Chỉnh sửa thành công loại sản phẩm '%s'", cate.getName()));
                        return "redirect:/admin/product-cate";
                    } else {
                        model.addAttribute("errMessage", "Có lỗi xảy ra không thể chỉnh sửa loại sản phẩm");
                    }
                }
            } else {
                cate.setIsDelete(0);
                if (this.categoryService.updateCate(cate) == true) {
                    r.addFlashAttribute("errMessage", String.format("Chỉnh sửa thành công loại sản phẩm '%s'", cate.getName()));
                    return "redirect:/admin/product-cate";
                } else {
                    model.addAttribute("errMessage", "Có lỗi xảy ra không thể chỉnh sửa loại sản phẩm");
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
            r.addFlashAttribute("errMessage", String.format("Xóa thành công loại sản phẩm '%s'", c.getName()));
        } else {
            r.addFlashAttribute("errMessage", "Có lỗi xảy ra không thể xóa loại sản phẩm");
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
                    model.addAttribute("errMessage", "Email đã tồn tại!!");
                } else {
                    if (this.adminService.updateAdmin(admin) == true) {
                        r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
                        return "redirect:/personal";
                    } else {
                        model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
                    }
                }
            } else if (!adminOld.getPhone().equals(admin.getPhone())) {
                if (this.adminService.getAdPhone(admin.getPhone()).size() > 0) {
                    model.addAttribute("errMessage", "Số điện thoại đã tồn tại!!");
                } else {
                    if (this.adminService.updateAdmin(admin) == true) {
                        r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
                        return "redirect:/personal";
                    } else {
                        model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
                    }
                }
            } else if (this.adminService.updateAdmin(admin) == true) {
                r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
                return "redirect:/personal";
            } else {
                model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
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

    @GetMapping("/account/see")
    public String accountSee(Model model, @RequestParam(name = "id") int id) {
        Account ac = this.userDetailsService.getAcById(id);
        model.addAttribute("ac", ac);
        if (ac.getRole().equals(Account.ADMIN)) {
            Admin ad = ac.getAdmin();
            model.addAttribute("ad", ad);
        } else if (ac.getRole().equals(Account.SELLER)) {
            Seller s = ac.getSeller();
            model.addAttribute("sel", s);
        } else if (ac.getRole().equals(Account.CUSTOMER)) {
            Customer c = ac.getCustomer();
            model.addAttribute("cus", c);
        } else {
            model.addAttribute("errMessage", "Có lỗi xảy ra");
        }
        return "admin-account-see";
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
                model.addAttribute("errMessage", "Tên đăng nhập đã tồn tại!!");
            } else if (this.userDetailsService.addAccount(ac)) {
                if (ac.getRole().equals("ROLE_CUSTOMER")) {
                    return "redirect:/registry/cus?id=" + this.userDetailsService.getAcByUsername(ac.getUsername()).getId();
                } else if (ac.getRole().equals("ROLE_SELLER")) {
                    return "redirect:/registry/sel?id=" + this.userDetailsService.getAcByUsername(ac.getUsername()).getId();
                } else {
                    return "redirect:/registry/admin?id=" + this.userDetailsService.getAcByUsername(ac.getUsername()).getId();
                }
            } else {
                model.addAttribute("errMessage", "Có lỗi xảy ra không thể thêm tài khoản");
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
    public String updateAccount(Model model, @ModelAttribute(value = "ac") Account account, Authentication a,
            RedirectAttributes r, BindingResult br) {
        Account accountOld = this.userDetailsService.getAcById(account.getId());
        Account acNow = this.userDetailsService.getAcByUsername(a.getName());
        accountValidator.validate(account, br);
        if (br.hasErrors()) {
            return "admin-account-edit";
        } else {
            if (!acNow.getRole().equals(accountOld.getRole())) {
                if (!accountOld.getUsername().equals(account.getUsername())) {
                    if (this.userDetailsService.getAcUserNameList(account.getUsername()).size() > 0) {
                        model.addAttribute("errMessage", "Tên đăng nhập đã tồn tại!!");
                    } else {
                        if (this.userDetailsService.updateAc(account) == true) {
                            r.addFlashAttribute("errMessage", String.format("Chỉnh sửa thành công tài khoản '%s'", account.getUsername()));
                            return "redirect:/admin/account";
                        } else {
                            model.addAttribute("errMessage", "Có lỗi xảy ra không thể chỉnh sửa tài khoản");
                        }
                    }
                } else if (this.userDetailsService.updateAc(account) == true) {
                    r.addFlashAttribute("errMessage", String.format("Chỉnh sửa thành công tài khoản '%s'", account.getUsername()));
                    return "redirect:/admin/account";
                } else {
                    model.addAttribute("errMessage", "Có lỗi xảy ra không thể chỉnh sửa tài khoản");
                }
            } else {
                if (acNow.getAdmin().getSuperAdmin() == 1) {
                    if (!accountOld.getUsername().equals(account.getUsername())) {
                        if (this.userDetailsService.getAcUserNameList(account.getUsername()).size() > 0) {
                            model.addAttribute("errMessage", "Tên đăng nhập đã tồn tại!!");
                        } else {
                            if (this.userDetailsService.updateAc(account) == true) {
                                r.addFlashAttribute("errMessage", String.format("Chỉnh sửa thành công tài khoản '%s'", account.getUsername()));
                                return "redirect:/admin/account";
                            } else {
                                model.addAttribute("errMessage", "Có lỗi xảy ra không thể chỉnh sửa tài khoản");
                            }
                        }
                    } else if (this.userDetailsService.updateAc(account) == true) {
                        r.addFlashAttribute("errMessage", String.format("Chỉnh sửa thành công tài khoản '%s'", account.getUsername()));
                        return "redirect:/admin/account";
                    } else {
                        model.addAttribute("errMessage", "Có lỗi xảy ra không thể chỉnh sửa tài khoản");
                    }
                } else if (acNow.getAdmin().getSuperAdmin() != 1 && accountOld.getAdmin().getSuperAdmin() == 0) {
                    if (!acNow.getId().equals(accountOld.getId())) {
                        r.addFlashAttribute("errMessage", String.format("Bạn không thể chỉnh sửa tài khoản của admin khác!!"));
                        return "redirect:/admin/account";
                    } else {
                        if (!accountOld.getUsername().equals(account.getUsername())) {
                            if (this.userDetailsService.getAcUserNameList(account.getUsername()).size() > 0) {
                                model.addAttribute("errMessage", "Tên đăng nhập đã tồn tại!!");
                            } else {
                                if (this.userDetailsService.updateAc(account) == true) {
                                    r.addFlashAttribute("errMessage", String.format("Chỉnh sửa thành công tài khoản '%s'", account.getUsername()));
                                    return "redirect:/admin/account";
                                } else {
                                    model.addAttribute("errMessage", "Có lỗi xảy ra không thể chỉnh sửa tài khoản");
                                }
                            }
                        } else if (this.userDetailsService.updateAc(account) == true) {
                            r.addFlashAttribute("errMessage", String.format("Chỉnh sửa thành công tài khoản '%s'", account.getUsername()));
                            return "redirect:/admin/account";
                        } else {
                            model.addAttribute("errMessage", "Có lỗi xảy ra không thể chỉnh sửa tài khoản");
                        }
                    }
                } else {
                    r.addFlashAttribute("errMessage", String.format("Bạn không thể chỉnh sửa tài khoản của admin tối cao!!"));
                    return "redirect:/admin/account";
                }
            }
        }
        return "admin-account-edit";
    }

    @GetMapping("/account/delete")
    public String deleteTK(Model model, @RequestParam(name = "id") int id,
            RedirectAttributes r, Authentication a) {
        String errMessage = "";
        Account ac = this.userDetailsService.getAcById(id);
        Account acNow = this.userDetailsService.getAcByUsername(a.getName());
        if (!acNow.getRole().equals(ac.getRole())) {
            if (this.userDetailsService.deleteAc(ac) == true) {
                errMessage = String.format("Đã xóa thành công tài khoản: '%s'", ac.getUsername());
            } else {
                errMessage = String.format("Có lỗi xảy ra không thể xóa tài khoản: '%s'", ac.getUsername());
            }
        } else {
            if (acNow.getAdmin().getSuperAdmin() == 1) {
                if (this.userDetailsService.deleteAc(ac) == true) {
                    errMessage = String.format("Đã xóa thành công tài khoản: '%s'", ac.getUsername());
                } else {
                    errMessage = String.format("Có lỗi xảy ra không thể xóa tài khoản: '%s'", ac.getUsername());
                }
            } else {
                errMessage = "Bạn không thể xóa tài khoản của admin tối cao!!";
            }
            if (acNow.getAdmin().getSuperAdmin() != 1 && ac.getAdmin().getSuperAdmin() == 0) {
                if (!acNow.getId().equals(ac.getId())) {
                    errMessage = "Bạn không thể xóa tài khoản của admin khác!!";
                } else {
                    errMessage = "Bạn không thể xóa tài khoản của chính mình!!";
                }
            }
        }
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/admin/account";
    }

    @GetMapping("/report")
    public String report(Model model, @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        List<Report> report = this.adminService.getReportWithProduct(page);
        List<Report> size = this.adminService.getReportWithProduct(0);
        model.addAttribute("report", report);
        model.addAttribute("counterS", size.size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "report";
    }

    @GetMapping("/report/seller")
    public String reportSeller(Model model, @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        List<Object[]> report = this.adminService.getReportProductSeller(page);
        List<Object[]> size = this.adminService.getReportProductSeller(0);
        model.addAttribute("report", report);
        model.addAttribute("counterS", size.size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "report-seller";
    }

    @GetMapping("/report/seller/see")
    public String reportSellerSee(Model model, @RequestParam(required = false) Map<String, String> params, @RequestParam(name = "id") int id) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        List<Product> product = this.adminService.getReportSeller(id, page);
        List<Product> size = this.adminService.getReportSeller(id, 0);
        model.addAttribute("seller", this.sellerService.getSellerById(id));
        model.addAttribute("product", product);
        model.addAttribute("counterS", size.size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "report-seller-see";
    }

    @GetMapping("/report/see")
    public String reportProduct(Model model, @RequestParam(required = false) Map<String, String> params, @RequestParam(name = "id") int id) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        List<Report> report = this.adminService.getReport(id, page);
        List<Report> size = this.adminService.getReport(id, 0);
        model.addAttribute("img", this.imageService.getImageByProductId(id).get(0).getImage());
        model.addAttribute("product", this.productService.getProductById(id));
        model.addAttribute("report", report);
        model.addAttribute("counterS", size.size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "report-product";
    }

    @GetMapping("/report/skip")
    public String skip(Model model, RedirectAttributes r,
            @RequestParam(name = "id") int id) {
        String errMessage = "";

        List<Report> rp = this.adminService.getReportCheckAll(id, 0);
        rp.forEach(i -> {
            i.setActive(1);
            this.adminService.updateSkip(i);
        });

        int size = this.adminService.getReportCheckAll(id, 0).size();

        if (size != 0) {
            errMessage = "Có lỗi xảy ra không thể xét qua";
        }
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/admin/report";
    }

    @GetMapping("/report/ban")
    public String ban(Model model, RedirectAttributes r,
            @RequestParam(name = "id") int id) {
        String errMessage = "";
        this.skip(model, r, id);
        Product p = this.productService.getProductById(id);
        p.setAdminBan(1);
        if (this.productService.updateProductBan(p) == 1) {
            if (p.getAdminBan() == 1) {
                errMessage = String.format("Đã cấm thành công sản phẩm: '%s'", p.getName());
                SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
                String sendTo = p.getIdSeller().getEmail();
                String subject = "WEBECOMMERCE THÔNG BÁO CẤM SẢN PHẨM '" + p.getName() + "' DO VI PHẠM CHÍNH SÁCH CỘNG ĐỒNG";
                String content
                        = "<div style=\"text-align:center;\">\n"
                        + "    <div style=\"border: 1px solid;padding: 10px;margin: 10px\">\n"
                        + "        <h3 style=\"color:red;text-transform: uppercase\">Tố cáo chi tiết</h3>\n"
                        + "    </div>\n"
                        + "</div>\n"
                        + "    <div style=\"border: 1px solid;margin: 10px\">\n"
                        + "        <div style=\"padding:10px\">\n"
                        + "            <div style=\"display: flex;\">"
                        + "                <div style=\"display:flex;\">\n"
                        + "                    <div>\n"
                        + "                        <img style=\"border-radius:50%;width:60px;height:50px\" src=\"" + p.getIdSeller().getAvatar() + "\"></a>\n"
                        + "                    </div>\n"
                        + "                    <div style=\"font-size: 24px;\">\n"
                        + "                        <label>" + p.getIdSeller().getName() + "</label></a>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "                <div style=\"margin-left:auto;display: flex;\">\n"
                        + "                    <a href=\"http://localhost:8080/WebEcommerce/seller-detail/" + p.getIdSeller().getId() + "\" style=\"text-decoration: none\"><button>Xem shop</button></a>\n"
                        + "                 </div>\n"
                        + "            </div>"
                        + "       </div>"
                        + "   </div>"
                        + "<div style=\"display: flex;align-items: center;justify-content: center\">\n"
                        + "    <div style=\"text-align: center;width:100%\">\n"
                        + "        <div >\n"
                        + "            <div style=\"margin-bottom: 10px\">\n"
                        + "                <a href=\"http://localhost:8080/WebEcommerce/product-detail/" + p.getId() + "\" style=\"text-decoration: none\"><img style=\"width:50%;height:50%\" src=\"" + this.imageService.getImageByProductId(id).get(0).getImage() + "\"></a>\n"
                        + "            </div>\n"
                        + "        </div>\n"
                        + "        <div style=\"margin-top 15px\">\n"
                        + "            <div style=\"margin-bottom: 15px\">\n"
                        + "                <label>" + p.getName() + "</label>\n"
                        + "            </div>\n"
                        + "        </div>\n"
                        + "    </div>\n"
                        + "</div>"
                        + "<div style=\"margin-bottom:10px\">\n"
                        + "    <div style=\"border: 1px solid;margin: 10px;\" >\n"
                        + "        <table style=\"width: 100%;\">\n"
                        + "            <tbody style=\"background-color: #f8f9fa;\">\n"
                        + " <tr style=\"text-align: right;\">\n"
                        + "               <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Mã tố cáo</b></td>\n"
                        + "               <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Vào lúc</b></td>\n"
                        + "               <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Tố cáo</b></td>\n"
                        + "           </tr>\n";
                for (Report i : this.adminService.getReport(id, 0)) {
                    content += "<tr style=\"text-align: right;\">\n"
                            + "                <td style=\"border: 1px solid #dee2e6; padding: 10px\">" + i.getId() + "</td>\n"
                            + "                <td style=\"border: 1px solid #dee2e6; padding: 10px\">" + dt.format(i.getReportDate()) + "</td>\n"
                            + "                <td style=\"border: 1px solid #dee2e6\"> <span>" + i.getReportDescription() + "</span> </td>\n"
                            + "           </tr>\n";
                }
                content += "            </tbody>\n"
                        + "        </table>\n"
                        + "    </div>\n"
                        + "</div>";
                mailService.sendMail(sendTo, subject, content);
            } else {
                errMessage = String.format("Có lỗi xảy ra khi cấm sản phẩm: '%s'", p.getName());
            }
        }
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/admin/report";
    }

    @GetMapping("/report/seller/ban")
    public String banSeller(Model model, RedirectAttributes r,
            @RequestParam(name = "id") int id, @RequestParam(required = false) Map<String, String> params) {
        String errMessage = "";
        Seller s = this.sellerService.getSellerById(id);
        s.setAdminBan(1);
        if (this.sellerService.updateSellerBan(s) == 1) {
            if (s.getAdminBan() == 1) {
                errMessage = String.format("Đã cấm thành công cửa hàng: '%s'", s.getName());
                SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
                String sendTo = s.getEmail();
                String subject = "WEBECOMMERCE THÔNG BÁO CẤM CỬA HÀNG '" + s.getName() + "' DO VI PHẠM CHÍNH SÁCH CỘNG ĐỒNG";
                String content
                        = "<div style=\"text-align:center;\">\n"
                        + "    <div style=\"border: 1px solid;padding: 10px;margin: 10px;padding:10px\">\n"
                        + "        <h3 style=\"color:red;text-transform: uppercase\">Cấm shop hoạt động</h3>\n"
                        + "         <p><strong>Lý do: Bán nhiều sản phẩm bị vi phạm</strong></p>"
                        + "    </div>\n"
                        + "</div>\n"
                        + "    <div style=\"border: 1px solid;margin: 10px\">\n"
                        + "        <div style=\"padding:10px\">\n"
                        + "            <div style=\"display: flex;\">"
                        + "                <div style=\"display:flex;\">\n"
                        + "                    <div>\n"
                        + "                        <img style=\"border-radius:50%;width:60px;height:50px\" src=\"" + s.getAvatar() + "\"></a>\n"
                        + "                    </div>\n"
                        + "                    <div style=\"font-size: 24px;\">\n"
                        + "                        <label>" + s.getName() + "</label></a>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "                <div style=\"margin-left:auto;display: flex;\">\n"
                        + "                    <a href=\"http://localhost:8080/WebEcommerce/seller-detail/" + s.getId() + "\" style=\"text-decoration: none\"><button>Xem shop</button></a>\n"
                        + "                 </div>\n"
                        + "            </div>"
                        + "       </div>"
                        + "   </div>"
                        + "<div style=\"border: 1px solid;margin: 10px\">\n"
                        + "        <div style=\"padding:10px\">\n"
                        + "<table style=\"width:100%;text-align:center;\">"
                        + "     <thead>"
                        + "         <tr>"
                        + "             <th>Mã sản phẩm</th>"
                        + "             <th>Tên sản phẩm</th>"
                        + "             <th>Hình ảnh</th>"
                        + "         </tr>"
                        + "     </thead>"
                        + "     <tbody>";
                for (Product i : this.adminService.getReportSeller(s.getId(), 0)) {
                    content += "         <tr>"
                            + "             <td>" + i.getId() + "</td>"
                            + "             <td>" + i.getName() + "</td>"
                            + "             <td><a href=\"http://localhost:8080/WebEcommerce/product-detail/" + i.getId() + "\" style=\"text-decoration: none\"><img style=\"width:100px;height:100px\" src=\"" + this.imageService.getImageByProductId(i.getId()).get(0).getImage() + "\"></a>\n</td>"
                            + "         </tr>";
                }
                content += "     </tbody>"
                        + "</table>"
                        + "       </div>"
                        + "   </div>";
                mailService.sendMail(sendTo, subject, content);
            }
        } else {
            errMessage = String.format("Có lỗi xảy ra khi cấm cửa hàng: '%s'", s.getName());
        }

        r.addFlashAttribute("errMessage", errMessage);

        return "redirect:/admin/report/seller";
    }
//@GetMapping("/report/seller/unban")
//    public String unBanSeller(Model model, RedirectAttributes r,
//            @RequestParam(name = "id") int id, @RequestParam(required = false) Map<String, String> params) {
//        String errMessage = "";
//        Seller s = this.sellerService.getSellerById(id);
//        s.setAdminBan(0);
//        if (this.sellerService.updateSellerBan(s) == 1) {
//            if (s.getAdminBan() == 1) {
//                errMessage = String.format("Đã hiển thị thành công cửa hàng: '%s'", s.getName());
//                SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
//                String sendTo = s.getEmail();
//                String subject = "WEBECOMMERCE THÔNG BÁO CẤM CỬA HÀNG '" + s.getName() + "' DO VI PHẠM CHÍNH SÁCH CỘNG ĐỒNG";
//                String content
//                        = "<div style=\"text-align:center;\">\n"
//                        + "    <div style=\"border: 1px solid;padding: 10px;margin: 10px;padding:10px\">\n"
//                        + "        <h3 style=\"color:red;text-transform: uppercase\">Cấm shop hoạt động</h3>\n"
//                        + "         <p><strong>Lý do: Bán nhiều sản phẩm bị vi phạm</strong></p>"
//                        + "    </div>\n"
//                        + "</div>\n"
//                        + "    <div style=\"border: 1px solid;margin: 10px\">\n"
//                        + "        <div style=\"padding:10px\">\n"
//                        + "            <div style=\"display: flex;\">"
//                        + "                <div style=\"display:flex;\">\n"
//                        + "                    <div>\n"
//                        + "                        <img style=\"border-radius:50%;width:60px;height:50px\" src=\"" + s.getAvatar() + "\"></a>\n"
//                        + "                    </div>\n"
//                        + "                    <div style=\"font-size: 24px;\">\n"
//                        + "                        <label>" + s.getName() + "</label></a>\n"
//                        + "                    </div>\n"
//                        + "                </div>\n"
//                        + "                <div style=\"margin-left:auto;display: flex;\">\n"
//                        + "                    <a href=\"http://localhost:8080/WebEcommerce/seller-detail/" + s.getId() + "\" style=\"text-decoration: none\"><button>Xem shop</button></a>\n"
//                        + "                 </div>\n"
//                        + "            </div>"
//                        + "       </div>"
//                        + "   </div>"
//                        + "<div style=\"border: 1px solid;margin: 10px\">\n"
//                        + "        <div style=\"padding:10px\">\n"
//                        + "<table style=\"width:100%;text-align:center;\">"
//                        + "     <thead>"
//                        + "         <tr>"
//                        + "             <th>Mã sản phẩm</th>"
//                        + "             <th>Tên sản phẩm</th>"
//                        + "             <th>Hình ảnh</th>"
//                        + "         </tr>"
//                        + "     </thead>"
//                        + "     <tbody>";
//                for (Product i : this.adminService.getReportSeller(s.getId(), 0)) {
//                    content += "         <tr>"
//                            + "             <td>" + i.getId() + "</td>"
//                            + "             <td>" + i.getName() + "</td>"
//                            + "             <td><a href=\"http://localhost:8080/WebEcommerce/product-detail/" + i.getId() + "\" style=\"text-decoration: none\"><img style=\"width:100px;height:100px\" src=\"" + this.imageService.getImageByProductId(i.getId()).get(0).getImage() + "\"></a>\n</td>"
//                            + "         </tr>";
//                }
//                content += "     </tbody>"
//                        + "</table>"
//                        + "       </div>"
//                        + "   </div>";
//                mailService.sendMail(sendTo, subject, content);
//            }
//        } else {
//            errMessage = String.format("Có lỗi xảy ra khi cấm cửa hàng: '%s'", s.getName());
//        }
//
//        r.addFlashAttribute("errMessage", errMessage);
//
//        return "redirect:/admin/report/seller";
//    }

}
