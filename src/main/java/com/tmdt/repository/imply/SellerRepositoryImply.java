/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Review;
import com.tmdt.pojos.Seller;
import com.tmdt.repository.SellerRepository;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author DELL
 */
@Repository
@Transactional
@PropertySource("classpath:messages.properties")
public class SellerRepositoryImply implements SellerRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    @Autowired
    private Environment env;

    @Override
    public boolean addSel(Seller sel) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            session.save(sel);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public Seller getSellerById(int sellerId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        return session.get(Seller.class, sellerId);
    }

    @Override
    public Object[] getgeneral(int sellerId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = builder.createQuery(Object[].class);
        Root root = q.from(Product.class);

        q.where(builder.equal(root.get("idSeller"), sellerId));
        q.multiselect(root.get("idSeller").get("name"), root.get("idSeller").get("avatar"), builder.count(root.get("id")));
        Query query = session.createQuery(q);

        return (Object[]) query.getSingleResult();
    }

    @Override
    public List<Object[]> getSellers(String kw, int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = builder.createQuery(Object[].class);
        Root root = q.from(Seller.class);
        Root rootP = q.from(Product.class);
        List<Predicate> predicates = new ArrayList<>();

        Predicate p1 = builder.equal(root.get("id"),rootP.get("idSeller"));
        predicates.add(p1);

        if (!kw.isEmpty()) {
            Predicate p = builder.like(root.get("name").as(String.class), String.format("%%%s%%", kw));
            predicates.add(p);
        }
        Predicate p = builder.equal(rootP.get("active"), 1);
        predicates.add(p);
        q = q.where(predicates.toArray(new Predicate[]{}));
        q.groupBy(root.get("id"));
        q.multiselect(root.get("id"), root.get("name"), root.get("avatar"), root.get("idLocation").get("name"), builder.count(rootP.get("id")));

        Query query = session.createQuery(q);

//        
//        Query query = session.createQuery("SELECT s.id,s.name,s.avatar,count(p.id)" +
//                                          "FROM Seller s LEFT JOIN Product p ON s.id = p.idSeller " +
//                                          "GROUP BY s.id");
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }
        return query.getResultList();
    }

}
