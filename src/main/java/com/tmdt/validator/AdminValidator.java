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
        int nameMaxLength = 25;
        int emailMaxLength = 20;
        int phoneMaxLength = 15;

        if (admin.getName().length() < nameMinLength) {
            errors.rejectValue("name", "", "Họ và tên không được ít hơn " + nameMinLength + " kí tự!!");
        } else if (admin.getName().length() > nameMaxLength) {
            errors.rejectValue("name", "", "Họ và tên không quá " + nameMaxLength + " kí tự!!");
        } else if (admin.getEmail().length() > emailMaxLength) {
            errors.rejectValue("email", "", "Email không quá " + emailMaxLength + " kí tự!!");
        } else if (admin.getPhone().length() > phoneMaxLength) {
            errors.rejectValue("phone", "", "Số điện thoại không quá " + nameMaxLength + " kí tự!!");
        }
    }

}
