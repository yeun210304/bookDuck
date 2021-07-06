package com.spring.bookduck.snslogin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		//String naver_id_login = new naver_id_login("Hft3mSmHcCpHqnsB7j3E", "http://localhost:8787/bookduck/naverlogin.do");
		//String redirectURI = URLEncoder.encode("http://localhost:8787/bookduck/naverlogin.do", "UTF-8");
		logger.info("[Controller]: naverlogin.do");
		String member_email = request.getParameter("member_email");
		String token = request.getParameter("token");
		
		if(token != null) {
			System.out.printf("token null:%s", token);
		}
		if(member_email == null) {
			return "member/navercallback";
		}
		MemberDto res = biz.snslogin(member_email);
		if(res == null) {
			request.setAttribute("member_email", member_email);
			System.out.println("네이버 간편 회원가입 : "+member_email);
			return "member/snsjoinform";
		}
		return "redirect:login.do";
		
	}
	
	@RequestMapping("/googlelogin.do")
	public String googleLogin(HttpServletRequest request, HttpSession session) {
		logger.info("[Controller]: googlelogin.do");
		String member_email = request.getParameter("member_email");
		String member_id = request.getParameter("member_id");
		
		MemberDto res = biz.snslogin(member_email);
		if(res==null) {
			request.setAttribute("member_email", member_email);
			request.setAttribute("member_id", member_id);
			System.out.println("컨트롤러 이메일: "+member_email);
			
			return "member/snsjoinform";
		}else { 
			System.out.println("구글 가입 완료 회원 실행");
			session.setAttribute("Ldto", res);
		}
		
		return "home";
	}
	
	/*
	@RequestMapping("/googlelogin.do")
	public String googleLogin(Model model, String member_email) {
		logger.info("[Controller]: googlelogin.do");
		MemberDto Ldto = new MemberDto();
		model.addAttribute("Ldto", biz.snslogin(member_email));
		
		if(Ldto==null) {
			return "member/snsjoinform";
		}else {
			System.out.println("구글 가입 완료 회원 실행");
		}
		return "home";
	}
	*/
	@RequestMapping("/kakaologin.do")
	public String kakaoLogin(HttpServletRequest request, HttpSession session) {
		logger.info("[Controller]: kakaologin.do");
		String member_email = request.getParameter("kakao_email");
		int res = biz.tokenchk(member_email);
		
		if(res<=0) {
			request.setAttribute("kakao_email", member_email);
			
			MemberDto dto = new MemberDto();
			dto.setMember_email(member_email);
			request.setAttribute("dto", dto);
			System.out.println("간편 회원 가입");
			return "member/snsjoinform";
		}else {
			MemberDto Ldto = biz.snslogin(member_email);
			System.out.println("카카오 가입 완료 회원 실행");
			session.setAttribute("Ldto", Ldto);
		}
		return "home";
	}
	
	/*
	@RequestMapping("/kakaologin.do")
	public String kakaoLogin(HttpServletRequest request) {
		logger.info("[Controller]: kakaologin.do");
		String member_email = request.getParameter("kakao_email");
		
		MemberDto Ldto = new MemberDto();
		
		if(Ldto==null) {
			request.setAttribute("member_email", member_email);
			System.out.println("카카오로그인테스트"+member_email);
			
			MemberDto dto = new MemberDto();
			dto.setMember_email(member_email);
			request.setAttribute("memberDto", dto);
			
			return "member/snsjoinform";
		}else{
			System.out.println("카카오 가입 완료 회원 실행");
			Ldto.setMember_email(member_email);
			request.setAttribute("memberDto", Ldto);
		}
		return "home";
	}
	*/
	/*
	@RequestMapping("/snsJoin.do")
	public String snsJoin(HttpServletRequest request) {
		logger.info("[Contoller]: snsJoin.do");
		
		String member_id = request.getParameter("member_id");
		String member_pw = request.getParameter("member_pw");
		String member_email = request.getParameter("member_email");
		String member_age = request.getParameter("member_age");
		String member_gender = request.getParameter("member_gender");
		int sum = Integer.parseInt(member_age);
		
		MemberDto dto = new MemberDto();
		dto.setMember_id(member_id);
		dto.setMember_pw(member_pw);
		dto.setMember_email(member_email);
		dto.setMember_age(sum);
		dto.setMember_gender(member_gender);
		
		int res = biz.join(dto);
		
		if(res > 0) {
			return "member/login";
		}
			return "login.do";
		
	}
	*/
	@ResponseBody
	@RequestMapping(value="/idChk.do")
	public int idCheck(MemberDto dto) {
		logger.info("[Controller]: idChk.do");
		int res = biz.idCheck(dto);
		
		boolean idnotused = true;
		
		if(res > 0) {
			idnotused = false;
		}
		System.out.println(idnotused);
		
		return res;
	}
	
	

	
	

}
