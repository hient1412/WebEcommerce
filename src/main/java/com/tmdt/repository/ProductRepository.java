/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.repository;

import com.tmdt.pojos.Product;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface ProductRepository {
    List<Product> getProducts();
    List<Object[]> getProducts(String kw,int page);
    Product getProductById(int productId);
}
