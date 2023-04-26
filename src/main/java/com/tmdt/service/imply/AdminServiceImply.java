/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.Admin;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Report;
import com.tmdt.repository.AdminRepository;
import com.tmdt.service.AdminService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class AdminServiceImply implements AdminService{
    @Autowired
    private AdminRepository adminRepository;

    @Override
    public boolean addAdmin(Admin ad) {
        return this.adminRepository.addAdmin(ad);
    }

    @Override
    public Admin getAdById(int id) {
        return this.adminRepository.getAdById(id);
    }

    @Override
    public boolean updateAdmin(Admin ad) {
        return this.adminRepository.updateAdmin(ad);
    }

    @Override
    public List<Admin> getAdEmail(String email) {
        return this.adminRepository.getAdEmail(email);
    }

    @Override
    public List<Admin> getAdPhone(String phone) {
        return this.adminRepository.getAdPhone(phone);
    }

    @Override
    public List<Report> getReport(int product, int page) {
        return this.adminRepository.getReport(product,page);
    }

    @Override
    public List<Report> getReportWithProduct(int page) {
        return this.adminRepository.getReportWithProduct(page);
    }

    @Override
    public Report getReportById(int reportId) {
        return this.adminRepository.getReportById(reportId);
    }

    @Override
    public int updateSkip(Report r) {
        return this.adminRepository.updateSkip(r);
    }

    @Override
    public List<Report> getReportCheckAll(int id, int active) {
        return this.adminRepository.getReportCheckAll(id,active);
    }

    @Override
    public List<Report> getReportProductSeller(int page, int idSeller) {
        return this.adminRepository.getReportProductSeller(page,idSeller);
    }

    @Override
    public List<Object[]> getReportProductSeller(int page) {
        return this.adminRepository.getReportProductSeller(page);
    }

    @Override
    public List<Product> getReportSeller(int sellerId, int page) {
        return this.adminRepository.getReportSeller(sellerId,page);
    }

    
}
