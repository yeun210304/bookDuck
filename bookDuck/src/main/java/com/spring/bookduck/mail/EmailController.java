package com.spring.bookduck.mail;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.bookduck.controller.LoginController;

@Controller
public class EmailController {
	
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private EmailSender emailSender;
	
	@RequestMapping("/certifiedMail.do")
	@ResponseBody
	public String certifiedMail(@RequestParam(required=false) String user_email1,
								@RequestParam(required=false) String user_email2) {
		logger.info("해당 유저의 정보 확인, user_email1={} user_email2={}", user_email1, user_email2);
		
		String userEmail1 = ""; //해당 유저 이메일
		String subject = ""; //제목
		String content = ""; //내용
		String receiver = ""; //받는이
		String sender = ""; //보낸이
		
		int authCode = 0;
		String authCodes = "";
		boolean bool = false;
		
		if(user_email1!=null && !user_email1.isEmpty() &&
				user_email2!=null && !user_email2.isEmpty()) {
			userEmail1 = user_email1 + "@" + user_email2;
			logger.info("입력된 해당 유저의 이메일 계정 체크={}", userEmail1);
			
			//RandomKey k = new RandomKey();
			//String key = k.excuteGenetate();
			
			//인증번호 난수 생성 (우선 간단히 만들어보겠습니다.)
			for(int i=0; i<6; i++) {
				authCode = (int)(Math.random()*9+1); // 1~9 사이 난수생성
				authCodes += Integer.toString(authCode);
				logger.info("6자리 난수 생성={}", authCode);
			}
			
			logger.info("난수 체크={}", authCodes);
			
			subject="안녕하세요 북덕 페이지 관리자입니다. 회원가입 인증 번호입니다.";
			content=DM.dmCertification(authCodes);
			receiver=userEmail1;
			sender="bookduckmail@gmail.com";
		}
		
		try {
			emailSender.sendMail(subject, content, receiver, sender);
			logger.info("이메일 발송 성공!");
		} catch (Exception e) {
			logger.info("이메일 발송 실패!");
			e.printStackTrace();
		}
		
		return authCodes;
		
	
	}

}
