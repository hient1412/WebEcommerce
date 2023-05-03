/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.Cancel;
import com.tmdt.pojos.Cart;
import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.Orders;
import com.tmdt.pojos.SellerOrder;
import com.tmdt.repository.OrderRepository;
import com.tmdt.service.OrderService;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class OrderServiceImply implements OrderService{
    @Autowired
    private OrderRepository orderRepository;

    @Override
    public List<Orders> getOrderBySellerId(Map<String, String> params, int sellerId, int page) {
        return this.orderRepository.getOrderBySellerId(params, sellerId, page);
    }
    @Override
    public List<Orders> getOrderByCusId(Map<String, String> params, int cusId, int page) {
        return this.orderRepository.getOrderByCusId(params, cusId, page);
    }

    @Override
    public Orders getOrderById(int id) {
        return this.orderRepository.getOrderById(id);
    }

    @Override
    public boolean addReceipt(Map<Integer, Cart> cart) {
        if (cart != null) {
            return this.orderRepository.addReceipt(cart);
        } else {
            return false;
        }
    }

    @Override
    public boolean addCancel(Cancel cancel) {
        cancel.setCancelDate(new Date());
        return this.orderRepository.addCancel(cancel);
    }

    @Override
    public int updateActive(Orders o) {
        return this.orderRepository.updateActive(o);
    }

    @Override
    public Cancel getCancel(Orders o) {
        return this.orderRepository.getCancel(o);
    }

    @Override
    public int updateActiveAndSend(Orders o) {
        return this.orderRepository.updateActiveAndSend(o);
    }

    @Override
    public int updateActiveAndReceived(Orders o) {
        o.setOrderReceived(new Date());
        return this.orderRepository.updateActiveAndReceived(o);
    }

    @Override
    public boolean addOrder(Orders o) {
        return this.orderRepository.addOrder(o);
    }

    @Override
    public List<Orders> getOrderId(int orderId) {
        return this.orderRepository.getOrderId(orderId);
    }

}
