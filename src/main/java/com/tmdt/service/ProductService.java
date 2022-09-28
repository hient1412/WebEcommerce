/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.service;

import com.tmdt.pojos.Product;
import java.util.List;
import java.util.Map;

/**
 *
 * @author DELL
 */
public interface ProductService {
    List<Product> getProducts();
    List<Product> getProducts(Map<String,String> params,int page);
    Product getProductById(int productId);
    List<Product> getProductByCateId(int cateId,int page);
}
