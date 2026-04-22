package com.clothingshop.styleera.service;

import com.clothingshop.styleera.dao.ImageDao;
import com.clothingshop.styleera.model.Image;

import java.util.List;

public class ImageService {
    private ImageDao imageDao = new ImageDao();
    public List<Image> findByProductId(int productId){
        return imageDao.findByProductId(productId);
    }
    public Image getImageById(int imageId){
        return imageDao.findById(imageId).stream().findFirst().get();
    }
}
