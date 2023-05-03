/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;


import com.tmdt.pojos.Account;
import com.tmdt.pojos.Likes;
import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.Orders;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Report;
import com.tmdt.pojos.Review;
import com.tmdt.pojos.Seller;
import com.tmdt.repository.AccountRepository;
import com.tmdt.repository.CustomerRepository;
import com.tmdt.repository.ProductRepository;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.HibernateException;
import org.springframework.transaction.annotation.Transactional;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
    @Autowired
    private AccountRepository accountRepository;
    
    @Override
    public List<Product> getProducts() {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> q = builder.createQuery(Product.class);
        Root root = q.from(Product.class);
        q = q.select(root);
        q.where(builder.equal(root.get("isDelete"), 0),builder.equal(root.get("adminBan"), 0));
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
                    builder.equal(roots.join("idLocation").get("id").as(Integer.class), location));
            predicates.add(p);
        }
        Predicate p1 = builder.equal(root.get("active"), 1);
        predicates.add(p1);
        Predicate p2 = builder.equal(root.get("isDelete"), 0);
        predicates.add(p2);
        Predicate p3 = builder.equal(root.get("adminBan"), 0);
        predicates.add(p3);
        Predicate p4 = builder.equal(root.get("idSeller").get("adminBan"), 0);
        predicates.add(p4);
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

        q.where(builder.equal(root.get("idCategory"), cateId),builder.equal(root.get("isDelete"), 0),builder.equal(root.get("adminBan"), 0),builder.equal(root.get("idSeller").get("adminBan"), 0));

        q.orderBy(builder.desc(root.get("id")));
        Query query = session.createQuery(q);
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }
        return query.getResultList();
    }

    @Override
    public boolean addProduct(Product p) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.save(p);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Product> getProductBySellerId(Map<String,String> params,int sellerId, int page) {
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
        String cat = params.get("cat");
        if (!cat.isEmpty()) {
            Predicate p = builder.equal(root.join("idCategory").get("id").as(Integer.class), cat);
            predicates.add(p);
        }
        String quantityMin = params.get("quantityMin");
        if (!quantityMin.isEmpty()) {
            Predicate p = builder.greaterThanOrEqualTo(root.get("quantity"), quantityMin);
            predicates.add(p);
        }
        String quantityMax = params.get("quantityMax");
        if (!quantityMax.isEmpty()) {
            Predicate p = builder.lessThanOrEqualTo(root.get("quantity"), quantityMax);
            predicates.add(p);
        }
        String active = params.get("active");
        if (!active.isEmpty()) {
            Predicate p = builder.equal(root.get("active"), active);
            predicates.add(p);
        }
        String adminBan = params.get("adminBan");
        if (!adminBan.isEmpty()) {
            Predicate p = builder.equal(root.get("adminBan"), adminBan);
            predicates.add(p);
        }
        
        Predicate p1 = builder.equal(root.get("idSeller"), sellerId);
        predicates.add(p1);
        Predicate p2 = builder.equal(root.get("isDelete"), 0);
        predicates.add(p2);
        q = q.where(predicates.toArray(new Predicate[]{}));
        
        q.orderBy(builder.desc(root.get("id")));
        
        Query query = session.createQuery(q);
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("listProduct.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }
        return query.getResultList();

    }

    @Override
    public boolean updateProduct(Product p) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            session.update(p);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public List<Object[]> getProductBuyALot(int num) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = builder.createQuery(Object[].class);
        Root root = q.from(Product.class);
        Root rootOD = q.from(OrderDetail.class);
        Root rootO = q.from(Orders.class);
        q = q.where(builder.equal(rootOD.get("idProduct"), root.get("id")),
                builder.equal(root.get("isDelete"), 0),builder.equal(rootO.get("id"), rootOD.get("idOrder")),
                builder.equal(rootO.get("active"), 5),builder.equal(root.get("adminBan"), 0),builder.equal(root.get("idSeller").get("adminBan"), 0));
        q.multiselect(root.get("id"),root.get("name"),
                root.get("price"),root,builder.count(root.get("id")));

        q = q.groupBy(root.get("id"));
        q = q.orderBy(builder.desc(builder.count(root.get("id"))));
        
        Query query = session.createQuery(q);
       
        query.setMaxResults(num);

        return query.getResultList();
    }
    @Override
    public List<Object[]> getProductBuyALotInSeller(int num,int sellerId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = builder.createQuery(Object[].class);
        Root root = q.from(Product.class);
        Root rootOD = q.from(OrderDetail.class);
        Root rootO = q.from(Orders.class);
        q = q.where(builder.and(builder.equal(rootOD.get("idProduct"), root.get("id"))),builder.equal(rootO.get("id"), rootOD.get("idOrder")),
                builder.equal(root.join("idSeller").get("id"), sellerId),builder.equal(root.get("isDelete"), 0),builder.equal(root.get("adminBan"), 0),builder.equal(rootO.get("active"), 5));
        q.multiselect(root.get("id"),root.get("name"),
                root.get("price"),root,builder.count(root.get("id")));

        q = q.groupBy(root.get("id"));
        q = q.orderBy(builder.desc(builder.count(root.get("id"))));
        
        Query query = session.createQuery(q);
       
        query.setMaxResults(num);

        return query.getResultList();
    }

    @Override
    public List<Review> getReview(int productId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Review> query = builder.createQuery(Review.class);
        Root root = query.from(Review.class);
        query.select(root);

        query.where(builder.equal(root.get("idProduct"), productId));

        Query q = session.createQuery(query);
        return q.getResultList();
    }

    @Override
    public Review addReview(String review, int productId, int rating) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        Review r = new Review();
        r.setContent(review);
        r.setRating(rating);
        r.setIdProduct(this.getProductById(productId));
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        r.setIdAccount(this.accountRepository.getAcByUsername(auth.getName()));
        r.setReviewDate(new Date());

        session.save(r);

        return r;
    }

    @Override
    public List<Product> getProductBySeller(Map<String,String> params,int sellerId, int page) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> q = builder.createQuery(Product.class);
        Root root = q.from(Product.class);
        q.select(root);

        List<Predicate> predicates = new ArrayList<>();
        String sort = params.get("sort");
        if (!sort.isEmpty() || sort != null) {
            if (sort.equals("asc")) {
                q.orderBy(builder.asc(root.get("id")));
            }
            if (sort.equals("desc")) {
                q.orderBy(builder.desc(root.get("id")));
            }
            if (sort.equals("pin")) {
                q.orderBy(builder.asc(root.get("price")));
            }
            if (sort.equals("pde")) {
                q.orderBy(builder.desc(root.get("price")));
            }
        }
        String cateId = params.get("cateId");
        if (!cateId.isEmpty()) {
            Predicate p = builder.equal(root.get("idCategory"), Integer.parseInt(cateId));
            predicates.add(p);
        }
        String kw = params.get("kw");
        if (!kw.isEmpty()) {
            Predicate p = builder.like(root.get("name").as(String.class), String.format("%%%s%%", kw));
            predicates.add(p);
        }
        
        
        Predicate p1 = builder.equal(root.get("active"), 1);
        Predicate p2 = builder.equal(root.get("idSeller"), sellerId);
        Predicate p3 = builder.equal(root.get("isDelete"), 0);
        Predicate p4 = builder.equal(root.get("idSeller").get("idAccount").get("active"), 1);
        Predicate p5 = builder.equal(root.get("adminBan"), 0);
        predicates.add(p1);
        predicates.add(p2);
        predicates.add(p3);
        predicates.add(p4);
        predicates.add(p5);
        q = q.where(predicates.toArray(new Predicate[]{}));
        
        Query query = session.createQuery(q);

        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            query.setMaxResults(size);
            query.setFirstResult((page - 1) * size);
        }
        
        return query.getResultList();
    }

    @Override
    public int updateProductHide(Product p) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        Query query = s.createQuery("UPDATE Product SET active = :active WHERE id = :id");
        query.setParameter("active", p.getActive());
        query.setParameter("id", p.getId());
        return query.executeUpdate();
    }
    
    @Override
    public List getRating(int productId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Review> query = builder.createQuery(Review.class);
        Root root = query.from(Review.class);
        query.select(root.get("rating"));
        query.where(builder.equal(root.get("idProduct"), productId));

        Query q = session.createQuery(query);
        return q.getResultList();
    }

    @Override
    public List getRatingSeller(int sellerId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> query = builder.createQuery(Object[].class);
        Root rootR = query.from(Review.class);
        Root rootP = query.from(Product.class);
        query.select(rootR.get("rating"));
        query.where(builder.and(builder.equal(rootR.get("idProduct"), rootP.get("id")))
                    ,builder.equal(rootP.get("idSeller"), sellerId));

        Query q = session.createQuery(query);
        return q.getResultList();
    }
    @Override
    public List<Likes> getLikesOfProduct(int productId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> query = builder.createQuery(Object[].class);
        Root root = query.from(Likes.class);
        query.multiselect(builder.count(root.get("id")));
        query.where(builder.equal(root.get("idProduct"), productId));

        Query q = session.createQuery(query);
        return q.getResultList();
    }

    
    @Override
    public long checkPermissionAddReview(int productId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Account account = this.accountRepository.getAcByUsername(authentication.getName());
        
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> query = builder.createQuery(Object[].class);
        Root rootOrder = query.from(Orders.class);
        Root rootOrderDetail = query.from(OrderDetail.class);
        
        query.multiselect(builder.count(rootOrder.get("idCustomer")));
        query.where(builder.and(builder.equal(rootOrder.get("id"), rootOrderDetail.get("idOrder"))
                ,builder.equal(rootOrder.get("active"), "5")
                ,builder.equal(rootOrderDetail.get("idProduct"), productId)
                ,builder.equal(rootOrder.get("idCustomer"), account.getCustomer())));
        Query q = session.createQuery(query);
        return (long) q.getSingleResult();
    }
    
    @Override
    public int updateProductBan(Product p) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        Query query = s.createQuery("UPDATE Product SET adminBan = :adminBan WHERE id = :id");
        query.setParameter("adminBan", p.getAdminBan());
        query.setParameter("id", p.getId());
        return query.executeUpdate();
    }
    
    @Override
    public long checkExistReview(int productId, int accountId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> query = builder.createQuery(Object[].class);
        Root root = query.from(Review.class);

        query.multiselect(builder.count(root.get("id")));
        query.where(builder.equal(root.get("idProduct"), productId), builder.equal(root.get("idAccount"), accountId));
        Query q = session.createQuery(query);
        return (long) q.getSingleResult();
    }
    @Override
    public long checkExistReport(int productId, int customerId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> query = builder.createQuery(Object[].class);
        Root root = query.from(Report.class);

        query.multiselect(builder.count(root.get("id")));
        query.where(builder.equal(root.get("idProduct"), productId), builder.equal(root.get("idCustomer"), customerId));
        Query q = session.createQuery(query);
        return (long) q.getSingleResult();
    }

    @Override
    public long checkExistLike(int productId, int cusId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> query = builder.createQuery(Object[].class);
        Root root = query.from(Likes.class);

        query.multiselect(builder.count(root.get("id")));
        query.where(builder.equal(root.get("idProduct"), productId), builder.equal(root.get("idCustomer"), cusId));
        Query q = session.createQuery(query);
        return (long) q.getSingleResult();
    }
    
    @Override
    public boolean addLike(Likes likes) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.save(likes);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }
    @Override
    public boolean delete(Likes likes) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.delete(likes);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public Likes getLikeByCusId(int productId, int customerId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Likes> query = builder.createQuery(Likes.class);
        Root root = query.from(Likes.class);
        query.select(root);
        
        query.where(builder.equal(root.get("idProduct"), productId), builder.equal(root.get("idCustomer"), customerId));
        Query q = session.createQuery(query);
        return (Likes) q.getSingleResult();
    }
    @Override
    public List<Object[]> getProductLikeALot(int num) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = builder.createQuery(Object[].class);
        Root root = q.from(Likes.class);
        q = q.where(builder.equal(root.get("idProduct").get("isDelete"), 0),builder.equal(root.get("idProduct").get("adminBan"), 0),builder.equal(root.get("idProduct").get("idSeller").get("adminBan"), 0));
        q.multiselect(root.get("idProduct").get("id"),root.get("idProduct").get("name"),
                root.get("idProduct").get("price"),root.get("idProduct"),builder.count(root.get("id")));

        q = q.groupBy(root.get("idProduct"));
        q = q.orderBy(builder.desc(builder.count(root.get("id"))));
        
        Query query = session.createQuery(q);
       
        query.setMaxResults(num);

        return query.getResultList();
    }

    @Override
    public List<Product> getProductId(int productId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> q = builder.createQuery(Product.class);
        Root root = q.from(Product.class);
        q.select(root);
        
        q.where(builder.equal(root.get("id"), productId));
        
        Query query = session.createQuery(q);

        return query.getResultList();
    }
}
