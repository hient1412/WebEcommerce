/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.pojos;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "cancel")
@NamedQueries({
    @NamedQuery(name = "Cancel.findAll", query = "SELECT c FROM Cancel c"),
    @NamedQuery(name = "Cancel.findById", query = "SELECT c FROM Cancel c WHERE c.id = :id"),
    @NamedQuery(name = "Cancel.findByCancelDescription", query = "SELECT c FROM Cancel c WHERE c.cancelDescription = :cancelDescription"),
    @NamedQuery(name = "Cancel.findByCancelDate", query = "SELECT c FROM Cancel c WHERE c.cancelDate = :cancelDate")})
public class Cancel implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = javax.persistence.GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "cancel_description")
    private String cancelDescription;
    @Basic(optional = false)
    @Column(name = "cancel_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date cancelDate;
    @JoinColumn(name = "id_account", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Account idAccount;
    @JoinColumn(name = "id_order", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Orders idOrder;

    public Cancel() {
    }

    public Cancel(Integer id) {
        this.id = id;
    }

    public Cancel(Integer id, String cancelDescription, Date cancelDate) {
        this.id = id;
        this.cancelDescription = cancelDescription;
        this.cancelDate = cancelDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCancelDescription() {
        return cancelDescription;
    }

    public void setCancelDescription(String cancelDescription) {
        this.cancelDescription = cancelDescription;
    }

    public Date getCancelDate() {
        return cancelDate;
    }

    public void setCancelDate(Date cancelDate) {
        this.cancelDate = cancelDate;
    }

    public Account getIdAccount() {
        return idAccount;
    }

    public void setIdAccount(Account idAccount) {
        this.idAccount = idAccount;
    }

    public Orders getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(Orders idOrder) {
        this.idOrder = idOrder;
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
        if (!(object instanceof Cancel)) {
            return false;
        }
        Cancel other = (Cancel) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tmdt.pojos.Cancel[ id=" + id + " ]";
    }
    
}
