/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.service.imply;

import com.tmdt.service.MailService;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

/**
 *
 * @author DELL
 */
@Service
public class MailServiceImply implements MailService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Override
    public void sendMail(String sentTo, String subject, String content) {
        if (!(sentTo == null || subject == null || content == null)) {

            try {
                MimeMessage newEmail = javaMailSender.createMimeMessage();
                newEmail.setSubject(subject, "UTF-8");
                
                MimeMessageHelper helper = new MimeMessageHelper(newEmail, "UTF-8");
                helper.setTo(sentTo);
                helper.setText(content, true);
                javaMailSender.send(newEmail);
            } catch (MessagingException ex) {
                Logger.getLogger(MailServiceImply.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

}
