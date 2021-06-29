package com.spring.bookduck.mail;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class EmailSender {
	
	@Autowired private JavaMailSender mailSender;
	
	public void sendMail(String subject, String content, String receiver, String sender) throws MessagingException{
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper  messageHelper = new MimeMessageHelper(message, true, "utf-8");
		
		messageHelper.setSubject(subject);
		messageHelper.setText(content, true);
		
		messageHelper.setFrom(new InternetAddress(sender));
		messageHelper.setTo(new InternetAddress(receiver));
		
		mailSender.send(message);
		
	}

}
