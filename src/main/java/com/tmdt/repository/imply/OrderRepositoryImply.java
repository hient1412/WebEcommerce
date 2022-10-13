/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.Orders;
import com.tmdt.pojos.Product;
import com.tmdt.repository.OrderRepository;
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
public class OrderRepositoryImply implements OrderRepository{
    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    @Autowired
    private Environment env;
    
    @Override
    public List<Object[]> getOrderBySellerId(Map<String, String> params, int sellerId, int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = builder.createQuery(Object[].class);
        Root root = q.from(Orders.class);
        Root rootP = q.from(Product.class);
        Root rootOd = q.from(OrderDetail.class);

        List<Predicate> predicates = new ArrayList<>();
        
        Predicate pp = builder.and(builder.equal(rootOd.get("idProduct"), rootP.get("id")),
                                   builder.equal(rootOd.get("idOrder"), root.get("id")));
        predicates.add(pp);
        String idOrder = params.get("idOrder");
        if (!idOrder.isEmpty()) {
            Predicate p = builder.equal(root.get("id"), Integer.parseInt(idOrder));
            predicates.add(p);
        }
        String nameCus = params.get("nameCus");
        if (!nameCus.isEmpty()) {
            Predicate p = builder.like(root.get("idCustomer").get("idAccount").get("username").as(String.class),String.format("%%%s%%",nameCus));
            predicates.add(p);
        }
        String namePro = params.get("namePro");
        if (!namePro.isEmpty()) {
            Predicate p = builder.like(rootP.get("name").as(String.class), String.format("%%%s%%",namePro));
            predicates.add(p);
        }
        String active = params.get("active");
        if (!active.isEmpty()) {
            Predicate p = builder.equal(root.get("active"), active);
            predicates.add(p);
        }
        Predicate p1 = builder.equal(root.get("idSeller"), sellerId);
        predicates.add(p1);
        q = q.where(predicates.toArray(new Predicate[]{}));
        q.multiselect(root.get("id"),root.get("amount"),root.get("active"),root.join("orderDetailCollection").getParent(),
                    rootP.join("imageCollection"),root.get("idCustomer").get("avatar"),root.get("idCustomer").get("idAccount").get("username"),
                    rootOd.get("quantity"),root.get("paymentType"));
        q.groupBy(root.get("id"));
        Query query = session.createQuery(q);
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }
        return query.getResultList();

    }
}
