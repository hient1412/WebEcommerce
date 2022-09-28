/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.pojos;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "voucher")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Voucher.findAll", query = "SELECT v FROM Voucher v"),
    @NamedQuery(name = "Voucher.findById", query = "SELECT v FROM Voucher v WHERE v.id = :id"),
    @NamedQuery(name = "Voucher.findByName", query = "SELECT v FROM Voucher v WHERE v.name = :name"),
    @NamedQuery(name = "Voucher.findByAmount", query = "SELECT v FROM Voucher v WHERE v.amount = :amount"),
    @NamedQuery(name = "Voucher.findByMaxQuantity", query = "SELECT v FROM Voucher v WHERE v.maxQuantity = :maxQuantity"),
    @NamedQuery(name = "Voucher.findByStartDate", query = "SELECT v FROM Voucher v WHERE v.startDate = :startDate"),
    @NamedQuery(name = "Voucher.findByEndDate", query = "SELECT v FROM Voucher v WHERE v.endDate = :endDate"),
    @NamedQuery(name = "Voucher.findByVoucherCode", query = "SELECT v FROM Voucher v WHERE v.voucherCode = :voucherCode"),
    @NamedQuery(name = "Voucher.findByDecription", query = "SELECT v FROM Voucher v WHERE v.decription = :decription"),
    @NamedQuery(name = "Voucher.findByIsDelected", query = "SELECT v FROM Voucher v WHERE v.isDelected = :isDelected")})
public class Voucher implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Size(max = 50)
    @Column(name = "name")
    private String name;
    @Column(name = "amount")
    private Long amount;
    @Column(name = "max_quantity")
    private Integer maxQuantity;
    @Column(name = "start_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date startDate;
    @Column(name = "end_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date endDate;
    @Size(max = 15)
    @Column(name = "voucher_code")
    private String voucherCode;
    @Size(max = 255)
    @Column(name = "decription")
    private String decription;
    @Column(name = "is_delected")
    private Integer isDelected;
    @JoinColumn(name = "id_admin", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Admin idAdmin;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idVoucher")
    private Collection<VoucherCustomer> voucherCustomerCollection;
    @OneToMany(mappedBy = "idVoucher")
    private Collection<Orders> ordersCollection;

    public Voucher() {
    }

    public Voucher(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public Integer getMaxQuantity() {
        return maxQuantity;
    }

    public void setMaxQuantity(Integer maxQuantity) {
        this.maxQuantity = maxQuantity;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getDecription() {
        return decription;
    }

    public void setDecription(String decription) {
        this.decription = decription;
    }

    public Integer getIsDelected() {
        return isDelected;
    }

    public void setIsDelected(Integer isDelected) {
        this.isDelected = isDelected;
    }

    public Admin getIdAdmin() {
        return idAdmin;
    }

    public void setIdAdmin(Admin idAdmin) {
        this.idAdmin = idAdmin;
    }

    @XmlTransient
    public Collection<VoucherCustomer> getVoucherCustomerCollection() {
        return voucherCustomerCollection;
    }

    public void setVoucherCustomerCollection(Collection<VoucherCustomer> voucherCustomerCollection) {
        this.voucherCustomerCollection = voucherCustomerCollection;
    }

    @XmlTransient
    public Collection<Orders> getOrdersCollection() {
        return ordersCollection;
    }

    public void setOrdersCollection(Collection<Orders> ordersCollection) {
        this.ordersCollection = ordersCollection;
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
        if (!(object instanceof Voucher)) {
            return false;
        }
        Voucher other = (Voucher) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tmdt.pojos.Voucher[ id=" + id + " ]";
    }
    
}
