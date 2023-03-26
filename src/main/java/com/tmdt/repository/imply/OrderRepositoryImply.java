/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Cart;
import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.Orders;
import com.tmdt.pojos.Seller;
import com.tmdt.pojos.SellerOrder;
import com.tmdt.repository.AccountRepository;
import com.tmdt.repository.OrderRepository;
import com.tmdt.repository.ProductRepository;
import com.tmdt.service.CustomerService;
import com.tmdt.service.SellerService;
import com.tmdt.utils.Utils;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author DELL
 */
@Repository
@Transactional
@PropertySource("classpath:messages.properties")
public class OrderRepositoryImply implements OrderRepository {

    @Autowired
    private CustomerService customerService;
    @Autowired
    private SellerService sellerService;
    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private Environment env;

    @Override
    public List<Orders> getOrderBySellerId(Map<String, String> params, int sellerId, int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Orders> q = builder.createQuery(Orders.class);
        Root root = q.from(Orders.class);

        List<Predicate> predicates = new ArrayList<>();

        String idOrder = params.get("idOrder");
        if (!idOrder.isEmpty()) {
            Predicate p = builder.equal(root.get("id"), Integer.parseInt(idOrder));
            predicates.add(p);
        }
        String nameCus = params.get("nameCus");
        if (!nameCus.isEmpty()) {
            Predicate p = builder.like(root.get("idCustomer").get("idAccount").get("username").as(String.class), String.format("%%%s%%", nameCus));
            predicates.add(p);
        }
        String active = params.get("active");
        if (!active.isEmpty()) {
            Predicate p = builder.equal(root.get("active"), active);
            predicates.add(p);
        }
        String namePro = params.get("namePro");
        if (!namePro.isEmpty()) {
            Predicate p = builder.like(root.join("orderDetailCollection").join("idProduct").get("name").as(String.class), String.format("%%%s%%", namePro));
            predicates.add(p);
        }
        Predicate p1 = builder.equal(root.join("sellerOrderCollection").get("idSeller"), sellerId);
        predicates.add(p1);
        q = q.where(predicates.toArray(new Predicate[]{}));
        q.groupBy(root.get("id"));
        Query query = session.createQuery(q);
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }
        return query.getResultList();

    }

    @Override
    public List<Orders> getOrderByCusId(Map<String, String> params, int cusId, int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Orders> q = builder.createQuery(Orders.class);
        Root root = q.from(Orders.class);

        List<Predicate> predicates = new ArrayList<>();

        String idOrder = params.get("idOrder");
        if (!idOrder.isEmpty()) {
            Predicate p = builder.equal(root.get("id"), Integer.parseInt(idOrder));
            predicates.add(p);
        }
        String namePro = params.get("namePro");
        if (!namePro.isEmpty()) {
            Predicate p = builder.like(root.join("orderDetailCollection").join("idProduct").get("name").as(String.class), String.format("%%%s%%", namePro));
            predicates.add(p);
        }
        String active = params.get("active");
        if (!active.isEmpty()) {
            Predicate p = builder.equal(root.get("active"), active);
            predicates.add(p);
        }
        String nameSel = params.get("nameSel");
        if (!nameSel.isEmpty()) {
            Predicate p = builder.like(root.join("sellerOrderCollection").join("idSeller").get("name").as(String.class), String.format("%%%s%%", nameSel));
            predicates.add(p);
        }
        Predicate p1 = builder.equal(root.get("idCustomer"), cusId);
        predicates.add(p1);
        q = q.where(predicates.toArray(new Predicate[]{}));
        q.groupBy(root.get("id"));
        Query query = session.createQuery(q);
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }
        return query.getResultList();
    }

    @Override
    public Orders getOrderById(int id) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        return s.get(Orders.class, id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean addReceipt(Map<Integer, Cart> cart) {
        try {
            Set<Seller> selList = new HashSet<>();
            for (Cart c : cart.values()) {
                selList.add(c.getSeller());
            }
            Session session = this.sessionFactoryBean.getObject().getCurrentSession();
            if (selList.size() != 1) {
                for (Seller s : selList) {
                    Orders order = new Orders();

                    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                    Account account = this.accountRepository.getAcByUsername(authentication.getName());
                    order.setIdCustomer(account.getCustomer());

                    order.setOrderDate(new Date());
                    Date requiredDate = new Date();
                    requiredDate.setDate(requiredDate.getDate() + 7);
                    order.setRequiredDate(requiredDate);
                    order.setActive(1);
                    order.setIsPayment(0);
                    order.setPaymentType(0);
                    order.setShipFee(0);
                    order.setIdVoucher(null);

                    Map<String, String> amount = Utils.cartAmountSeller(cart, s);
                    order.setAmount(Long.parseLong(amount.get("amountSel")));
                    session.save(order);

                    SellerOrder sellerOrder = new SellerOrder();
                    sellerOrder.setIdOrder(order);
                    sellerOrder.setIdSeller(s);
                    session.save(sellerOrder);

                    for (Cart c : cart.values()) {
                        if (s.equals(c.getSeller())) {
                            OrderDetail detail = new OrderDetail();
                            detail.setIdOrder(order);
                            detail.setIdProduct(this.productRepository.getProductById(c.getProductId()));
                            detail.setUnitPrice(c.getPrice());
                            detail.setQuantity(c.getCount());
                            detail.setDiscount(0);
                            session.save(detail);
                        }
                    }
                }
            } else {
                Orders order = new Orders();
                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                Account account = this.accountRepository.getAcByUsername(authentication.getName());
                order.setIdCustomer(account.getCustomer());
                order.setIdShipAdress(this.customerService.findShipPriority(account.getCustomer()));
                order.setOrderDate(new Date());
                Date requiredDate = new Date();
                requiredDate.setDate(requiredDate.getDate() + 7);
                order.setRequiredDate(requiredDate);
                order.setActive(1);
                order.setIsPayment(0);
                order.setPaymentType(0);
                order.setShipFee(0);
                order.setIdVoucher(null);

                Map<String, String> amount = Utils.cartAmount(cart);
                order.setAmount(Long.parseLong(amount.get("amount")));

                session.save(order);

                SellerOrder sellerOrder = new SellerOrder();
                for (Cart c : cart.values()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setIdOrder(order);
                    detail.setIdProduct(this.productRepository.getProductById(c.getProductId()));
                    detail.setUnitPrice(c.getPrice());
                    detail.setQuantity(c.getCount());
                    detail.setDiscount(0);
                    session.save(detail);
                    sellerOrder.setIdOrder(order);
                    sellerOrder.setIdSeller(c.getSeller());
                    session.save(sellerOrder);
                }
            }
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }
        return false;
    }
}
