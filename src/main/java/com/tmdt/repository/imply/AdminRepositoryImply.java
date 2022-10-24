/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Admin;
import com.tmdt.repository.AdminRepository;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
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

    @Override
    public List<Admin> getAdEmail(String email) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Admin> q = builder.createQuery(Admin.class);
        Root root = q.from(Admin.class);
        q.select(root);
        
        q.where(builder.equal(root.get("email"), email));
        
        Query query = session.createQuery(q);

        return query.getResultList();
    }

    @Override
    public List<Admin> getAdPhone(String phone) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Admin> q = builder.createQuery(Admin.class);
        Root root = q.from(Admin.class);
        q.select(root);
        
        q.where(builder.equal(root.get("phone"), phone));
        
        Query query = session.createQuery(q);

        return query.getResultList();
    }
}
