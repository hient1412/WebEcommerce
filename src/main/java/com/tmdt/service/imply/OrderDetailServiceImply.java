/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.SellerOrder;
import com.tmdt.repository.OrderDetailRepository;
import com.tmdt.service.OrderDetailService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class OrderDetailServiceImply implements OrderDetailService{
    
    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Override
    public List<OrderDetail> getOrderDetail(int idOrder) {
        return this.orderDetailRepository.getOrderDetail(idOrder);
    }

    @Override
    public boolean addOrderD(OrderDetail od) {
        return this.orderDetailRepository.addOrderD(od);
    }

    @Override
    public boolean addSellerOrder(SellerOrder so) {
        return this.orderDetailRepository.addSellerOrder(so);
    }

    @Override
    public boolean addOrderD(List<OrderDetail> od) {
        return this.orderDetailRepository.addOrderD(od);
    }
}
