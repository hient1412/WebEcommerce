/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.repository;

import com.tmdt.pojos.Customer;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface CustomerRepository {
    boolean addCus(Customer cus);
    Customer getCusById(int id);
    boolean updateCustomer(Customer c);
    List<Customer> getCusEmail(String email);
    List<Customer> getCusPhone(String phone);
}
