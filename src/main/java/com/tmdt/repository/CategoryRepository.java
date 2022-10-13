/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.repository;

import com.tmdt.pojos.Category;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface CategoryRepository {
    List<Category> getCates();
    Category getCateById(int cateId);
    List<Category> getCateBySellerId(int sellerId);
}
