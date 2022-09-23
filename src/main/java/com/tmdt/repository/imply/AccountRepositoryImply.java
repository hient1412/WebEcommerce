/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Account;
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
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Account> q = builder.createQuery(Account.class);
        Root root = q.from(Account.class);
        q = q.select(root);
        
        if(!username.isEmpty()){
            Predicate p = builder.equal(root.get("username").as(String.class), username.trim());
            q = q.where(p);
        }
       
        Query query = session.createQuery(q);
        return query.getResultList();
    }
}
