/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Review;
import com.tmdt.service.ProductService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author DELL
 */
@RestController
@RequestMapping("/api")
public class ApiReviewController {

    @Autowired
    private ProductService productService;

    @GetMapping("/product/{productId}/review")
    public ResponseEntity<List<Review>> getReview(@PathVariable(value = "productId") int id) {
        return new ResponseEntity<>(this.productService.getReview(id), HttpStatus.OK);
    }

    @PostMapping(path = "/product/{productId}/review", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<Review> addReview(@RequestBody Map<String, String> params) {
        try {
            String content = params.get("content");
            int idProduct = Integer.parseInt(params.get("idProduct"));
            int rating = Integer.parseInt(params.get("rating"));
            Review rv = this.productService.addReview(content, idProduct,rating);
            return new ResponseEntity<>(rv, HttpStatus.CREATED);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return new ResponseEntity<Review>(HttpStatus.BAD_REQUEST);
    }
}
