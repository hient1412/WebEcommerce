/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Category;
import com.tmdt.repository.CategoryRepository;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
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
public class CategoryRepositoryImply implements CategoryRepository{
    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    
    @Override
    public List<Category> getCates() {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Category> q = builder.createQuery(Category.class);
        Root root = q.from(Category.class);
        q.select(root);
        
        Query query = session.createQuery(q);


        return query.getResultList();
    }
    
}
