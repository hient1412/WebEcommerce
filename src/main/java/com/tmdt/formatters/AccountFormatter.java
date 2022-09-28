/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.formatters;

import com.tmdt.pojos.Account;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;

/**
 *
 * @author DELL
 */
public class AccountFormatter implements Formatter<Account>{

    @Override
    public String print(Account account, Locale locale) {
        return String.valueOf(account.getId());
    }

    @Override
    public Account parse(String acId, Locale locale) throws ParseException {
        Account ac = new Account();
        ac.setId(Integer.parseInt(acId));
        return ac;
    }
}
