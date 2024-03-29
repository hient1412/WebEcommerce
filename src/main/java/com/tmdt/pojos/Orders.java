/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.pojos;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.Set;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.servlet.annotation.MultipartConfig;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "orders")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Orders.findAll", query = "SELECT o FROM Orders o"),
    @NamedQuery(name = "Orders.findById", query = "SELECT o FROM Orders o WHERE o.id = :id"),
    @NamedQuery(name = "Orders.findByOrderDate", query = "SELECT o FROM Orders o WHERE o.orderDate = :orderDate"),
    @NamedQuery(name = "Orders.findByRequiredDate", query = "SELECT o FROM Orders o WHERE o.requiredDate = :requiredDate"),
    @NamedQuery(name = "Orders.findByAmount", query = "SELECT o FROM Orders o WHERE o.amount = :amount"),
    @NamedQuery(name = "Orders.findByShipFee", query = "SELECT o FROM Orders o WHERE o.shipFee = :shipFee"),
    @NamedQuery(name = "Orders.findByActive", query = "SELECT o FROM Orders o WHERE o.active = :active"),
    @NamedQuery(name = "Orders.findByPaymentType", query = "SELECT o FROM Orders o WHERE o.paymentType = :paymentType"),
    @NamedQuery(name = "Orders.findByIsPayment", query = "SELECT o FROM Orders o WHERE o.isPayment = :isPayment")})
public class Orders implements Serializable {

    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idOrder")
    private Collection<SellerOrder> sellerOrderCollection;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "order_date")
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date orderDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "required_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date requiredDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private long amount;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ship_fee")
    private int shipFee;
    @Basic(optional = false)
    @NotNull
    @Column(name = "active")
    private int active;
    @Basic(optional = false)
    @NotNull
    @Column(name = "payment_type")
    private int paymentType;
    @Basic(optional = false)
    @NotNull
    @Column(name = "is_payment")
    private int isPayment;
    @OneToMany(mappedBy = "idOrder",fetch = FetchType.EAGER)
    private Collection<OrderDetail> orderDetailCollection;
    @JoinColumn(name = "id_customer", referencedColumnName = "id")
    @ManyToOne
    private Customer idCustomer;
    @JoinColumn(name = "id_voucher", referencedColumnName = "id")
    @ManyToOne
    private Voucher idVoucher;
    @JoinColumn(name = "id_shipadress", referencedColumnName = "id")
    @ManyToOne
    private ShipAdress idShipAdress;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idOrder")
    private Collection<Cancel> cancelCollection;
    @Column(name = "daySend")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date daySend;
    @Column(name = "order_received")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date orderReceived;
    public Orders() {
    }

    public Orders(Integer id) {
        this.id = id;
    }

    public Orders(Integer id, Date orderDate, Date requiredDate, long amount, int shipFee, int active, int paymentType, int isPayment) {
        this.id = id;
        this.orderDate = orderDate;
        this.requiredDate = requiredDate;
        this.amount = amount;
        this.shipFee = shipFee;
        this.active = active;
        this.paymentType = paymentType;
        this.isPayment = isPayment;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Date getRequiredDate() {
        return requiredDate;
    }

    public void setRequiredDate(Date requiredDate) {
        this.requiredDate = requiredDate;
    }

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
    }

    public int getShipFee() {
        return shipFee;
    }

    public void setShipFee(int shipFee) {
        this.shipFee = shipFee;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public int getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(int paymentType) {
        this.paymentType = paymentType;
    }

    public int getIsPayment() {
        return isPayment;
    }

    public void setIsPayment(int isPayment) {
        this.isPayment = isPayment;
    }

    @XmlTransient
    public Collection<OrderDetail> getOrderDetailCollection() {
        return orderDetailCollection;
    }

    public void setOrderDetailCollection(Collection<OrderDetail> orderDetailCollection) {
        this.orderDetailCollection = orderDetailCollection;
    }

    public Customer getIdCustomer() {
        return idCustomer;
    }

    public void setIdCustomer(Customer idCustomer) {
        this.idCustomer = idCustomer;
    }

    public Voucher getIdVoucher() {
        return idVoucher;
    }

    public void setIdVoucher(Voucher idVoucher) {
        this.idVoucher = idVoucher;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Orders)) {
            return false;
        }
        Orders other = (Orders) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tmdt.pojos.Orders[ id=" + id + " ]";
    }

    /**
     * @return the sellerOrderCollection
     */
    public Collection<SellerOrder> getSellerOrderCollection() {
        return sellerOrderCollection;
    }

    /**
     * @param sellerOrderCollection the sellerOrderCollection to set
     */
    public void setSellerOrderCollection(Collection<SellerOrder> sellerOrderCollection) {
        this.sellerOrderCollection = sellerOrderCollection;
    }

    /**
     * @return the idShipAdress
     */
    public ShipAdress getIdShipAdress() {
        return idShipAdress;
    }

    /**
     * @param idShipAdress the idShipAdress to set
     */
    public void setIdShipAdress(ShipAdress idShipAdress) {
        this.idShipAdress = idShipAdress;
    }

    /**
     * @return the cancelCollection
     */
    public Collection<Cancel> getCancelCollection() {
        return cancelCollection;
    }

    /**
     * @param cancelCollection the cancelCollection to set
     */
    public void setCancelCollection(Collection<Cancel> cancelCollection) {
        this.cancelCollection = cancelCollection;
    }

    /**
     * @return the daySend
     */
    public Date getDaySend() {
        return daySend;
    }

    /**
     * @param daySend the daySend to set
     */
    public void setDaySend(Date daySend) {
        this.daySend = daySend;
    }

    /**
     * @return the orderReceived
     */
    public Date getOrderReceived() {
        return orderReceived;
    }

    /**
     * @param orderReceived the orderReceived to set
     */
    public void setOrderReceived(Date orderReceived) {
        this.orderReceived = orderReceived;
    }

    
}
