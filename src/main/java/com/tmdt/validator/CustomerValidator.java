/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.validator;

import com.tmdt.pojos.Customer;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *
 * @author DELL
 */
@Component
public class CustomerValidator implements Validator{

    @Override
    public boolean supports(Class<?> clazz) {
        return Customer.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Customer customer = (Customer) target;
        int nameMinLength = 4;
        int nameMaxLength = 25;
        int emailMaxLength = 20;
        int phoneMaxLength = 15;
        int descriptionMaxLength = 15;

        if (customer.getLastName().length() < nameMinLength) {
            errors.rejectValue("lastName", "", "Họ không được ít hơn " + nameMinLength + " kí tự!!");
        } else if (customer.getLastName().length() > nameMaxLength) {
            errors.rejectValue("lastName", "", "Họ không quá " + nameMaxLength + " kí tự!!");
        }
        
        if (customer.getFirstName().length() < nameMinLength) {
            errors.rejectValue("firstName", "", "Tên không được ít hơn " + nameMinLength + " kí tự!!");
        } else if (customer.getFirstName().length() > nameMaxLength) {
            errors.rejectValue("firstName", "", "Tên không quá " + nameMaxLength + " kí tự!!");
        }
        
        if (customer.getEmail().length() > emailMaxLength) {
            errors.rejectValue("email", "", "Email không quá " + emailMaxLength + " kí tự!!");
        }
        
        if (customer.getPhone().length() > phoneMaxLength) {
            errors.rejectValue("phone", "", "Số điện thoại không quá " + phoneMaxLength + " kí tự!!");
        }
        
        if (customer.getDescription().length() > descriptionMaxLength) {
            errors.rejectValue("description", "", "Mô tả không quá " + descriptionMaxLength + " kí tự!!");
        }
    }
    
}
