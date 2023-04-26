/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.service;

import com.tmdt.pojos.Customer;
import com.tmdt.pojos.Likes;
import com.tmdt.pojos.Report;
import com.tmdt.pojos.ShipAdress;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface CustomerService {
    boolean addCus(Customer cus);
    Customer getCusById(int id);
    boolean updateCustomer(Customer c);
    List<Customer> getCusEmail(String email);
    List<Customer> getCusPhone(String phone);
    List<ShipAdress> getShipAdress(int customerId);
    ShipAdress addShipAdress(String name, String phone, String address,String ward,String district, int city,int customerId);
    boolean addShip(ShipAdress s);
    boolean deleteS(ShipAdress s);
    ShipAdress getShipById(int id);
    boolean updateS(ShipAdress s);
    List<ShipAdress> getShipAdressPriority(int priority,int idCustomer);
    int setdefaultShip(ShipAdress s);
    ShipAdress findShipPriority (Customer c);
    Customer getCusByEmail (String email);
    boolean addReport(Report r);
    List<Likes> getLikeByCusId(int id);
}
