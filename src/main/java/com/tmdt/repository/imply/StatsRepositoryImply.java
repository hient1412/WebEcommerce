/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Category;
import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.Orders;
import com.tmdt.pojos.Product;
import com.tmdt.repository.StatsRepository;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
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
public class StatsRepositoryImply implements StatsRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;

    @Override
    public List<Object[]> countRole() {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = s.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = builder.createQuery(Object[].class);
        Root root = q.from(Account.class);

        q.multiselect(root.get("role"), builder.count(root.get("id")));
        q.orderBy(builder.desc(builder.count(root.get("id"))));
        q.groupBy(root.get("role"));

        Query query = s.createQuery(q);

        return query.getResultList();
    }

    @Override
    public List<Object[]> countCategories() {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> query = builder.createQuery(Object[].class);

        Root root = query.from(Product.class);
        Root rootCate = query.from(Category.class);

        query.where(builder.equal(root.get("idCategory"), rootCate.get("id")));

        query.multiselect(rootCate.get("id"), rootCate.get("name"), builder.count(root.get("id")));
        query.orderBy(builder.desc(builder.count(root.get("id"))));
        query.groupBy(rootCate.get("id"));

        Query q = session.createQuery(query);
        return q.getResultList();
    }

    @Override
    public List<Object[]> statsProduct(String kw,Date fromDate, Date toDate) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> query = builder.createQuery(Object[].class);

        Root root = query.from(Product.class);
        Root rootO = query.from(Orders.class);
        Root rootOd = query.from(OrderDetail.class);
        
        List<Predicate> predicates = new ArrayList<>();
        predicates.add(builder.equal(rootOd.get("idProduct"), root.get("id")));
        predicates.add(builder.equal(rootOd.get("idOrder"), rootO.get("id")));
        
        query.multiselect(root.get("id"), root.get("name"),
                builder.sum(builder.diff(builder.prod(rootOd.get("unitPrice"), rootOd.get("quantity")),builder.prod(rootOd.get("unitPrice"),builder.prod(rootOd.get("quantity"), rootOd.get("discount"))))).as(BigDecimal.class));
        if(kw != null){
            predicates.add(builder.like(root.get("name").as(String.class), String.format("%%%s%%", kw)));
        }
        if(fromDate != null){
            predicates.add(builder.greaterThanOrEqualTo(rootO.get("orderDate"),fromDate));
        }
        if(toDate != null){
            predicates.add(builder.lessThanOrEqualTo(rootO.get("orderDate"),toDate));
        }
        query.where(predicates.toArray(new Predicate[]{}));
        query.groupBy(root.get("id"));
        Query q = session.createQuery(query);
        return q.getResultList();
    }

}
