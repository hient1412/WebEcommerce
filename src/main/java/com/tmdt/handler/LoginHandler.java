/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.handler;

import com.tmdt.pojos.Account;
import com.tmdt.service.AccountService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

/**
 *
 * @author DELL
 */
@Component
public class LoginHandler implements AuthenticationSuccessHandler {

    @Autowired
    private AccountService userDetailsService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication a) throws IOException, ServletException {
        Account ac = this.userDetailsService.getAcByUsername(a.getName());

        request.getSession().setAttribute("current", ac);
        request.getSession().setAttribute("currentSeller", ac.getSeller());
        request.getSession().setAttribute("currentCustomer", ac.getCustomer());
        request.getSession().setAttribute("currentAdmin", ac.getAdmin());
        response.sendRedirect("/WebEcommerce/");
    }
    
}
