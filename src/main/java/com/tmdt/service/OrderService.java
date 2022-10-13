/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.service;

import com.tmdt.pojos.Orders;
import java.util.List;
import java.util.Map;

/**
 *
 * @author DELL
 */
public interface OrderService {
    List<Object[]> getOrderBySellerId(Map<String,String> params,int sellerId, int page);
}
