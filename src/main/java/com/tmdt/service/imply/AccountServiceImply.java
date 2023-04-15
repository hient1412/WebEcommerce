/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.pojos.Account;
import com.tmdt.repository.AccountRepository;
import com.tmdt.service.AccountService;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service("userDetailsService")
public class AccountServiceImply implements AccountService{

    @Autowired
    private AccountRepository accountRepository;
    
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    
    @Override
    public boolean addAccount(Account ac) {
        String password = ac.getPassword();
        ac.setPassword(this.passwordEncoder.encode(password));
        ac.setRole(ac.getRole());
        return this.accountRepository.addAccount(ac);
    }

    @Override
    public List<Account> getAccount(String username) {
        return this.accountRepository.getAccount(username);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        List<Account> listAc = this.getAccount(username);
        if (listAc.isEmpty()) {
            throw new UsernameNotFoundException("Tên tài khoản không tồn tại !!!");
        }
        Account ac = listAc.get(0);
        Set<GrantedAuthority> authorities = new HashSet<>();
        authorities.add(new SimpleGrantedAuthority(ac.getRole()));
        return new User(ac.getUsername(), ac.getPassword(), authorities);
    }

    @Override
    public Account getAcById(int id) {
        return this.accountRepository.getAcById(id);
    }

    @Override
    public List<Account> getRole(String role, int page, int active) {
        return this.accountRepository.getRole(role,page,active);
    }

    @Override
    public boolean updateAc(Account ac) {
        String password = ac.getPassword();
        ac.setPassword(this.passwordEncoder.encode(password));
        return this.accountRepository.updateAc(ac);
    }
    @Override
    public Account getAcByUsername(String username) {
        return this.accountRepository.getAcByUsername(username);
    }

    @Override
    public List<Account> getAccount(int page) {
        return this.accountRepository.getAccount(page);
    }

    @Override
    public boolean deleteAc(Account ac) {
        return this.accountRepository.deleteAc(ac);
    }

    @Override
    public List<Account> getAcUserNameList(String username) {
        return this.accountRepository.getAcUserNameList(username);
    }

    @Override
    public int changePassword(Account ac) {
        ac.setPassword(this.passwordEncoder.encode(ac.getPasswordNew()));
        return this.accountRepository.changePassword(ac);
    }

    @Override
    public int renewPassword(Account ac, String password) {
        return this.accountRepository.renewPassword(ac,this.passwordEncoder.encode(password));
    }

}
