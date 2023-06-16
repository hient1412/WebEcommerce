/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.validator;

import com.tmdt.pojos.Product;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *
 * @author DELL
 */
@Component
public class ProductValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return Product.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Product product = (Product) target;
        int nameMinLength = 4;
        int nameMaxLength = 255;
        int priceMinLength = 4;
        int priceMaxLength = 12;
        int manufacturerMinLength = 4;
        int manufacturerMaxLength = 50;
        int descriptionMaxLength = 255;

        if (product.getName().length() < nameMinLength) {
            errors.rejectValue("name", "", "Tên sản phẩm không được ít hơn " + nameMinLength + " ký tự!!");
        } else if (product.getName().length() > nameMaxLength) {
            errors.rejectValue("name", "", "Tên sản phẩm không quá " + nameMaxLength + " ký tự!!");
        }
        
        if (product.getPrice().toString().length() < priceMinLength) {
            errors.rejectValue("price", "", "Giá sản phẩm không được ít hơn 1000đ !!");
        } else if (product.getPrice().toString().length() > priceMaxLength) {
            errors.rejectValue("price", "", "Giá sản phẩm không quá 999.999.999.999đ !!");
        }

        if (product.getManufacturer().length() < manufacturerMinLength) {
            errors.rejectValue("price", "", "Tên thương hiệu không được ít hơn " + manufacturerMinLength + " ký tự!!");
        } else if (product.getManufacturer().length() > manufacturerMaxLength) {
            errors.rejectValue("manufacturer", "", "Tên thương hiệu không quá " + manufacturerMaxLength + " ký tự!!");
        }
        if (product.getDescription().length() > descriptionMaxLength) {
            errors.rejectValue("description", "", "Mô tả không quá " + descriptionMaxLength + " ký tự!!");
        }
    }
}
