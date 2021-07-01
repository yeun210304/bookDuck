package com.spring.bookduck.snslogin;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.controller.LoginController;
import com.spring.bookduck.model.biz.LoginBiz;
import com.spring.bookduck.model.dto.MemberDto;

@Controller
public class SnsController {
	
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginBiz biz;
	
	@RequestMapping("/naverlogin.do")
	public String snsLogin(HttpSession session, HttpServletRequest request) {
		logger.info("[Controller]: naverlogin.do");
		String member_email = request.getParameter("member_email");
		String token = request.getParameter("token");
		
		if(token != null) {
			System.out.println(token);
		}
		MemberDto snsres = biz.snslogin(member_email);
		if(snsres == null) {
			request.setAttribute("member_email", member_email);
		}
		
		return "member/navercallback";
		
	}
	
	@RequestMapping("/googlelogin.do")
	public String googleLogin(HttpServletRequest request) {
		logger.info("[Controller]: googlelogin.do");
		String member_email = request.getParameter("member_email");
		String member_id = request.getParameter("member_id");
		
		MemberDto res = biz.snslogin(member_email);
		if(res==null) {
			request.setAttribute("member_email", member_email);
			request.setAttribute("member_id", member_id);
		}
		
		return "index";
	}
	
	@RequestMapping("/kakaologin.do")
	public String kakaoLogin(HttpServletRequest request) {
		logger.info("[Controller]: kakaologin.do");
		String member_email = request.getParameter("kakao_email");
		
		MemberDto res = biz.snslogin(member_email);
		
		if(res==null) {
			request.setAttribute("member_email", member_email);
		}
		
		return "index";
	}
	
	

	
	

}
