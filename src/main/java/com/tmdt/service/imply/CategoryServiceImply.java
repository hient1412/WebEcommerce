/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.Category;
import com.tmdt.repository.CategoryRepository;
import com.tmdt.service.CategoryService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class CategoryServiceImply implements CategoryService{

    @Autowired
    private CategoryRepository categoryRepository;
    
    @Override
    public List<Category> getCates() {
        return this.categoryRepository.getCates();
    }

    @Override
    public Category getCateById(int cateId) {
        return this.categoryRepository.getCateById(cateId);
    }

    @Override
    public List<Category> getCateBySellerId(int sellerId) {
        return this.categoryRepository.getCateBySellerId(sellerId);
    }

    @Override
    public List<Category> getCates(int page) {
        return this.categoryRepository.getCates(page);
    }

    @Override
    public boolean addCate(Category c) {
        return this.categoryRepository.addCate(c);
    }

    @Override
    public boolean updateCate(Category c) {
        return this.categoryRepository.updateCate(c);
    }

    @Override
    public List<Category> getCates(String name) {
        return this.categoryRepository.getCates(name);
    }
    
}
