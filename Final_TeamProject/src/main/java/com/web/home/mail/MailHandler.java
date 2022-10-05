package com.web.home.mail;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailHandler {
	private JavaMailSender javaMailSender;
	private MimeMessage mimeMessage;
	private MimeMessageHelper mimeMessageHelper;
	
	public MailHandler(JavaMailSender javaMailSender) throws MessagingException {
		this.javaMailSender = javaMailSender;
		mimeMessage = this.javaMailSender.createMimeMessage();
		mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
	}
	
	public void setSubject(String subject) throws MessagingException {
		mimeMessageHelper.setSubject(subject);
	}
	
	public void setText(String htmlContent) throws MessagingException {
		mimeMessageHelper.setText(htmlContent, true);
	}
	
	public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
		mimeMessageHelper.setFrom(email, name);
	}
	
	public void setTo(String email) throws MessagingException {
		mimeMessageHelper.setTo(email);
	}
	
	public void addInline(String contentId, DataSource dataSource) throws MessagingException {
		mimeMessageHelper.addInline(contentId, dataSource);
	}
	
	public void send() {
		javaMailSender.send(mimeMessage);
	}
}
