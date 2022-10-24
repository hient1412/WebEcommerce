/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.validator;

import com.tmdt.pojos.Account;
import com.tmdt.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *
 * @author DELL
 */
@Component
public class AccountValidator implements Validator{
    
    @Override
    public boolean supports(Class<?> clazz) {
        return Account.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Account account = (Account) target;
        int usernameMinLength = 6;
        int usernameMaxLength = 25;
        int passwordMinLength = 8;
        int passwordMaxLength = 25;

// USERNAME
        
        if(account.getUsername().contains(" "))
            errors.rejectValue("username", "", "Tên đăng nhập không được chứa khoảng trắng!!");
        else if (account.getUsername().length() < usernameMinLength)
            errors.rejectValue("username", "", "Tên đăng nhập không được ít hơn " + usernameMinLength + " ký tự!!");
        else if (account.getUsername().length() > usernameMaxLength)
            errors.rejectValue("username", "", "Tên đăng nhập không quá " + usernameMaxLength + " ký tự!!");

// PASSWORD

        if (account.getPassword().contains(" "))
            errors.rejectValue("password", "", "Mật khẩu không được chứa khoảng trắng!!");
        else if (account.getPassword().length() < passwordMinLength)
            errors.rejectValue("password", "", "Mật khẩu cần có tối thiểu " + passwordMinLength + " ký tự!!");
        else if (account.getPassword().length() > passwordMaxLength)
            errors.rejectValue("password", "", "Mật khẩu không được quá " + passwordMaxLength + " ký tự!!");    
    }

}
