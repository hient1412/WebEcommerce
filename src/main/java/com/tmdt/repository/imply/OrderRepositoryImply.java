/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.repository.imply;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Cancel;
import com.tmdt.pojos.Cart;
import com.tmdt.pojos.Image;
import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.Orders;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Seller;
import com.tmdt.pojos.SellerOrder;
import com.tmdt.repository.AccountRepository;
import com.tmdt.repository.OrderRepository;
import com.tmdt.repository.ProductRepository;
import com.tmdt.service.CustomerService;
import com.tmdt.service.MailService;
import com.tmdt.service.OrderDetailService;
import com.tmdt.service.SellerService;
import com.tmdt.utils.Utils;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import net.bytebuddy.utility.RandomString;
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
    private OrderDetailService orderDetailService;
    @Autowired
    private MailService mailService;
    @Autowired
    private LocalSessionFactoryBean sessionFactoryBean;
    @Autowired
    private SellerService sellerService;
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
                    order.setIdShipAdress(this.customerService.findShipPriority(account.getCustomer()));
                    order.setOrderDate(new Date());
                    Date requiredDate = new Date();
                    requiredDate.setDate(requiredDate.getDate() + 7);
                    order.setRequiredDate(requiredDate);
                    order.setActive(1);
                    order.setIsPayment(0);
                    order.setPaymentType(1);
                    order.setShipFee(0);
                    order.setIdVoucher(null);

                    Map<String, String> amount = Utils.cartAmountSeller(cart, s);
                    order.setAmount(Long.parseLong(amount.get("amount")));
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
                    SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
                SimpleDateFormat dk = new SimpleDateFormat("dd/MM/yyyy");
                DecimalFormat df = new DecimalFormat("###,###,###,###");

                String sendTo = order.getIdCustomer().getEmail();
                String subject = "WEBECOMMERCE THÔNG BÁO - ĐẶT HÀNG THÀNH CÔNG " + RandomString.make(4);
                String content = "<div style=\"border:1px solid black;margin-bottom:10px\">\n"
                        + "<div style=\"text-align:center; padding: 0.5rem\">\n"
                        + "    <span style=\"font-size:22px\"><b>CHI TIẾT ĐƠN HÀNG </b></span><br>\n"
                        + "    <span>Mã đơn hàng: " + order.getId() + "</span><br>\n"
                        + "    <span>Ngày đặt hàng: " + dt.format(order.getOrderDate()) + "</span><br>\n"
                        + "    <span style=\"color:green\">Trạng thái đơn hàng: ";

                switch (order.getActive()) {
                    case 1:
                        content += "Đã đặt hàng";
                        break;
                    case 2:
                        content += "Chờ lấy hàng";
                        break;
                    case 3:
                        content += "Chờ vận chuyển";
                        break;
                    case 4:
                        content += "Đang giao";
                        break;
                    case 5:
                        content += "Đã hoàn thành (vào lúc : " + dt.format(order.getOrderReceived()) + ")";
                        break;
                }
                content += "</span>\n"
                        + "    <br><span>Ngày dự kiến giao hàng: " + dk.format(order.getRequiredDate()) + "<br></span>\n"
                        + "    <br>\n"
                        + "</div>\n"
                        + "</div>\n"
                        + "<div style=\"margin-top: 1rem;\">\n"
                        + "    <div style=\"border: 1px solid black\">\n"
                        + "        <div style=\"padding: 1.5rem\">\n"
                        + "            <b style=\"font-size:22px\">Địa chỉ nhận hàng</b>\n"
                        + "            <div style=\"padding-top: 1rem\">\n"
                        + "                <b> " + order.getIdShipAdress().getName() + " </b> <span> | </span><label> " + order.getIdShipAdress().getPhone() + "</label> \n"
                        + "                <p style=\"text-transform: capitalize\">" + order.getIdShipAdress().getAddress() + "</p> \n"
                        + "                <p><span style=\"text-transform: capitalize\"> " + order.getIdShipAdress().getWard() + "</span><span style=\"text-transform: capitalize\">, " + order.getIdShipAdress().getDistrict() + "</span><span>, " + order.getIdShipAdress().getCity().getName() + " </span>\n"
                        + "            </div>\n"
                        + "        </div>\n"
                        + "    </div>\n"
                        + "</div>\n"
                        + "<div>\n"
                        + "    <div style=\"border-left: 1px solid #dee2e6;border-right: 1px solid #dee2e6;border-color: black;\">\n"
                        + "        <div style=\"padding: 1rem;\">\n"
                        + "            <div style=\"display:flex;\">\n"
                        + "                <div style=\"display:flex;\">\n"
                        + "                    <div>\n"
                        + "                        <img style=\"border-radius:50%;width:60px;height:50px\" src=\"" + this.sellerService.getSeller(order.getId())[1] + "\"></a>\n"
                        + "                    </div>\n"
                        + "                    <div style=\"font-size: 24px;\">\n"
                        + "                        <label>" + this.sellerService.getSeller(order.getId())[0] + "</label></a>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "                <div style=\"margin-left:auto;display: flex;\">\n"
                        + "                    <a href=\"http://localhost:8080/WebEcommerce/seller-detail/" + this.sellerService.getSeller(order.getId())[2] + "\" style=\"text-decoration: none\"><button>Xem shop</button></a>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "<div style=\"margin-bottom:10px\">\n"
                        + "                <div >\n"
                        + "                    <table style=\"width:100%\" >\n";
                for (OrderDetail od : this.orderDetailService.getOrderDetail(order.getId())) {
                    content += "<tbody>\n"
                            + "                            <tr >\n"
                            + "                                <td><img style='width:60px; height:50px;margin-right:10px; border:1px solid' src=\"";
                    List<Image> l = (List<Image>) od.getIdProduct().getImageCollection();
                    content += l.get(0).getImage() + "\"</td><td ><b>" + od.getIdProduct().getName() + "</b></td><td><b>x " + od.getQuantity() + "</b></td>"
                            + "                                <td style='text-align:right'><b> <span style='text-decoration:underline'>đ</span> " + df.format(od.getUnitPrice()) + "</b></td></tr>"
                            + "                        </tbody>\n";
                }
                content += "                    </table>\n"
                        + "                </div>\n"
                        + "            </div> "
                        + "</div>\n"
                        + "    </div>\n"
                        + "</div>\n"
                        + "    <div style=\"border: 1px solid;margin-bottom:10px\" >\n"
                        + "        <table style=\"width: 100%;\">\n"
                        + "            <tbody style=\"background-color: #f8f9fa;\">\n"
                        + "               <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Tổng tiền hàng</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6\"><span style='text-decoration:underline'>đ</span> " + dk.format(order.getAmount()) + "</td>\n"
                        + "                </tr>\n"
                        + "                <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Phí ship</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><span style='text-decoration:underline'>đ</span> 0</td>\n"
                        + "                </tr>\n"
                        + "                <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Thành tiền</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6\"> <span style='text-decoration:underline'>đ</span> " + dk.format(order.getAmount()) + "</td>\n"
                        + "                </tr>\n"
                        + "            </tbody>\n"
                        + "        </table>\n"
                        + "    </div>\n"
                        + "<div style=\"border: 1px solid black\">\n"
                        + "    <div style=\"text-align: right;padding:  0.5rem\">\n"
                        + "         <span style=\"font-weight: 700\">Phương thức thanh toán</span><br>\n";
                if (order.getPaymentType() == 1) {
                    content += "<span style=\"color: #267bd1\">Thanh toán tại nhà";
                } else if (order.getPaymentType() == 2) {
                    content += "<span style=\"color: #267bd1\">Thanh toán online";
                }
                content += "</span>\n"
                        + "        </div>\n"
                        + "    </div>\n";
                mailService.sendMail(sendTo, subject, content);
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
                order.setPaymentType(1);
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

                    Product p = this.productRepository.getProductById(c.getProductId());
                    p.setQuantity(p.getQuantity() - c.getCount());
                    this.updateQuantityProduct(p);

                }
                SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
                SimpleDateFormat dk = new SimpleDateFormat("dd/MM/yyyy");
                DecimalFormat df = new DecimalFormat("###,###,###,###");

                String sendTo = order.getIdCustomer().getEmail();
                String subject = "WEBECOMMERCE THÔNG BÁO - ĐẶT HÀNG THÀNH CÔNG "+ RandomString.make(4);
                String content = "<div style=\"border:1px solid black;margin-bottom:10px\">\n"
                        + "<div style=\"text-align:center; padding: 0.5rem\">\n"
                        + "    <span style=\"font-size:22px\"><b>CHI TIẾT ĐƠN HÀNG </b></span><br>\n"
                        + "    <span>Mã đơn hàng: " + order.getId() + "</span><br>\n"
                        + "    <span>Ngày đặt hàng: " + dt.format(order.getOrderDate()) + "</span><br>\n"
                        + "    <span style=\"color:green\">Trạng thái đơn hàng: ";

                switch (order.getActive()) {
                    case 1:
                        content += "Đã đặt hàng";
                        break;
                    case 2:
                        content += "Chờ lấy hàng";
                        break;
                    case 3:
                        content += "Chờ vận chuyển";
                        break;
                    case 4:
                        content += "Đang giao";
                        break;
                    case 5:
                        content += "Đã hoàn thành (vào lúc : " + dt.format(order.getOrderReceived()) + ")";
                        break;
                }
                content += "</span>\n"
                        + "    <br><span>Ngày dự kiến giao hàng: " + dk.format(order.getRequiredDate()) + "<br></span>\n"
                        + "    <br>\n"
                        + "</div>\n"
                        + "</div>\n"
                        + "<div style=\"margin-top: 1rem;\">\n"
                        + "    <div style=\"border: 1px solid black\">\n"
                        + "        <div style=\"padding: 1.5rem\">\n"
                        + "            <b style=\"font-size:22px\">Địa chỉ nhận hàng</b>\n"
                        + "            <div style=\"padding-top: 1rem\">\n"
                        + "                <b> " + order.getIdShipAdress().getName() + " </b> <span> | </span><label> " + order.getIdShipAdress().getPhone() + "</label> \n"
                        + "                <p style=\"text-transform: capitalize\">" + order.getIdShipAdress().getAddress() + "</p> \n"
                        + "                <p><span style=\"text-transform: capitalize\"> " + order.getIdShipAdress().getWard() + "</span><span style=\"text-transform: capitalize\">, " + order.getIdShipAdress().getDistrict() + "</span><span>, " + order.getIdShipAdress().getCity().getName() + " </span>\n"
                        + "            </div>\n"
                        + "        </div>\n"
                        + "    </div>\n"
                        + "</div>\n"
                        + "<div>\n"
                        + "    <div style=\"border-left: 1px solid #dee2e6;border-right: 1px solid #dee2e6;border-color: black;\">\n"
                        + "        <div style=\"padding: 1rem;\">\n"
                        + "            <div style=\"display:flex;\">\n"
                        + "                <div style=\"display:flex;\">\n"
                        + "                    <div>\n"
                        + "                        <img style=\"border-radius:50%;width:60px;height:50px\" src=\"" + this.sellerService.getSeller(order.getId())[1] + "\"></a>\n"
                        + "                    </div>\n"
                        + "                    <div style=\"font-size: 24px;\">\n"
                        + "                        <label>" + this.sellerService.getSeller(order.getId())[0] + "</label></a>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "                <div style=\"margin-left:auto;display: flex;\">\n"
                        + "                    <a href=\"http://localhost:8080/WebEcommerce/seller-detail/" + this.sellerService.getSeller(order.getId())[2] + "\" style=\"text-decoration: none\"><button>Xem shop</button></a>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "<div style=\"margin-bottom:10px\">\n"
                        + "                <div >\n"
                        + "                    <table style=\"width:100%\" >\n";
                for (OrderDetail od : this.orderDetailService.getOrderDetail(order.getId())) {
                    content += "<tbody>\n"
                            + "                            <tr >\n"
                            + "                                <td><img style='width:60px; height:50px;margin-right:10px; border:1px solid' src=\"";
                    List<Image> l = (List<Image>) od.getIdProduct().getImageCollection();
                    content += l.get(0).getImage() + "\"</td><td ><b>" + od.getIdProduct().getName() + "</b></td><td><b>x " + od.getQuantity() + "</b></td>"
                            + "                                <td style='text-align:right'><b> <span style='text-decoration:underline'>đ</span> " + df.format(od.getUnitPrice()) + "</b></td></tr>"
                            + "                        </tbody>\n";
                }
                content += "                    </table>\n"
                        + "                </div>\n"
                        + "            </div> "
                        + "</div>\n"
                        + "    </div>\n"
                        + "</div>\n"
                        + "    <div style=\"border: 1px solid;margin-bottom:10px\" >\n"
                        + "        <table style=\"width: 100%;\">\n"
                        + "            <tbody style=\"background-color: #f8f9fa;\">\n"
                        + "               <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Tổng tiền hàng</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6\"><span style='text-decoration:underline'>đ</span> " + df.format(order.getAmount()) + "</td>\n"
                        + "                </tr>\n"
                        + "                <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Phí ship</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><span style='text-decoration:underline'>đ</span> 0</td>\n"
                        + "                </tr>\n"
                        + "                <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Thành tiền</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6\"> <span style='text-decoration:underline'>đ</span> " + order.getAmount() + "</td>\n"
                        + "                </tr>\n"
                        + "            </tbody>\n"
                        + "        </table>\n"
                        + "    </div>\n"
                        + "<div style=\"border: 1px solid black\">\n"
                        + "    <div style=\"text-align: right;padding:  0.5rem\">\n"
                        + "         <span style=\"font-weight: 700\">Phương thức thanh toán</span><br>\n";
                if (order.getPaymentType() == 1) {
                    content += "<span style=\"color: #267bd1\">Thanh toán tại nhà";
                } else if (order.getPaymentType() == 2) {
                    content += "<span style=\"color: #267bd1\">Thanh toán online";
                }
                content += "</span>\n"
                        + "        </div>\n"
                        + "    </div>\n";
                mailService.sendMail(sendTo, subject, content);
            }
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean addCancel(Cancel cancel) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.save(cancel);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public int updateActive(Orders o) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        Query query = session.createQuery("UPDATE Orders SET active = :active WHERE id = :id");
        query.setParameter("active", o.getActive());
        query.setParameter("id", o.getId());
        return query.executeUpdate();
    }

    @Override
    public Cancel getCancel(Orders o) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Cancel> q = builder.createQuery(Cancel.class);
        Root root = q.from(Cancel.class);

        q.where(builder.equal(root.get("idOrder"), o.getId()));
        Query query = session.createQuery(q);
        return (Cancel) query.getSingleResult();
    }

    @Override
    public int updateQuantityProduct(Product p) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        Query query = session.createQuery("UPDATE Product SET quantity = :quantity WHERE id = :id");
        query.setParameter("quantity", p.getQuantity());
        query.setParameter("id", p.getId());
        return query.executeUpdate();
    }

    @Override
    public int updateActiveAndSend(Orders o) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        Query query = session.createQuery("UPDATE Orders SET active = :active, daySend = :daySend WHERE id = :id");
        query.setParameter("active", o.getActive());
        query.setParameter("daySend", o.getDaySend());
        query.setParameter("id", o.getId());
        return query.executeUpdate();
    }

    @Override
    public int updateActiveAndReceived(Orders o) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        Query query = session.createQuery("UPDATE Orders SET active = :active, orderReceived = :orderReceived WHERE id = :id");
        query.setParameter("active", o.getActive());
        query.setParameter("orderReceived", o.getOrderReceived());
        query.setParameter("id", o.getId());
        return query.executeUpdate();
    }

    @Override
    public boolean addOrder(Orders o) {
        Session s = this.sessionFactoryBean.getObject().getCurrentSession();
        try {
            s.save(o);
            return true;
        } catch(HibernateException ex){
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public List<Orders> getOrderId(int orderId) {
        Session session = this.sessionFactoryBean.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Orders> q = builder.createQuery(Orders.class);
        Root root = q.from(Orders.class);
        q.select(root);
        
        q.where(builder.equal(root.get("id"), orderId));
        
        Query query = session.createQuery(q);

        return query.getResultList();
    }
}
