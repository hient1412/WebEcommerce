/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.tmdt.pojos.Image;
import com.tmdt.repository.ImageRepository;
import com.tmdt.service.ImageService;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class ImageServiceImply implements ImageService {

    @Autowired
    private ImageRepository imageRepository;

    @Override
    public List<Image> getImageByProductId(int productId) {
        return this.imageRepository.getImageByProductId(productId);
    }

    @Override
    public boolean addImage(Image i) {
        return this.imageRepository.addImage(i);
    }

    @Override
    public boolean updateImage(Image i) {
        return this.imageRepository.updateImage(i);
    }

    @Override
    public boolean delete(Image i) {
        return this.imageRepository.delete(i);
    }

//    @Override
//    public Image getImageByProductId(int productId) {
//        return this.imageRepository.getImageByProductId(productId);
//    }
}
