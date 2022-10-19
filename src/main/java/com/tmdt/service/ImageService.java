/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.service;

import com.tmdt.pojos.Image;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface ImageService {
    List<Image> getImageByProductId(int productId);
    boolean addImage(Image i);
    boolean updateImage(Image i);
    boolean delete(Image i);
//    Image getImageByProductId(int productId);
}
