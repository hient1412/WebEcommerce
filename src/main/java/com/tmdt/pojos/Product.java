/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.pojos;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "product")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p"),
    @NamedQuery(name = "Product.findById", query = "SELECT p FROM Product p WHERE p.id = :id"),
    @NamedQuery(name = "Product.findByName", query = "SELECT p FROM Product p WHERE p.name = :name"),
    @NamedQuery(name = "Product.findByPrice", query = "SELECT p FROM Product p WHERE p.price = :price"),
    @NamedQuery(name = "Product.findByManufacturer", query = "SELECT p FROM Product p WHERE p.manufacturer = :manufacturer"),
    @NamedQuery(name = "Product.findByCreatedDate", query = "SELECT p FROM Product p WHERE p.createdDate = :createdDate"),
    @NamedQuery(name = "Product.findByActive", query = "SELECT p FROM Product p WHERE p.active = :active"),
    @NamedQuery(name = "Product.findByQuantity", query = "SELECT p FROM Product p WHERE p.quantity = :quantity")})
public class Product implements Serializable {

    @Transient
    private MultipartFile[] file;
    
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "description")
    private String description;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "price")
    private String price;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "manufacturer")
    private String manufacturer;
    @Basic(optional = false)
    @Null
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate = new Date();
    @Basic(optional = false)
    @NotNull
    @Column(name = "active")
    private int active;
    @Basic(optional = false)
    @NotNull
    @Column(name = "quantity")
    private int quantity;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL,fetch = FetchType.EAGER, mappedBy = "idProduct")
    private Collection<Image> imageCollection;
    @JsonIgnore
    @JoinColumn(name = "id_category", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Category idCategory;
    @JsonIgnore
    @JoinColumn(name = "id_seller", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Seller idSeller;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idProduct")
    private Collection<Discount> discountCollection;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idProduct")
    private Collection<OrderDetail> orderDetailCollection;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idProduct")
    private Set<Review> reviewSet;

    public Product() {
    }

    public Product(Integer id) {
        this.id = id;
    }

    public Product(Integer id, String name, String description, String price, String manufacturer, Date createdDate, int active, int quantity) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.manufacturer = manufacturer;
        this.createdDate = createdDate;
        this.active = active;
        this.quantity = quantity;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @XmlTransient
    public Collection<Image> getImageCollection() {
        return imageCollection;
    }

    public void setImageCollection(Collection<Image> imageCollection) {
        this.imageCollection = imageCollection;
    }

    public Category getIdCategory() {
        return idCategory;
    }

    public void setIdCategory(Category idCategory) {
        this.idCategory = idCategory;
    }

    public Seller getIdSeller() {
        return idSeller;
    }

    public void setIdSeller(Seller idSeller) {
        this.idSeller = idSeller;
    }

    @XmlTransient
    public Collection<Discount> getDiscountCollection() {
        return discountCollection;
    }

    public void setDiscountCollection(Collection<Discount> discountCollection) {
        this.discountCollection = discountCollection;
    }

    @XmlTransient
    public Collection<OrderDetail> getOrderDetailCollection() {
        return orderDetailCollection;
    }

    public void setOrderDetailCollection(Collection<OrderDetail> orderDetailCollection) {
        this.orderDetailCollection = orderDetailCollection;
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
        if (!(object instanceof Product)) {
            return false;
        }
        Product other = (Product) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tmdt.pojos.Product[ id=" + id + " ]";
    }

    /**
     * @return the file
     */
    public MultipartFile[] getFile() {
        return file;
    }

    /**
     * @param file the file to set
     */
    public void setFile(MultipartFile[] file) {
        this.file = file;
    }

    /**
     * @return the reviewSet
     */
    public Set<Review> getReviewSet() {
        return reviewSet;
    }

    /**
     * @param reviewSet the reviewSet to set
     */
    public void setReviewSet(Set<Review> reviewSet) {
        this.reviewSet = reviewSet;
    }

}
