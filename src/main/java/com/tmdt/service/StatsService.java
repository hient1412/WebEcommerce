/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.service;

import java.util.Date;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface StatsService {
    List<Object[]> countRole();
    List<Object[]> countCategories();
    List<Object[]> statsProduct(String kw,Date fromDate, Date toDate);
}
