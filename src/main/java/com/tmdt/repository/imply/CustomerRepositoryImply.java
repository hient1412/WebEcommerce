/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Customer;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Seller;
import com.tmdt.pojos.ShipAdress;
import com.tmdt.repository.CustomerRepository;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
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
public class CustomerRepositoryImply implements CustomerRepository {

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

    @Override
    public Customer getCusById(int id) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        return s.get(Customer.class, id);
    }

    @Override
    public boolean updateCustomer(Customer c) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            Customer customer = this.getCusById(c.getId());
            customer.setFirstName(c.getFirstName());
            customer.setLastName(c.getLastName());
            customer.setDob(c.getDob());
            customer.setEmail(c.getEmail());
            customer.setPhone(c.getPhone());
            customer.setAvatar(c.getAvatar());
            customer.setDescription(c.getDescription());
            customer.setGender(c.getGender());
            customer.setLocation(c.getLocation());
            s.update(customer);

            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public List<Customer> getCusEmail(String email) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Customer> q = builder.createQuery(Customer.class);
        Root root = q.from(Customer.class);
        q.select(root);
        
        q.where(builder.equal(root.get("email"), email));
        
        Query query = session.createQuery(q);

        return query.getResultList();
    }

    @Override
    public List<Customer> getCusPhone(String phone) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Customer> q = builder.createQuery(Customer.class);
        Root root = q.from(Customer.class);
        q.select(root);
        
        q.where(builder.equal(root.get("phone"), phone));
        
        Query query = session.createQuery(q);

        return query.getResultList();
    }

    @Override
    public List<ShipAdress> getShipAdress(int customerId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<ShipAdress> query = builder.createQuery(ShipAdress.class);
        Root root = query.from(ShipAdress.class);
        query.select(root);

        query.where(builder.equal(root.get("idCustomer"), customerId));
        query.orderBy(builder.asc(root.get("priority")));
        
        Query q = session.createQuery(query);
        return q.getResultList();
    }

    @Override
    public ShipAdress addShipAdress(String name, String phone, String address, String ward, String district, int city,int customerId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        ShipAdress s = new ShipAdress();
        s.setName(name);
        s.setPhone(phone);
        s.setAddress(address);
        s.setWard(ward);
        s.setDistrict(district);
//        s.setCity(city);
        s.setIdCustomer(this.getCusById(customerId));

        session.save(s);

        return s;
    }

    @Override
    public boolean addShip(ShipAdress s) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            session.save(s);
            return true;
        } catch(HibernateException ex){
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public boolean deleteS(ShipAdress s) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            session.delete(s);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public ShipAdress getShipById(int id) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        return s.get(ShipAdress.class, id);
    }

    @Override
    public boolean updateS(ShipAdress s) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            session.update(s);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public List<ShipAdress> getShipAdressPriority(int priority,int idCustomer) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<ShipAdress> query = builder.createQuery(ShipAdress.class);
        Root root = query.from(ShipAdress.class);
        query.select(root);

        query.where(builder.and(builder.equal(root.get("priority"), priority)),builder.equal(root.get("idCustomer"), idCustomer));
        
        Query q = session.createQuery(query);
        return q.getResultList();
    }

    @Override
    public int setdefaultShip(ShipAdress s) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        Query query = session.createQuery("UPDATE ShipAdress SET priority = :priority WHERE id = :id");
        query.setParameter("priority", s.getPriority());
        query.setParameter("id", s.getId());
        return query.executeUpdate();
    }

    @Override
    public ShipAdress findShipPriority(Customer c) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<ShipAdress> query = builder.createQuery(ShipAdress.class);
        Root root = query.from(ShipAdress.class);
        
        query.where(builder.and(builder.equal(root.get("priority"), 1),builder.equal(root.get("idCustomer"), c.getId())));
        
        Query q = session.createQuery(query);
        return (ShipAdress) q.getSingleResult();
    }

    @Override
    public Customer getCusByEmail(String email) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = s.getCriteriaBuilder();
        CriteriaQuery<Customer> q = builder.createQuery(Customer.class);
        Root root = q.from(Customer.class);
        q.select(root);
        
        q.where(builder.equal(root.get("email"), email));
       
        Query query = s.createQuery(q);
        return (Customer) query.getSingleResult();
    }


}
