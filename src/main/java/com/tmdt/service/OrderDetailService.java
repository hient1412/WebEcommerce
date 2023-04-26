/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.service;

import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.SellerOrder;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface OrderDetailService {
    List<OrderDetail> getOrderDetail(int idOrder);
    boolean addOrderD(OrderDetail od);
    boolean addSellerOrder(SellerOrder so);
    boolean addOrderD(List<OrderDetail> od);
}
