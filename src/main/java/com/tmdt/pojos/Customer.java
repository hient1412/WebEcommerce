/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.pojos;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "customer")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Customer.findAll", query = "SELECT c FROM Customer c"),
    @NamedQuery(name = "Customer.findById", query = "SELECT c FROM Customer c WHERE c.id = :id"),
    @NamedQuery(name = "Customer.findByDob", query = "SELECT c FROM Customer c WHERE c.dob = :dob"),
    @NamedQuery(name = "Customer.findByGender", query = "SELECT c FROM Customer c WHERE c.gender = :gender"),
    @NamedQuery(name = "Customer.findByIsDelected", query = "SELECT c FROM Customer c WHERE c.isDelected = :isDelected")})
public class Customer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "dob")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dob;
    @Column(name = "gender")
    private Boolean gender;
    @Basic(optional = false)
    @NotNull
    @Column(name = "is_delected")
    private int isDelected;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idCustomer")
    private Set<VoucherCustomer> voucherCustomerSet;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idCustomer")
    private Set<ShipAdress> shipAdressSet;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idCustomer")
    private Set<Review> reviewSet;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idCustomer")
    private Set<Comment> commentSet;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idCustomer")
    private Set<Orders> ordersSet;
    @JoinColumn(name = "id_account", referencedColumnName = "id")
    @OneToOne(optional = false)
    private Account idAccount;
    @JoinColumn(name = "id_hometown", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Location location;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idCustomer")
    private Set<Likes> likesSet;

    public Customer() {
    }

    public Customer(Integer id) {
        this.id = id;
    }

    public Customer(Integer id, int isDelected) {
        this.id = id;
        this.isDelected = isDelected;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public int getIsDelected() {
        return isDelected;
    }

    public void setIsDelected(int isDelected) {
        this.isDelected = isDelected;
    }

    @XmlTransient
    public Set<VoucherCustomer> getVoucherCustomerSet() {
        return voucherCustomerSet;
    }

    public void setVoucherCustomerSet(Set<VoucherCustomer> voucherCustomerSet) {
        this.voucherCustomerSet = voucherCustomerSet;
    }

    @XmlTransient
    public Set<ShipAdress> getShipAdressSet() {
        return shipAdressSet;
    }

    public void setShipAdressSet(Set<ShipAdress> shipAdressSet) {
        this.shipAdressSet = shipAdressSet;
    }

    @XmlTransient
    public Set<Review> getReviewSet() {
        return reviewSet;
    }

    public void setReviewSet(Set<Review> reviewSet) {
        this.reviewSet = reviewSet;
    }

    @XmlTransient
    public Set<Comment> getCommentSet() {
        return commentSet;
    }

    public void setCommentSet(Set<Comment> commentSet) {
        this.commentSet = commentSet;
    }

    @XmlTransient
    public Set<Orders> getOrdersSet() {
        return ordersSet;
    }

    public void setOrdersSet(Set<Orders> ordersSet) {
        this.ordersSet = ordersSet;
    }

    public Account getIdAccount() {
        return idAccount;
    }

    public void setIdAccount(Account idAccount) {
        this.idAccount = idAccount;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    @XmlTransient
    public Set<Likes> getLikesSet() {
        return likesSet;
    }

    public void setLikesSet(Set<Likes> likesSet) {
        this.likesSet = likesSet;
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
        if (!(object instanceof Customer)) {
            return false;
        }
        Customer other = (Customer) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tmdt.pojos.Customer[ id=" + id + " ]";
    }
    
}
