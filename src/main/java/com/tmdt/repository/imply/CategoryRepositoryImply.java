/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Category;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Seller;
import com.tmdt.repository.CategoryRepository;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;

/**
 *
 * @author DELL
 */
@Repository
@Transactional
@PropertySource("classpath:messages.properties")
public class CategoryRepositoryImply implements CategoryRepository{
    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    @Autowired
    private Environment env;
    
    @Override
    public List<Category> getCates() {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Category> q = builder.createQuery(Category.class);
        Root root = q.from(Category.class);
        q.select(root);
        q.where(builder.equal(root.get("isDelete"),0));
        Query query = session.createQuery(q);


        return query.getResultList();
    }

    @Override
    public Category getCateById(int cateId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        return session.get(Category.class, cateId);
    }

    @Override
    public List<Category> getCateBySellerId(int sellerId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Category> q = builder.createQuery(Category.class);
        Root root = q.from(Category.class);
        Root roots = q.from(Seller.class);
        Root rootp = q.from(Product.class);
        q.select(root);
        
        q.where(builder.and(builder.and(builder.equal(rootp.get("idCategory"), root.get("id")),
                builder.equal(rootp.get("idSeller"), roots.get("id")),
                builder.equal(roots.get("id"),sellerId)),builder.equal(root.get("isDelete"), 0)));
        q.groupBy(root.get("id"));
        Query query = session.createQuery(q);
        return query.getResultList();
    }

    @Override
    public List<Category> getCates(int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Category> q = builder.createQuery(Category.class);
        Root root = q.from(Category.class);
        q.select(root);
        
        q.where(builder.equal(root.get("isDelete"), 0));
        
        q.orderBy(builder.desc(root.get("id")));
        Query query = session.createQuery(q);

        if (page != 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }

        return query.getResultList();
    }

    @Override
    public boolean addCate(Category c) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.save(c);
            return true;
        } catch(HibernateException ex){
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public boolean updateCate(Category c) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try{
            s.update(c);
            return true;
        } catch(HibernateException ex){
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public List<Category> getCates(String name) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Category> q = builder.createQuery(Category.class);
        Root root = q.from(Category.class);
        q.select(root);
        
        q.where(builder.equal(root.get("name"), name), builder.equal(root.get("isDelete"), 0));
        
        Query query = session.createQuery(q);

        return query.getResultList();
    }
    
}
