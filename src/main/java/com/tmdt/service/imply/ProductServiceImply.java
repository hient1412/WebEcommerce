/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.Image;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Review;
import com.tmdt.repository.ProductRepository;
import com.tmdt.service.ProductService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class ProductServiceImply implements ProductService{

    @Autowired
    private ProductRepository productRepository;
    
    @Override
    public List<Product> getProducts(Map<String,String> params,int page) {
        return this.productRepository.getProducts(params,page);
    }

    @Override
    public Product getProductById(int productId) {
        return this.productRepository.getProductById(productId);
    }

    @Override
    public List<Product> getProducts() {
        return this.productRepository.getProducts();
    }

    @Override
    public List<Product> getProductByCateId(int cateId, int page) {
        return this.productRepository.getProductByCateId(cateId,page);
    }

    @Override
    public boolean addProduct(Product p) {
        return this.productRepository.addProduct(p);
    }

    @Override
    public List<Product> getProductBySellerId(int sellerId, int page) {
        return this.productRepository.getProductBySellerId(sellerId,page);
    }

    @Override
    public boolean updateProduct(Product p) {
        return this.productRepository.updateProduct(p);
    }

    @Override
    public List<Object[]> getProductBuyALot(int num) {
        return this.productRepository.getProductBuyALot(num);
    }
     @Override
    public List<Object[]> getProductBuyALotInSeller(int num,int sellerId) {
        return this.productRepository.getProductBuyALotInSeller(num,sellerId);
    }

    @Override
    public List<Review> getReview(int productId) {
        return this.productRepository.getReview(productId);
    }

    @Override
    public Review addReview(String review, int productId) {
        return this.productRepository.addReview(review,productId);
    }
    
}
