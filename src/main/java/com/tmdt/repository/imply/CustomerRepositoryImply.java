/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Customer;
import com.tmdt.repository.CustomerRepository;
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
public class CustomerRepositoryImply implements CustomerRepository{

    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    
    @Override
    public boolean addCus(Customer cus) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.save(cus);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }
    
}
