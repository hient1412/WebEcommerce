/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.validator;

import com.tmdt.pojos.ShipAdress;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *
 * @author DELL
 */
@Component
public class ShipAddressValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return ShipAdress.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        ShipAdress s = (ShipAdress) target;
        int nameMinLength = 4;
        int nameMaxLength = 25;
        int phoneMinlength = 10;
        int phoneMaxlength = 11;
        int addressMinLength = 6;
        int addressMaxLength = 50;
        int wardMinLength = 4;
        int wardMaxLength = 25;
        int districtMinLength = 4;
        int districtMaxLength = 25;

        if (s.getName().length() < nameMinLength) {
            errors.rejectValue("name", "", "Họ tên người nhận không được ít hơn " + nameMinLength + " ký tự!!");
        } else if (s.getName().length() > nameMaxLength) {
            errors.rejectValue("name", "", "Họ tên người nhận không quá " + nameMaxLength + " ký tự!!");
        }

        if (s.getPhone().length() < phoneMinlength) {
            errors.rejectValue("phone", "", "Số điện thoại không được ít hơn " + phoneMinlength + " ký tự!!");
        } else if (s.getPhone().length() > phoneMaxlength) {
            errors.rejectValue("phone", "", "Số điện thoại không quá " + phoneMaxlength + " ký tự!!");
        }

        if (s.getWard().length() < wardMinLength) {
            errors.rejectValue("ward", "", "Phường/Xã không được ít hơn " + wardMinLength + " ký tự!!");
        } else if (s.getWard().length() > wardMaxLength) {
            errors.rejectValue("ward", "", "Phường/Xã không quá " + wardMaxLength + " ký tự!!");
        }
        
        if (s.getDistrict().length() < districtMinLength) {
            errors.rejectValue("district", "", "Quận/Huyện không được ít hơn " + districtMinLength + " ký tự!!");
        } else if (s.getDistrict().length() > districtMaxLength) {
            errors.rejectValue("district", "", "Quận/Huyện không quá " + districtMaxLength + " ký tự!!");
        }
        
        if (s.getAddress().length() < addressMinLength) {
            errors.rejectValue("address", "", "Địa chỉ không được ít hơn " + addressMinLength + " ký tự!!");
        } else if (s.getAddress().length() > addressMaxLength) {
            errors.rejectValue("address", "", "Địa chỉ không quá " + addressMaxLength + " ký tự!!");
        }
    }
}