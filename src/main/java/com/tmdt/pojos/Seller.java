/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.pojos;

import java.io.Serializable;
import java.util.Collection;
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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "seller")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Seller.findAll", query = "SELECT s FROM Seller s"),
    @NamedQuery(name = "Seller.findById", query = "SELECT s FROM Seller s WHERE s.id = :id"),
    @NamedQuery(name = "Seller.findByName", query = "SELECT s FROM Seller s WHERE s.name = :name"),
    @NamedQuery(name = "Seller.findByAddress", query = "SELECT s FROM Seller s WHERE s.address = :address")})
public class Seller implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idSeller")
    private Collection<SellerOrder> sellerOrderCollection;

    @Transient
    private MultipartFile file;
    
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 4, max = 50)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(max = 30)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    @NotNull
    @Size(max = 11)
    @Column(name = "phone")
    private String phone;
    @Basic(optional = false)
    @NotNull
    @Size(min = 8, max = 50)
    @Column(name = "address")
    private String address;
    @Basic(optional = false)
    @Size(max = 150)
    @Column(name = "description")
    private String description;
    @Basic(optional = false)
    @Size(max = 150)
    @Column(name = "avatar")
    private String avatar;
    @Basic(optional = false)
    @Column(name = "admin_ban")
    private int adminBan;
    @JoinColumn(name = "id_account", referencedColumnName = "id")
    @OneToOne
    private Account idAccount;
    @JoinColumn(name = "id_location", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Location idLocation;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idSeller")
    private Collection<Product> productCollection;

    public Seller() {
    }

    public Seller(Integer id) {
        this.id = id;
    }

    public Seller(Integer id, String name, String address) {
        this.id = id;
        this.name = name;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Account getIdAccount() {
        return idAccount;
    }

    public void setIdAccount(Account idAccount) {
        this.idAccount = idAccount;
    }

    public Location getIdLocation() {
        return idLocation;
    }

    public void setIdLocation(Location idLocation) {
        this.idLocation = idLocation;
    }

    @XmlTransient
    public Collection<Product> getProductCollection() {
        return productCollection;
    }

    public void setProductCollection(Collection<Product> productCollection) {
        this.productCollection = productCollection;
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
        if (!(object instanceof Seller)) {
            return false;
        }
        Seller other = (Seller) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tmdt.pojos.Seller[ id=" + id + " ]";
    }

    /**
     * @return the avatar
     */
    public String getAvatar() {
        return avatar;
    }

    /**
     * @param avatar the avatar to set
     */
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    /**
     * @return the file
     */
    public MultipartFile getFile() {
        return file;
    }

    /**
     * @param file the file to set
     */
    public void setFile(MultipartFile file) {
        this.file = file;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the phone
     */
    public String getPhone() {
        return phone;
    }

    /**
     * @param phone the phone to set
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }
//
//    @XmlTransient
//    public Set<SellerOrder> getSellerOrderSet() {
//        return sellerOrderSet;
//    }
//
//    public void setSellerOrderSet(Set<SellerOrder> sellerOrderSet) {
//        this.sellerOrderSet = sellerOrderSet;
//    }

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
     * @return the adminBan
     */
    public int getAdminBan() {
        return adminBan;
    }

    /**
     * @param adminBan the adminBan to set
     */
    public void setAdminBan(int adminBan) {
        this.adminBan = adminBan;
    }
}
