/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.validator;

import com.tmdt.pojos.Admin;
import com.tmdt.service.AccountService;
import com.tmdt.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *
 * @author DELL
 */
@Component
public class AdminValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return Admin.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Admin admin = (Admin) target;
        int nameMinLength = 4;
        int nameMaxLength = 30;
        int emailMaxLength = 40;
        int emailMinLength = 16;
        int phoneMinLength = 10;
        int phoneMaxLength = 11;

        if (admin.getName().length() < nameMinLength) {
            errors.rejectValue("name", "", "Họ và tên không được ít hơn " + nameMinLength + " kí tự!!");
        } else if (admin.getName().length() > nameMaxLength) {
            errors.rejectValue("name", "", "Họ và tên không quá " + nameMaxLength + " kí tự!!");
        }
        
        if (admin.getEmail().length() < emailMinLength) {
            errors.rejectValue("name", "", "Email không được ít hơn " + 6 + " kí tự!!");
        } else if (admin.getEmail().length() > emailMaxLength) {
            errors.rejectValue("email", "", "Email không quá " + 30 + " kí tự!!");
        }
        
        if (admin.getPhone().length() < phoneMinLength) {
            errors.rejectValue("phone", "", "Số điện thoại được ít hơn " + phoneMinLength + " kí tự!!");
        } else if (admin.getPhone().length() > phoneMaxLength) {
            errors.rejectValue("phone", "", "Số điện thoại không quá " + phoneMaxLength + " kí tự!!");
        }
    }

}
