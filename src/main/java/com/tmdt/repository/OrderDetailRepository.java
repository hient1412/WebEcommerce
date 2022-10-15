/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.repository;

import com.tmdt.pojos.OrderDetail;
import java.util.List;
import java.util.Map;

/**
 *
 * @author DELL
 */
public interface OrderDetailRepository {
    List<OrderDetail> getOrderDetail(int idOrder);
}
