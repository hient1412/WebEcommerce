/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Review;
import com.tmdt.repository.AccountRepository;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;

/**
 *
 * @author DELL
 */
@Repository
@Transactional
public class AccountRepositoryImply  implements AccountRepository{

    @Autowired
    private Environment env;
    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    
    @Override
    public boolean addAccount(Account ac) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.save(ac);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public List<Account> getAccount(String username) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = s.getCriteriaBuilder();
        CriteriaQuery<Account> q = builder.createQuery(Account.class);
        Root root = q.from(Account.class);
        q = q.select(root);
        if(!username.isEmpty()){
            Predicate p = builder.equal(root.get("username").as(String.class), username.trim());
            q = q.where(p);
        }
       
        Query query = s.createQuery(q);
        return query.getResultList();
    }

    @Override
    public Account getAcById(int id) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        return s.get(Account.class, id);
    }

    @Override
    public List<Account> getRole(String role, int page, int active) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = s.getCriteriaBuilder();
        CriteriaQuery<Account> query = builder.createQuery(Account.class);
        Root root = query.from(Account.class);
        query = query.select(root);

        query = query.where(builder.equal(root.get("role").as(String.class), role),
                builder.equal(root.get("active").as(Integer.class), active));

        query = query.orderBy(builder.desc(root.get("id")));

        Query q = s.createQuery(query);

        if (page != 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            q.setMaxResults(size);
            q.setFirstResult((page - 1) * size);
        }
        return q.getResultList();
    }

    @Override
    public boolean updateAc(Account ac) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.update(ac);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }
    @Override
    public Account getAcByUsername(String username) {
        
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = s.getCriteriaBuilder();
        CriteriaQuery<Account> query = builder.createQuery(Account.class);
        Root root = query.from(Account.class);
        query = query.select(root);

        query = query.where(builder.equal(root.get("username").as(String.class), username));

        Query q = s.createQuery(query);
        return (Account) q.getSingleResult();
    }

    @Override
    public List<Account> getAccount(int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Account> query = builder.createQuery(Account.class);
        Root root = query.from(Account.class);
        query = query.select(root);
        query.orderBy(builder.desc(root.get("id")));

        Query q = session.createQuery(query);

        if (page != 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            q.setMaxResults(size);
            q.setFirstResult((page - 1) * size);
        }
        return q.getResultList();
    }

}
