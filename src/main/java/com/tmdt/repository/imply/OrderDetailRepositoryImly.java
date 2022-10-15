/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.Orders;
import com.tmdt.repository.OrderDetailRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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
public class OrderDetailRepositoryImly implements OrderDetailRepository{
    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;

    @Override
    public List<OrderDetail> getOrderDetail(int idOrder) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<OrderDetail> q = builder.createQuery(OrderDetail.class);
        Root root = q.from(OrderDetail.class);
        q.select(root);
        
        q.where(builder.equal(root.get("idOrder"), idOrder));
        
        Query query = session.createQuery(q);
        return query.getResultList();
    }
    
    
    
}
