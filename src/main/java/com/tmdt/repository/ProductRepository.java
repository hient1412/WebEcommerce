/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.repository;

import com.tmdt.pojos.Product;
import com.tmdt.pojos.Review;
import com.tmdt.pojos.Seller;
import java.util.List;
import java.util.Map;

/**
 *
 * @author DELL
 */
public interface ProductRepository {
    List<Product> getProducts();
    List<Product> getProducts(Map<String,String> params,int page);
    Product getProductById(int productId);
    List<Product> getProductByCateId(int cateId,int page);
    boolean addProduct(Product p);
    boolean updateProduct(Product p);
    int updateProductHide(Product p);
    List<Product> getProductBySellerId(Map<String,String> params,int sellerId, int page);
    List<Object[]> getProductBuyALot(int num);
    List<Object[]> getProductBuyALotInSeller(int num,int sellerId);
    List<Review> getReview(int productId);
    Review addReview(String review, int productId, int rating);
    List<Product> getProductBySeller(Map<String,String> params,int sellerId,int page);
    List getRating(int productId);
}
