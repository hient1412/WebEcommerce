/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.pojos;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "voucher_customer")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "VoucherCustomer.findAll", query = "SELECT v FROM VoucherCustomer v"),
    @NamedQuery(name = "VoucherCustomer.findById", query = "SELECT v FROM VoucherCustomer v WHERE v.id = :id")})
public class VoucherCustomer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @JoinColumn(name = "id_customer", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Customer idCustomer;
    @JoinColumn(name = "id_voucher", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Voucher idVoucher;

    public VoucherCustomer() {
    }

    public VoucherCustomer(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
        if (!(object instanceof VoucherCustomer)) {
            return false;
        }
        VoucherCustomer other = (VoucherCustomer) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tmdt.pojos.VoucherCustomer[ id=" + id + " ]";
    }
    
}
