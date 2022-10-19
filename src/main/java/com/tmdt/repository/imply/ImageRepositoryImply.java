/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Image;
import com.tmdt.pojos.Product;
import com.tmdt.repository.ImageRepository;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
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
public class ImageRepositoryImply implements ImageRepository{

    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    
    @Override
    public List<Image> getImageByProductId(int productId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Image> q = builder.createQuery(Image.class);
        Root root = q.from(Image.class);
        q.select(root);

        q.where(builder.equal(root.get("idProduct"), productId));

        Query query = session.createQuery(q);
        return query.getResultList();
    }

    @Override
    public boolean addImage(Image i) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.save(i);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateImage(Image i) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.update(i);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(Image i) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.delete(i);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

//    @Override
//    public Image getImageByProductId(int productId) {
//        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
//        CriteriaBuilder builder = session.getCriteriaBuilder();
//        CriteriaQuery<Image> q = builder.createQuery(Image.class);
//        Root root = q.from(Image.class);
//        q.select(root);
//
//        q.where(builder.equal(root.get("idProduct"), productId));
//
//        Query query = session.createQuery(q);
//        return (Image) query.getSingleResult();
//    }
}
