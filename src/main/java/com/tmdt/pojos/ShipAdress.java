/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.pojos;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "ship_adress")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ShipAdress.findAll", query = "SELECT s FROM ShipAdress s"),
    @NamedQuery(name = "ShipAdress.findById", query = "SELECT s FROM ShipAdress s WHERE s.id = :id"),
    @NamedQuery(name = "ShipAdress.findByName", query = "SELECT s FROM ShipAdress s WHERE s.name = :name"),
    @NamedQuery(name = "ShipAdress.findByPhone", query = "SELECT s FROM ShipAdress s WHERE s.phone = :phone"),
    @NamedQuery(name = "ShipAdress.findByAddress", query = "SELECT s FROM ShipAdress s WHERE s.address = :address")})
public class ShipAdress implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 4, max = 25)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "phone")
    private String phone;
    @Basic(optional = false)
    @NotNull
    @Size(min = 6, max = 50)
    @Column(name = "address")
    private String address;
    @Basic(optional = false)
    @NotNull
    @Size(min = 4, max = 25)
    @Column(name = "ward")
    private String ward;
    @Basic(optional = false)
    @NotNull
    @Size(min = 4, max = 25)
    @Column(name = "district")
    private String district;
    @JoinColumn(name = "city", referencedColumnName = "id")
    @ManyToOne
    private Location city;
    @JoinColumn(name = "id_customer", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Customer idCustomer;
    @Column(name = "priority")
    private Integer priority;
    @JsonIgnore
    @OneToMany(mappedBy = "idShipAdress")
    private Collection<Orders> ordersCollection;

    public ShipAdress() {
    }

    public ShipAdress(Integer id) {
        this.id = id;
    }

    public ShipAdress(Integer id, String name, String phone, String address) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.address = address;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Customer getIdCustomer() {
        return idCustomer;
    }

    public void setIdCustomer(Customer idCustomer) {
        this.idCustomer = idCustomer;
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
        if (!(object instanceof ShipAdress)) {
            return false;
        }
        ShipAdress other = (ShipAdress) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tmdt.pojos.ShipAdress[ id=" + id + " ]";
    }

    /**
     * @return the ward
     */
    public String getWard() {
        return ward;
    }

    /**
     * @param ward the ward to set
     */
    public void setWard(String ward) {
        this.ward = ward;
    }

    /**
     * @return the district
     */
    public String getDistrict() {
        return district;
    }

    /**
     * @param district the district to set
     */
    public void setDistrict(String district) {
        this.district = district;
    }

    /**
     * @return the city
     */
    public Location getCity() {
        return city;
    }

    /**
     * @param city the city to set
     */
    public void setCity(Location city) {
        this.city = city;
    }

    /**
     * @return the priority
     */
    public Integer getPriority() {
        return priority;
    }

    /**
     * @param priority the priority to set
     */
    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    /**
     * @return the ordersCollection
     */
    public Collection<Orders> getOrdersCollection() {
        return ordersCollection;
    }

    /**
     * @param ordersCollection the ordersCollection to set
     */
    public void setOrdersCollection(Collection<Orders> ordersCollection) {
        this.ordersCollection = ordersCollection;
    }
    
}
