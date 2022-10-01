/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tmdt.repository;

import com.tmdt.pojos.Account;
import java.util.List;

/**
 *
 * @author DELL
 */
public interface AccountRepository {
    boolean addAccount(Account ac);
    List<Account> getAccount(String username);
    Account getAcById(int id);
    List<Account> getRole(String role, int page, int active);
    boolean updateAc(Account ac);
    Account getAcByUsername(String username);
}
