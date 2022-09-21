/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.configs;

import java.util.Properties;
import javax.sql.DataSource;
import static org.hibernate.cfg.AvailableSettings.DIALECT;
import static org.hibernate.cfg.AvailableSettings.SHOW_SQL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;

/**
 *
 * @author DELL
 */
@Configuration
@PropertySource("classpath:database.properties")
public class HibernateConfig {
    @Autowired
    private Environment e;
    @Bean
    public LocalSessionFactoryBean getSessionFactory(){
        LocalSessionFactoryBean factory = new LocalSessionFactoryBean();
        
        factory.setPackagesToScan(new String[] {
            "com.tmdt.pojos"
        });
        factory.setDataSource(dataSource());
        factory.setHibernateProperties(hibernateProperties());
        
        return factory;
    }
    
    @Bean
    public DataSource dataSource(){
        DriverManagerDataSource d = new DriverManagerDataSource();
        
        d.setDriverClassName(e.getProperty("hibernate.driver"));
        d.setUrl(e.getProperty("hibernate.url"));
        d.setUsername(e.getProperty("hibernate.username"));
        d.setPassword(e.getProperty("hibernate.password"));
        
        return d;
    }
    
    public Properties hibernateProperties(){
        Properties p = new Properties();
        
        p.setProperty(DIALECT, e.getProperty("hibernate.dialect"));
        p.setProperty(SHOW_SQL, e.getProperty("hibernate.showSql"));
        
        return p;
    }
    
    @Bean
    public HibernateTransactionManager transactionManager() {
        HibernateTransactionManager transactionManager
                = new HibernateTransactionManager();
        transactionManager.setSessionFactory(
                getSessionFactory().getObject());
        return transactionManager;
    }
}