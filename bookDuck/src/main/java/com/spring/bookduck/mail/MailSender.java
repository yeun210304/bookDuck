package com.spring.bookduck.mail;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;


public class MailSender {
	/*
	@Autowired
	protected JavaMailSender mailSender;

	public void SendEmail(MailDto mailDto) throws Exception{
		
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			msg.setSubject(mailDto.getSubject());
			msg.setText(mailDto.getContent());
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(mailDto.getReceiver()));
		} catch (MessagingException e) {
			System.out.println("MessageingException");
			e.printStackTrace();
		}
		try {
			mailSender.send(msg);
		} catch (MailException e) {
			System.out.println("MailException 발생");
			e.printStackTrace();
		}
		
	}
*/
}
