/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.configs;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.tmdt.handler.LoginHandler;
import com.tmdt.handler.LogoutHandler;
import java.util.Properties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 *
 * @author DELL
 */
@Configuration
@EnableTransactionManagement
@EnableWebSecurity
@ComponentScan(basePackages = {
    "com.tmdt.controllers",
    "com.tmdt.repository",
    "com.tmdt.service",
    "com.tmdt.handler",
    "com.tmdt.validator"
})
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
    
    @Autowired
    private LoginHandler loginHandler;

    @Autowired
    private LogoutHandler logoutHandler;
    @Autowired
    private UserDetailsService userDetailsService;
    
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    
    @Bean
    public JavaMailSender configureJavaMailSender(){
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

        mailSender.setHost("smtp.gmail.com");
        mailSender.setUsername("1951012024hien@ou.edu.vn");
        mailSender.setPassword("Thuyhien1412@@");

        mailSender.setPort(587);

        Properties mailProperties = new Properties();
        mailProperties.put("mail.smtp.starttls.enable", "true");
        mailProperties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        mailProperties.put("mail.smtp.auth", "true");
        mailProperties.put("mail.debug", "true");
        mailProperties.put("mail.transport,protocol", "smtp");
        mailProperties.put("mail.smtp.ssl.protocols", "TLSv1.2");

        mailSender.setJavaMailProperties(mailProperties);

        return mailSender;
    }

    
    @Bean
    public Cloudinary cloudinary() {
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dxs9d8uua",
                "api_key", "362753783447161",
                "api_secret", "FWBi92rPwtgzDDHEovKyseQZZUo",
                "secure", true
        ));
        return cloudinary;
    }
    
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.formLogin().loginPage("/login").usernameParameter("username").passwordParameter("password");

        http.formLogin().successHandler(loginHandler);

        http.logout().logoutSuccessHandler(logoutHandler);
        http.exceptionHandling().accessDeniedPage("/login?accessDenied");
        http.authorizeRequests().antMatchers("/").permitAll()
                .antMatchers("/personal").authenticated()
                .antMatchers("/**/change-password").authenticated()
                .antMatchers("/**/cart").not().access("hasAnyRole('ROLE_SELLER','ROLE_ADMIN')")
                .antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
                .antMatchers("/customer/**").access("hasRole('ROLE_CUSTOMER')")
                .antMatchers("/seller/**").access("hasRole('ROLE_SELLER')")
                .antMatchers("/**/buyNow").access("hasRole('ROLE_CUSTOMER')")
                .antMatchers("/**/report").access("hasRole('ROLE_CUSTOMER')");
                
        http.csrf().disable();
    }
}
