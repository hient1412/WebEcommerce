/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Category;
import com.tmdt.pojos.Product;
import com.tmdt.service.CategoryService;
import com.tmdt.service.ProductService;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author DELL
 */
@Controller
@ControllerAdvice
public class HomeController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ProductService productService;
    
    @ModelAttribute
    public void common(Model model){
        model.addAttribute("categories", this.categoryService.getCates());
    }
    
    @RequestMapping("/")
    public String home(Model model,@RequestParam(required = false) Map<String,String> params) {
        String kw = params.getOrDefault("kw","");
        int page = Integer.parseInt(params.getOrDefault("page","1"));
        
        String cateId = params.get("cateId");
        if(cateId == null){
            model.addAttribute("product",this.productService.getProducts(kw, page));
        } else {
            Category c = this.categoryService.getCateById(Integer.parseInt(cateId));
            Set<Product> sp = new HashSet<>();
            sp.addAll(c.getProductCollection());
            model.addAttribute("product",sp);
        }
        return "home";
    }
    
    @RequestMapping("/search")
    public String search(Model model,
            @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        model.addAttribute("kw", params.get("kw"));
        model.addAttribute("categories", this.categoryService.getCates());
        model.addAttribute("product", this.productService.getProducts(params.get("kw"), page));
        model.addAttribute("counterS", this.productService.getProducts(params.get("kw"), page).size());
        return "search";
    }
}
