/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.Image;
import com.tmdt.repository.ImageRepository;
import com.tmdt.service.ImageService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class ImageServiceImply implements ImageService{
    @Autowired
    private ImageRepository imageRepository;

    @Override
    public List<Image> getImageByProductId(int productId) {
        return this.imageRepository.getImageByProductId(productId);
    }
}
