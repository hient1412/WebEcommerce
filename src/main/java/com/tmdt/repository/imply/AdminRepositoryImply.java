/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Admin;
import com.tmdt.repository.AdminRepository;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author DELL
 */
@Repository
@Transactional
public class AdminRepositoryImply implements AdminRepository{

    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    
    @Override
    public boolean addAdmin(Admin ad) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.save(ad);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }
    @Override
    public Admin getAdById(int id) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        return s.get(Admin.class, id);
    }

    @Override
    public boolean updateAdmin(Admin ad) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            Admin admin = this.getAdById(ad.getId());
            admin.setEmail(ad.getEmail());
            admin.setName(ad.getName());
            admin.setPhone(ad.getPhone());
            admin.setGender(ad.getGender());
            s.update(admin);
            
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }
}
