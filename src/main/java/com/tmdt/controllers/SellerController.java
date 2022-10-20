/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.tmdt.pojos.Account;
import com.tmdt.pojos.Image;
import com.tmdt.pojos.Orders;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Seller;
import com.tmdt.service.AccountService;
import com.tmdt.service.CategoryService;
import com.tmdt.service.ImageService;
import com.tmdt.service.LocationService;
import com.tmdt.service.OrderDetailService;
import com.tmdt.service.OrderService;
import com.tmdt.service.ProductService;
import com.tmdt.service.SellerService;
import com.tmdt.service.StatsService;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author DELL
 */
@Controller
@RequestMapping("/seller")
public class SellerController {

    @Autowired
    private StatsService statsService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private LocationService locationService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private ProductService productService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private SellerService sellerService;
    @Autowired
    private OrderDetailService orderDetailService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private Environment env;
    @Autowired
    private Cloudinary cloudinary;

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard-seller";
    }
    
    @GetMapping("/edit")
    public String sellerEditView(Model model, Authentication authentication) {
        Account ac = this.accountService.getAcByUsername(authentication.getName());
        model.addAttribute("locations", this.locationService.getLos());
        model.addAttribute("seller", ac.getSeller());
        return "seller-edit";
    }

    @PostMapping("/edit")
    public String sellerEdit(Model model, @ModelAttribute(value = "seller") Seller seller, RedirectAttributes r,Authentication a) {
        Account ac = this.accountService.getAcByUsername(a.getName());
        Seller sellerOld = this.sellerService.getSellerById(ac.getSeller().getId());
        if(seller.getFile().isEmpty()){
            seller.setAvatar(sellerOld.getAvatar());
        }
        if (this.sellerService.updateSeller(seller) == true) {
            r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
            return "redirect:/personal";
        } else {
            model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
        }
        return "seller-edit";
    }

    @GetMapping("/list-product-upload")
    public String sellerListProduct(Model model, @RequestParam(required = false) Map<String, String> params, Authentication a) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        Account ac = this.accountService.getAcByUsername(a.getName());
        int id = ac.getSeller().getId();
        model.addAttribute("cateBySeller", this.categoryService.getCateBySellerId(id));
        Map<String, String> pre = new HashMap<>();
        pre.put("kw", params.getOrDefault("kw", ""));
        pre.put("quantityMin", params.getOrDefault("quantityMin", ""));
        pre.put("quantityMax", params.getOrDefault("quantityMax", ""));
        pre.put("cat", params.getOrDefault("cat", ""));
        pre.put("active", params.getOrDefault("active", ""));
        model.addAttribute("product", this.productService.getProductBySellerId(pre, id, page));
        model.addAttribute("counterS", this.productService.getProductBySellerId(pre, id, 0).size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "list-product-upload";
    }

    @GetMapping("/list-order")
    public String listView(Model model, @RequestParam(required = false) Map<String, String> params, Authentication a) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        Account ac = this.accountService.getAcByUsername(a.getName());
        int id = ac.getSeller().getId();
        Map<String, String> pre = new HashMap<>();
        pre.put("idOrder", params.getOrDefault("idOrder", ""));
        pre.put("nameCus", params.getOrDefault("nameCus", ""));
        pre.put("namePro", params.getOrDefault("namePro", ""));
        pre.put("active", params.getOrDefault("active", ""));
        model.addAttribute("orderDetail", this.orderDetailService);
        model.addAttribute("orders", this.orderService.getOrderBySellerId(pre, id, page));
        model.addAttribute("counterS", this.orderService.getOrderBySellerId(pre, id, 0).size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "list-order";
    } 
    
    @GetMapping("/product")
    public String productView(Model model) {
        model.addAttribute("categories", this.categoryService.getCates());
        model.addAttribute("product", new Product());
        return "product-upload";
    }

    @PostMapping("/product")
    public String product(Model model, @ModelAttribute(value = "product") Product pd,
            RedirectAttributes r, Authentication a) {
        Account ac = this.accountService.getAcByUsername(a.getName());
        if (ac.getRole().equals(Account.SELLER)) {
            if (ac.getActive() == 1) {
                pd.setIdSeller(ac.getSeller());
                pd.setActive(1);
                Image img = new Image();
                img.setIdProduct(pd);
                if (this.productService.addProduct(pd) == true) {
                    for (int j = 0; j < pd.getFile().length; j++) {
                        try {
                            Map map = this.cloudinary.uploader().upload(pd.getFile()[j].getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                            img.setImage((String) map.get("secure_url"));
                            this.imageService.addImage(img);
                        } catch (IOException ex) {
                            ex.printStackTrace();
                        }
                    }
                    r.addFlashAttribute("errMessage", String.format("Đăng thành công sản phẩm '%s'", pd.getName()));
                    return "redirect:/seller/list-product-upload?id=" + ac.getSeller().getId();
                }
            } else {
                model.addAttribute("errMessage", String.format("Có lỗi xảy ra không thể đăng tin '%s'", pd.getName()));
            }
        }
        return "product-upload";
    }

    @GetMapping("/product-edit")
    public String productEditView(Model model, @RequestParam(name = "id") int id) {
        model.addAttribute("categories", this.categoryService.getCates());
        model.addAttribute("product", this.productService.getProductById(id));
        return "product-edit";
    }

    @PostMapping("/product-edit")
    public String productEdit(Model model, @ModelAttribute(value = "product") Product pd,
            @RequestParam(name = "id") int id, RedirectAttributes r, Authentication a) {
        Product productOld = this.productService.getProductById(id);
        Account ac = this.accountService.getAcByUsername(a.getName());
        pd.setIdSeller(ac.getSeller());
        String errMessage = "";
        pd.setActive(1);
        pd.setIsDelete(0);
        int size = this.productService.getProductById(id).getImageCollection().size();
        Image img = new Image();
        if (this.productService.updateProduct(pd) == true) {
            if (pd.getFile()[0].getSize() == 0) {
                for (int i = 0; i < this.imageService.getImageByProductId(productOld.getId()).size(); i++) {
                    img.setImage(this.imageService.getImageByProductId(productOld.getId()).get(0).getImage());
                }
            } else {
                for (int i = 0; i < size; i++) {
                    this.imageService.delete(this.imageService.getImageByProductId(productOld.getId()).get(0));
                }
                img.setIdProduct(pd);
                for (int j = 0; j < pd.getFile().length; j++) {
                    try {
                        Map map = this.cloudinary.uploader().upload(pd.getFile()[j].getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                        img.setImage((String) map.get("secure_url"));
                        this.imageService.addImage(img);
                    } catch (IOException ex) {
                        ex.printStackTrace();
                    }
                }
            }
            errMessage = String.format("Đã chỉnh sửa thành công thành công sản phẩm: '%s'", pd.getName());
            return "redirect:/seller/list-product-upload?id=" + pd.getIdSeller().getId();
        } else {
            errMessage = String.format("Có lỗi xảy ra không thể chỉnh sửa sản phẩm: '%s'", pd.getName());
        }
        r.addFlashAttribute("errMessage", errMessage);
        model.addAttribute("errMessage", errMessage);
        return "product-edit";
    }
    
    @GetMapping("/product-delete")
    public String productDelete(Model model, @RequestParam(name = "id") int id,
            RedirectAttributes r) {
        String errMessage = "";
        Product p = this.productService.getProductById(id);
        p.setIsDelete(1);
        if (this.productService.updateProduct(p) == true) {
            r.addFlashAttribute("errMessage", String.format("Xóa thành công sản phẩm '%s'", p.getName()));
        } else {
            r.addFlashAttribute("errMessage", "Có lỗi xảy ra không thể xóa sản phẩm");
        }
        return "redirect:/seller/list-product-upload";
    }

    @GetMapping("/product-hide")
    public String productHide(Model model, RedirectAttributes r,
            @RequestParam(name = "id") int id) {
        String errMessage = "";
        Product pd = this.productService.getProductById(id);
        pd.setActive(0);
        if (this.productService.updateProduct(pd) == true) {
            if (pd.getActive() == 0) {
                errMessage = String.format("Đã ẩn thành công sản phẩm: '%s'", pd.getName());
            } else {
                errMessage = String.format("Có lỗi xảy ra khi ẩn sản phẩm: '%s'", pd.getName());
            }
        }
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/seller/list-product-upload?id=" + pd.getId();
    }

    @GetMapping("/product-show")
    public String productShow(Model model, RedirectAttributes r,
            @RequestParam(name = "id") int id) {
        String errMessage = "";
        Product pd = this.productService.getProductById(id);
        pd.setActive(1);
        if (this.productService.updateProduct(pd) == true) {
            if (pd.getActive() == 1) {
                errMessage = String.format("Đã hiện thành công sản phẩm: '%s'", pd.getName());
            } else {
                errMessage = String.format("Có lỗi xảy ra khi hiện sản phẩm: '%s'", pd.getName());
            }
        }
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/seller/list-product-upload?id=" + pd.getId();
    }

    @GetMapping("/stats/categories")
    public String statsCategories(Model model, Authentication a) {
        Account ac = this.accountService.getAcByUsername(a.getName());
        model.addAttribute("countcate", this.statsService.countCategories(ac.getSeller().getId()));
        return "stats-categories";
    }

    @GetMapping("/stats/turnover/product")
    public String turnoverProduct(Model model,
            @RequestParam(required = false) Map<String, String> params) throws ParseException {
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        String kw = params.getOrDefault("kw", null);
        Date fromDate = null;
        Date toDate = null;
        try {
            String from = params.getOrDefault("fromDate", null);
            if (from != null) {
                fromDate = f.parse(from);
            }
            String to = params.getOrDefault("toDate", null);
            if (to != null) {
                toDate = f.parse(to);
            }
        } catch (ParseException ex) {
            ex.printStackTrace();
        }
        model.addAttribute("statsProduct", this.statsService.statsProduct(kw, fromDate, toDate));
        return "stats-turnover";
    }
}
