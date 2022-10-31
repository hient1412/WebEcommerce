/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.repository;

import java.util.Date;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface StatsRepository {
    List<Object[]> countRole();
    List<Object[]> countCategories(int idSeller);
    List<Object[]> countAdminProCategories();
    List<Object[]> statsProduct(String kw,Date fromDate, Date toDate);
    List<Object[]> statsProduct(String kw,Date fromDate, Date toDate, int seller);
}
