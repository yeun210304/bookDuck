package com.spring.bookduck.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.bookduck.model.biz.LoginBiz;
import com.spring.bookduck.model.dto.MemberDto;

@Controller
public class LoginController {
	
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginBiz biz;
	
	//로그인
	@RequestMapping("/loginform.do")
	public String loginForm() {
		logger.info("[Controller] : loginform.do");
		return "member/login";
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> ajaxLogin(HttpSession session, @RequestBody MemberDto dto){
		
		logger.info("[Controller] : login.do");
		MemberDto res = biz.login(dto);
		boolean check = false;
		if(res !=null) {

			session.setAttribute("Ldto", res); //세션 생성
			session.setMaxInactiveInterval(10*60); //세션 시간 설정

			check=true;
		}
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);
		
		return map;
	}
	
	@RequestMapping(value="/logout.do", method=RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		return "redirect:/";
	}
	
	//회원가입 form 이동
	@RequestMapping("/joinform.do")
	public String JoinForm() {
		logger.info("[Controller] : joinform.do");
		return "member/joinform";
	}

	//아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="/idCheck.do", method=RequestMethod.POST)
	public int idCheck(MemberDto dto) {
		logger.info("[Controller]: idCheck.do");
		int res = biz.idCheck(dto);
		return res;
	}
	
	//가입 완료 버튼 누를 시
	@RequestMapping(value="/reg.do", method=RequestMethod.POST)
	public String Reg(MemberDto dto) {
		logger.info("[Controller] : reg.do");
		if(biz.join(dto)>0) {
			return "redirect:loginform.do";
		}
		return "redirect:joinform.do";
	}
	
	@RequestMapping("/updatePwForm.do")
	public String updatePwForm() {
		logger.info("[Controller] : updatePwForm.do");
		return "member/updatePwForm";
	}
	
	@RequestMapping("/updatePwRes.do")
	public String updatePwRes(MemberDto dto, HttpSession session) throws Exception {
		logger.info("[Controller] : updatePwRes.do");
		if(biz.updatePw(dto)>0) {
			session.invalidate();
			return "member/login";
		}
		return "member/login";
	}
	
	
	
}
