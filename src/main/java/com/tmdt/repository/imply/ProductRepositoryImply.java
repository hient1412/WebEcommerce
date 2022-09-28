/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;


import com.tmdt.pojos.Location;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Seller;
import com.tmdt.repository.ProductRepository;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.springframework.transaction.annotation.Transactional;
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
public class ProductRepositoryImply implements ProductRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    @Autowired
    private Environment env;

    @Override
    public List<Product> getProducts() {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> q = builder.createQuery(Product.class);
        Root root = q.from(Product.class);
        q = q.select(root);

        q.orderBy(builder.desc(root.get("id")));

        Query query = session.createQuery(q);

        return query.getResultList();
    }

    @Override
    public List<Product> getProducts(Map<String, String> params, int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> q = builder.createQuery(Product.class);
        Root root = q.from(Product.class);
        q.select(root);

        List<Predicate> predicates = new ArrayList<>();

        String kw = params.get("kw");
        if (!kw.isEmpty()) {
            Predicate p = builder.like(root.get("name").as(String.class), String.format("%%%s%%", kw));
            predicates.add(p);
        }
        String fp = params.get("fp");
        if (!fp.isEmpty()) {
            Predicate p = builder.greaterThanOrEqualTo(root.get("price").as(BigDecimal.class), new BigDecimal(fp));
            predicates.add(p);
        }
        String tp = params.get("tp");
        if (!tp.isEmpty()) {
            Predicate p = builder.lessThanOrEqualTo(root.get("price").as(BigDecimal.class), new BigDecimal(tp));
            predicates.add(p);
        }
        String sort = params.get("sort");
        if (!sort.isEmpty()) {
            if (sort.equals("asc")) {
                q.orderBy(builder.asc(root.get("id")));
            }
            if (sort.equals("desc")) {
                q.orderBy(builder.desc(root.get("id")));
            }
            if (sort.equals("az")) {
                q.orderBy(builder.asc(root.get("name")));
            }
            if (sort.equals("za")) {
                q.orderBy(builder.desc(root.get("name")));
            }
            if (sort.equals("pin")) {
                q.orderBy(builder.asc(root.get("price")));
            }
            if (sort.equals("pde")) {
                q.orderBy(builder.desc(root.get("price")));
            }
        }
        String seller = params.get("seller");
        if (!seller.isEmpty()) {
            Root roots = q.from(Seller.class);
            q.where(builder.equal(root.get("idSeller"), roots.get("id")));
            Predicate p = builder.like(roots.get("name").as(String.class), String.format("%%%s%%", seller));
            predicates.add(p);
        }
        String cat = params.get("cat");
        if (!cat.isEmpty()) {
            Predicate p = builder.equal(root.join("idCategory").get("id").as(Integer.class), cat);
            predicates.add(p);
        }
        String location = params.get("location");
        if (!location.isEmpty()) {
            Root roots = q.from(Seller.class);
            Predicate p = builder.and(
                    builder.equal(root.get("idSeller"), roots.get("id")),
                    builder.equal(roots.join("idLocation").get("id").as(Integer.class), location)
            );
            
//            Predicate p = builder.equal(rootl.get("id").as(Integer.class), location);
            predicates.add(p);
        }
        q = q.where(predicates.toArray(new Predicate[]{}));

        Query query = session.createQuery(q.distinct(true));
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }

        return query.getResultList();
    }

    @Override
    public Product getProductById(int productId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        return session.get(Product.class, productId);
    }

    @Override
    public List<Product> getProductByCateId(int cateId, int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> q = builder.createQuery(Product.class);
        Root root = q.from(Product.class);
        q.select(root);

        q.where(builder.equal(root.get("idCategory"), cateId));

        q.orderBy(builder.desc(root.get("id")));
        Query query = session.createQuery(q);
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }
        return query.getResultList();
    }
}
