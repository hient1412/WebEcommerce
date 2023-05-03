/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.validator;

import com.tmdt.pojos.Category;
import com.tmdt.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *
 * @author DELL
 */
@Component
public class CategoryValidator implements Validator{

    @Override
    public boolean supports(Class<?> clazz) {
        return Category.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Category category = (Category) target;
        int nameMinLength = 4;
        int nameMaxLength = 25;
        int descriptionMaxLength = 30;
        
        if(category.getName().length() < nameMinLength)
            errors.rejectValue("name", "", "Tên loại sản phẩm không được ít hơn " + nameMinLength + " ký tự!!");
        else if(category.getName().length() > nameMaxLength)
            errors.rejectValue("name", "", "Tên loại sản phẩm không quá " + nameMaxLength + " ký tự!!");
        
        if(category.getDescription().length() > descriptionMaxLength)
            errors.rejectValue("description", "", "Mô tả không quá " + descriptionMaxLength + " ký tự!!");
    }
    
}
