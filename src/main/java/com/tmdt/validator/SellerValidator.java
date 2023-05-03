/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.validator;

import com.tmdt.pojos.Seller;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *
 * @author DELL
 */
@Component
public class SellerValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return Seller.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Seller seller = (Seller) target;
        int nameMinLength = 4;
        int nameMaxLength = 50;
        int addressMinLength = 8;
        int addressMaxLength = 50;
        int emailMinLength = 16;
        int emailMaxLength = 40;
        int phoneMinLength = 10;
        int phoneMaxLength = 11;
        int descriptionMaxLength = 150;

        if (seller.getName().length() < nameMinLength) {
            errors.rejectValue("name", "", "Tên cửa hàng không được ít hơn " + nameMinLength + " ký tự!!");
        } else if (seller.getName().length() > nameMaxLength) {
            errors.rejectValue("name", "", "Tên cửa hàng không quá " + nameMaxLength + " ký tự!!");
        }

        if (seller.getAddress().length() < addressMinLength) {
            errors.rejectValue("address", "", "Địa chỉ không được ít hơn " + addressMinLength + " ký tự!!");
        } else if (seller.getAddress().length() > addressMaxLength) {
            errors.rejectValue("address", "", "Địa chỉ không quá " + addressMaxLength + " ký tự!!");
        }
        if (seller.getEmail().length() < emailMinLength) {
            errors.rejectValue("email", "", "Email không được ít hơn " + 6 + " ký tự!!");
        } else if (seller.getEmail().length() > emailMaxLength) {
            errors.rejectValue("email", "", "Email không quá " + 30 + " ký tự!!");

        }
        if (seller.getPhone().length() < phoneMinLength) {
            errors.rejectValue("phone", "", "Số điện thoại không được ít hơn " + phoneMinLength + " ký tự!!");
        } else if (seller.getPhone().length() > phoneMaxLength) {
            errors.rejectValue("phone", "", "Số điện thoại không quá " + phoneMaxLength + " ký tự!!");
        }

        if (seller.getDescription().length() > descriptionMaxLength) {
            errors.rejectValue("description", "", "Mô tả không quá " + descriptionMaxLength + " ký tự!!");
        }
    }

}
