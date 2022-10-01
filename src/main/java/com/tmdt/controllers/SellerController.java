/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.tmdt.pojos.Account;
import com.tmdt.pojos.Image;
import com.tmdt.pojos.Product;
import com.tmdt.repository.CategoryRepository;
import com.tmdt.service.AccountService;
import com.tmdt.service.ImageService;
import com.tmdt.service.ProductService;
import java.io.IOException;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
@RequestMapping("/seller")
public class SellerController {

    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private AccountService accountService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private Environment env;
    @Autowired
    private Cloudinary cloudinary;

    @GetMapping("/view")
    public String sellerView(Model model) {
        return "seller-view";
    }
    
    @GetMapping("/list-product-upload")
    public String sellerListProduct(Model model, @RequestParam(required = false) Map<String, String> params, Authentication a ) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        Account ac = this.accountService.getAcByUsername(a.getName());
        int id = ac.getSeller().getId();
        model.addAttribute("product", this.productService.getProductBySellerId(id, page));
        model.addAttribute("counterS", this.productService.getProductBySellerId(id, 0).size());
        model.addAttribute("count", env.getProperty("page.size"));
        return "list-product-upload";
    }

    @GetMapping("/product")
    public String productView(Model model) {
        model.addAttribute("categories", this.categoryRepository.getCates());
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
        model.addAttribute("categories", this.categoryRepository.getCates());
        model.addAttribute("product", this.productService.getProductById(id));
        return "product-edit";
    }

    @PostMapping("/product-edit")
    public String productEdit(Model model, @ModelAttribute(value = "product") Product pd,
            RedirectAttributes r, Authentication a) {
        Account ac = this.accountService.getAcByUsername(a.getName());
        pd.setIdSeller(ac.getSeller());
        String errMessage = "";
        pd.setActive(1);
        if (this.productService.updateProduct(pd) == true) {
            for (int j = 0; j < pd.getFile().length; j++) {
                try {
                    Image img = this.imageService.getImageByProductId(pd.getId()).get(j);
                    Map map = this.cloudinary.uploader().upload(pd.getFile()[j].getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                    img.setImage((String) map.get("secure_url"));
                    this.imageService.updateImage(img);
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
                errMessage = String.format("Đã chỉnh sửa thành công thành công sản phẩm: '%s'", pd.getName());
                return "redirect:/seller/list-product-upload?id=" + pd.getIdSeller().getId();
            }
        } else {
            errMessage = String.format("Có lỗi xảy ra không thể chỉnh sửa sản phẩm: '%s'", pd.getName());
        }
        r.addFlashAttribute("errMessage", errMessage);
        model.addAttribute("errMessage", errMessage);
        return "product-edit";
    }
    @GetMapping("/product-hide")
    public String productHide(Model model,RedirectAttributes r,
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
        return "redirect:/seller/list-product-upload?id="+ pd.getId();
    }
    
    @GetMapping("/product-show")
    public String productShow(Model model,RedirectAttributes r,
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
        return "redirect:/seller/list-product-upload?id="+ pd.getId();
    }
}
