/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.Orders;
import com.tmdt.repository.OrderRepository;
import com.tmdt.service.OrderService;
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
    public List<Object[]> getOrderBySellerId(Map<String, String> params, int sellerId, int page) {
        return this.orderRepository.getOrderBySellerId(params, sellerId, page);
    }
}
