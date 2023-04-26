/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Admin;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Report;
import com.tmdt.pojos.Seller;
import com.tmdt.repository.AdminRepository;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
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
public class AdminRepositoryImply implements AdminRepository{

    @Autowired
    private Environment env;
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

    @Override
    public List<Report> getReport(int product, int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Report> q = builder.createQuery(Report.class);
        Root root = q.from(Report.class);
        q.select(root);
        q.where(builder.equal(root.get("idProduct").get("id"), product));
        Query query = session.createQuery(q);

        if (page != 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }

        return query.getResultList();
    }

    @Override
    public List<Report> getReportWithProduct(int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Report> q = builder.createQuery(Report.class);
        Root root = q.from(Report.class);
        q.select(root);
        q.where(builder.equal(root.get("active"), 0));
        q.groupBy(root.get("idProduct").get("id"));
        Query query = session.createQuery(q);

        if (page != 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }

        return query.getResultList();
    }

    @Override
    public Report getReportById(int reportId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        return session.get(Report.class, reportId);
    }

    @Override
    public int updateSkip(Report r) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        Query query = s.createQuery("UPDATE Report SET active = :active WHERE idProduct = :id");
        query.setParameter("active", r.getActive());
        query.setParameter("id", r.getIdProduct());
        return query.executeUpdate();
    }

    @Override
    public List<Report> getReportCheckAll(int id, int active) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = s.getCriteriaBuilder();
        CriteriaQuery<Report> query = builder.createQuery(Report.class);
        Root root = query.from(Report.class);
        query = query.select(root);

        query = query.where(builder.equal(root.get("idProduct").get("id"), id),
                builder.equal(root.get("active").as(Integer.class), active));

        query = query.orderBy(builder.desc(root.get("id")));

        Query q = s.createQuery(query);

        return q.getResultList();
    }
    @Override
    public List<Object[]> getReportProductSeller(int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = builder.createQuery(Object[].class);
        Root root = q.from(Product.class);
        Root rootS = q.from(Seller.class);
        
        q.where(builder.equal(root.get("idSeller"), rootS.get("id")),builder.equal(root.get("adminBan"), 1),builder.equal(rootS.get("adminBan"), 0));
        
        q.multiselect(rootS.get("id"),rootS.get("name"), builder.count(root.get("adminBan")));
        
        q.groupBy(rootS.get("id"),rootS.get("name"));
        q.orderBy(builder.desc(root.get("idSeller")));
        Query query = session.createQuery(q);

        if (page != 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }

        return query.getResultList();
    }
    
    @Override
    public List<Report> getReportProductSeller(int page,int idSeller) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Report> q = builder.createQuery(Report.class);
        Root root = q.from(Report.class);
        q.select(root);
        q.where(builder.equal(root.get("active"), 1),builder.equal(root.get("idProduct").get("idSeller").get("id"), idSeller));
        q.groupBy(root.get("idProduct").get("id"));
        Query query = session.createQuery(q);

        if (page != 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }

        return query.getResultList();
    }
    
    @Override
    public List<Product> getReportSeller(int sellerId, int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> q = builder.createQuery(Product.class);
        Root root = q.from(Product.class);
        q.select(root);
        q.where(builder.equal(root.get("idSeller"), sellerId), builder.equal(root.get("adminBan"), 1));
        Query query = session.createQuery(q);

        if (page != 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }

        return query.getResultList();
    }
}
