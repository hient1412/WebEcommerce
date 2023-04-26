

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.repository;

import com.tmdt.pojos.Admin;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Report;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface AdminRepository {
    boolean addAdmin(Admin ad);
    Admin getAdById(int id);
    boolean updateAdmin(Admin ad);
    List<Admin> getAdEmail(String email);
    List<Admin> getAdPhone(String phone);
    List<Report> getReport(int product,int page);
    List<Report> getReportWithProduct(int page);
    Report getReportById(int reportId);
    int updateSkip(Report r);
    List<Report> getReportCheckAll(int id, int active);
    List<Object[]> getReportProductSeller(int page);
    List<Report> getReportProductSeller(int page,int idSeller);
    List<Product> getReportSeller(int sellerId, int page);
}
