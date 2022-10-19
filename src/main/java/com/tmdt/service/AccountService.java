/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.service;

import com.tmdt.pojos.Account;
import java.util.List;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
 *
 * @author DELL
 */
public interface AccountService extends UserDetailsService {
    boolean addAccount(Account ac);
    List<Account> getAccount(String username);
    List<Account> getAccount(int page);
    Account getAcById(int id);
    List<Account> getRole(String role, int page, int active);
    boolean updateAc(Account ac);
    Account getAcByUsername(String username);
}
