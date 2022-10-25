/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Customer;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Account;
import com.tmdt.pojos.Admin;
import com.tmdt.pojos.Cart;
import com.tmdt.pojos.Seller;
import com.tmdt.service.AccountService;
import com.tmdt.service.AdminService;
import com.tmdt.service.CategoryService;
import com.tmdt.service.CustomerService;
import com.tmdt.service.ImageService;
import com.tmdt.service.LocationService;
import com.tmdt.service.ProductService;
import com.tmdt.service.SellerService;
import com.tmdt.utils.Utils;
import com.tmdt.validator.AccountValidator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.hibernate.annotations.Target;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author DELL
 */
@Controller
@ControllerAdvice
public class HomeController {

    @Autowired
    private AccountService userDetailsService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private SellerService sellerService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private AccountValidator accountValidator;
    @Autowired
    private LocationService locationService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private Environment env;

    @ModelAttribute
    public void common(Model model) {
        model.addAttribute("categories", this.categoryService.getCates());
    }

    @GetMapping("/seller-detail/{sellerId}")
    public String sellerDetail(Model model, @PathVariable(value = "sellerId") int sellerId,
            @RequestParam(required = false) Map<String, String> params, HttpSession s) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        Map<String, String> pre = new HashMap<>();
        pre.put("sort", params.getOrDefault("sort", ""));
        pre.put("cateId", params.getOrDefault("cateId", ""));
        pre.put("kw", params.getOrDefault("kw", ""));
        model.addAttribute("general", this.sellerService.getgeneral(sellerId));
        model.addAttribute("seller", this.sellerService.getSellerById(sellerId));
        model.addAttribute("cateBySeller", this.categoryService.getCateBySellerId(sellerId));
        model.addAttribute("productBySeller", this.productService.getProductBySeller(pre, sellerId, page));
        model.addAttribute("counterS", this.productService.getProductBySeller(pre, sellerId, 0).size());
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        model.addAttribute("count", env.getProperty("page.size"));
        return "seller-detail";
    }

    @GetMapping("/")
    public String home(Model model, @RequestParam(required = false) Map<String, String> params, HttpSession s) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        Map<String, String> pre = new HashMap<>();
        pre.put("kw", params.getOrDefault("kw", ""));
        pre.put("fp", params.getOrDefault("fp", ""));
        pre.put("tp", params.getOrDefault("tp", ""));
        pre.put("id", params.getOrDefault("id", ""));
        pre.put("sort", params.getOrDefault("sort", ""));
        pre.put("seller", params.getOrDefault("seller", ""));
        pre.put("cat", params.getOrDefault("cat", ""));
        pre.put("location", params.getOrDefault("location", ""));
        String cateId = params.get("cateId");
        model.addAttribute("cateId", cateId);
        if (cateId == null) {
            model.addAttribute("product", this.productService.getProducts(pre, page));
            model.addAttribute("counterS", this.productService.getProducts(pre, 0).size());
            model.addAttribute("buyALot", this.productService.getProductBuyALot(Integer.parseInt(env.getProperty("buyALot.size"))));
        } else {
            model.addAttribute("product", this.productService.getProductByCateId(Integer.parseInt(cateId), page));
            model.addAttribute("counterS", this.productService.getProductByCateId(Integer.parseInt(cateId), 0).size());
        }
        model.addAttribute("count", env.getProperty("page.size"));
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        return "home";
    }

    @GetMapping("/search")
    public String search(Model model,
            @RequestParam(required = false) Map<String, String> params, HttpSession s) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        model.addAttribute("categories", this.categoryService.getCates());

        Map<String, String> pre = new HashMap<>();

        pre.put("kw", params.getOrDefault("kw", ""));
        pre.put("fp", params.getOrDefault("fp", ""));
        pre.put("tp", params.getOrDefault("tp", ""));
        pre.put("id", params.getOrDefault("id", ""));
        pre.put("sort", params.getOrDefault("sort", ""));
        pre.put("seller", params.getOrDefault("seller", ""));
        pre.put("cat", params.getOrDefault("cat", ""));
        pre.put("location", params.getOrDefault("location", ""));

        List<Product> lp = this.productService.getProducts(pre, page);
        model.addAttribute("listProduct", lp);
        model.addAttribute("currentPage", page);
        model.addAttribute("counterS", this.productService.getProducts(pre, 0).size());
        model.addAttribute("kw", params.getOrDefault("kw", ""));
        model.addAttribute("count", env.getProperty("page.size"));
        model.addAttribute("categories", this.categoryService.getCates());
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        model.addAttribute("locations", this.locationService.getLos());
        return "search";
    }

    @GetMapping("/product-detail/{productId}")
    public String productDetail(Model model, @PathVariable(value = "productId") int productId, HttpSession s) {
        model.addAttribute("product", this.productService.getProductById(productId));
        model.addAttribute("seller", this.productService.getProductById(productId).getIdSeller());
        model.addAttribute("image", this.imageService.getImageByProductId(productId));
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        model.addAttribute("buyALotSeller", this.productService.getProductBuyALotInSeller(Integer.parseInt(env.getProperty("buyALot.size")),
                this.productService.getProductById(productId).getIdSeller().getId()));

        return "product-detail";
    }

    @GetMapping("/sellers")
    public String sellers(Model model, @RequestParam(required = false) Map<String, String> params, HttpSession s) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        String kw = params.getOrDefault("kw", "");
        model.addAttribute("sellers", this.sellerService.getSellers(kw, page));
        model.addAttribute("counterS", this.sellerService.getSellers(kw, 0).size());
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        model.addAttribute("count", env.getProperty("page.size"));
        return "sellers";
    }

    @GetMapping("/personal")
    public String personal(Model model, Authentication authentication, HttpSession s) {
        Account ac = this.userDetailsService.getAcByUsername(authentication.getName());
        model.addAttribute("ac", ac);
        try {
            if (ac.getRole().equals(Account.SELLER)) {
                model.addAttribute("sel", this.sellerService.getSellerById(ac.getSeller().getId()));
            } else if (ac.getRole().equals(Account.CUSTOMER)) {
                model.addAttribute("cus", this.customerService.getCusById(ac.getCustomer().getId()));
            } else {
                model.addAttribute("ad", this.adminService.getAdById(ac.getAdmin().getId()));
            }
        } catch (Exception e) {
            return "redirect:/";
        }
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        return "personal";
    }

    @GetMapping("/registry")
    public String registry(Model model) {
        model.addAttribute("account", new Account());
        return "registry";
    }

    @PostMapping("/registry")
    public ModelAndView registry(Model model, @ModelAttribute(value = "account") Account ac,
            BindingResult br) {
        accountValidator.validate(ac, br);
        if (br.hasErrors()) {
            return new ModelAndView("registry");
        }
        if (ac.getPassword().equals(ac.getConfirmPassword())) {
            if (ac.getRole().equals("ROLE_SELLER")) {
                ac.setActive(0);
            } else {
                ac.setActive(1);
            }
            if (this.userDetailsService.addAccount(ac) == true) {
                if (ac.getRole().equals("ROLE_CUSTOMER")) {
                    return new ModelAndView("redirect:/registry/cus", "id", ac.getId());
                } else {
                    return new ModelAndView("redirect:/registry/sel", "id", ac.getId());
                }
            } else {
                model.addAttribute("errMessage", "Có lỗi xảy ra không thể đăng ký tài khoản!!");
            }
        } else {
            model.addAttribute("errMessage", "Mật khẩu không khớp!!");
        }
        return new ModelAndView("registry");
    }

    @GetMapping("/change-password")
    public String changePass() {
        
        return "change-password";
    }
    
    @GetMapping("/registry/cus")
    public String cusView(Model model, @RequestParam(name = "id", required = false) String id) {
        model.addAttribute("customer", new Customer());
        model.addAttribute("locations", this.locationService.getLos());
        model.addAttribute("ac", this.userDetailsService.getAcById(Integer.parseInt(id)));
        model.addAttribute("action", "/registry/cus");
        return "registry-cus";
    }

    @PostMapping("/registry/cus")
    public String cus(Model model, @ModelAttribute(value = "customer") Customer cus, HttpSession s) {
        cus.setIdAccount(cus.getIdAccount());
        if (this.customerService.addCus(cus) == true) {
            if (s.getAttribute("currentAdmin") == null) {
                return "redirect:/login";
            } else {
                return "redirect:/admin/account";
            }
        } else {
            model.addAttribute("errMessage", "Có lỗi xảy ra đăng ký không thành công!!");
        }
        model.addAttribute("action", "/registry/cus");
        return "registry-cus";
    }

    @GetMapping("/registry/admin")
    public String adminView(Model model, @RequestParam(name = "id", required = false) String id) {
        model.addAttribute("admin", new Admin());
        model.addAttribute("ac", this.userDetailsService.getAcById(Integer.parseInt(id)));
        return "registry-admin";
    }

    @PostMapping("/registry/admin")
    public String admin(Model model, @ModelAttribute(value = "admin") Admin ad) {
        ad.setIdAccount(ad.getIdAccount());
        if (this.adminService.addAdmin(ad) == true) {
            return "redirect:/admin/account";
        }
        return "registry-admin";
    }

    @GetMapping("/registry/sel")
    public String selView(Model model, @RequestParam(name = "id", required = false) String id) {
        model.addAttribute("seller", new Seller());
        model.addAttribute("locations", this.locationService.getLos());
        model.addAttribute("ac", this.userDetailsService.getAcById(Integer.parseInt(id)));
        model.addAttribute("action", "/registry/sel");
        return "registry-sel";
    }

    @PostMapping("/registry/sel")
    public String sel(Model model, @ModelAttribute(value = "seller") Seller sel, HttpSession s) {
        sel.setIdAccount(sel.getIdAccount());
        if (this.sellerService.addSel(sel) == true) {
            if (s.getAttribute("currentAdmin") == null) {
                return "redirect:/login";
            } else {
                return "redirect:/admin/account";
            }
        }
        model.addAttribute("action", "/registry/sel");
        return "registry-sel";
    }
}
