/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.repository.StatsRepository;
import com.tmdt.service.StatsService;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class StatsServiceImply implements StatsService{

    @Autowired
    private StatsRepository statsRepository;
    
    @Override
    public List<Object[]> countRole() {
        return this.statsRepository.countRole();
    }

    @Override
    public List<Object[]> countCategories() {
        return this.statsRepository.countCategories();
    }

    @Override
    public List<Object[]> statsProduct(String kw,Date fromDate, Date toDate) {
        return this.statsRepository.statsProduct(kw,fromDate,toDate);
    }
    
}
