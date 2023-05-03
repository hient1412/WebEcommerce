/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.cloudinary.utils.ObjectUtils;
import com.tmdt.pojos.Image;
import com.tmdt.pojos.Likes;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Report;
import com.tmdt.pojos.Review;
import com.tmdt.pojos.Seller;
import com.tmdt.repository.ProductRepository;
import com.tmdt.service.ProductService;
import java.io.IOException;
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
    public List<Product> getProductBySellerId(Map<String,String> params,int sellerId, int page) {
        return this.productRepository.getProductBySellerId(params,sellerId,page);
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
    public Review addReview(String review, int productId,int rating) {
        return this.productRepository.addReview(review,productId, rating);
    }

    @Override
    public List<Product> getProductBySeller(Map<String,String> params,int sellerId, int page) {
        return this.productRepository.getProductBySeller(params,sellerId,page);
    }

    @Override
    public int updateProductHide(Product p) {
        return this.productRepository.updateProductHide(p);
    }

    @Override
    public List getRating(int productId) {
        return this.productRepository.getRating(productId);
    }

    @Override
    public List getRatingSeller(int sellerId) {
        return this.productRepository.getRatingSeller(sellerId);
    }

    @Override
    public List<Likes> getLikesOfProduct(int productId) {
        return this.productRepository.getLikesOfProduct(productId);
    }

    @Override
    public long checkPermissionAddReview(int productId) {
        return this.productRepository.checkPermissionAddReview(productId);
    }

    @Override
    public int updateProductBan(Product p) {
        return this.productRepository.updateProductBan(p);
    }


    @Override
    public boolean addLike(Likes likes) {
        return this.productRepository.addLike(likes);
    }

    @Override
    public boolean delete(Likes likes) {
        return this.productRepository.delete(likes);
    }

    @Override
    public Likes getLikeByCusId(int productId, int customerId) {
        return this.productRepository.getLikeByCusId(productId,customerId);
    }

    @Override
    public long checkExistReview(int productId, int accountId) {
        return this.productRepository.checkExistReview(productId,accountId);
    }

    @Override
    public long checkExistLike(int productId, int cusId) {
        return this.productRepository.checkExistLike(productId,cusId);
    }

    @Override
    public List<Object[]> getProductLikeALot(int num) {
        return this.productRepository.getProductLikeALot(num);
    }

    @Override
    public long checkExistReport(int productId, int customerId) {
        return this.productRepository.checkExistReport(productId,customerId);
    }

    @Override
    public List<Product> getProductId(int productId) {
        return this.productRepository.getProductId(productId);
    }
    
}
