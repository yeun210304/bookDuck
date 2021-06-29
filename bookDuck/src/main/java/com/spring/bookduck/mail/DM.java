package com.spring.bookduck.mail;

public class DM {
	
	//회원가입시 인증번호 발송
	public static String dmCertification(String authCode) {
		
		//HTML BLOCK
		String sb="인증번호는 "+authCode+"입니다.";
		
		return sb;
	}

}
