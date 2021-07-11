package com.spring.bookduck.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.bookduck.model.biz.LoginBiz;
import com.spring.bookduck.model.dto.MemberDto;

@Controller
public class LoginController {
	
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginBiz biz;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
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
			if(passwordEncoder.matches(dto.getMember_pw(), res.getMember_pw()))
			session.setAttribute("Ldto", res); //세션 생성
			session.setMaxInactiveInterval(10*60); //세션 시간 설정
			check=true;
		}else {
			logger.info("[Controller]: password failed");
		}
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);
		
		return map;
	}
	
	// 로그아웃
	@RequestMapping(value="/logout.do")
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
	@RequestMapping(value="/idCheck.do")
	public int idCheck(MemberDto dto) {
		logger.info("[Controller]: idCheck.do");
		int res = biz.idCheck(dto);
		return res;
	}
	
	//이메일 중복 체크
	@ResponseBody
	@RequestMapping(value="/emailCheck.do")
	public int emailCheck(MemberDto dto) {
		logger.info("[Controller]: emailCheck.do");
		int res = biz.emailCheck(dto);
		return res;
	}
	
	//가입 완료 버튼 누를 시
	@RequestMapping(value="/reg.do")
	public String Reg(MemberDto dto) {
		logger.info("[Controller] : reg.do");
		
		System.out.println("암호화 전: "+dto.getMember_pw());
		dto.setMember_pw(passwordEncoder.encode(dto.getMember_pw()));
		System.out.println("암호화 후: "+dto.getMember_pw());
		
		if(biz.join(dto)>0) {
			return "redirect:loginform.do";
		}
		return "redirect:joinform.do";
	}
	
	// 비번 변경
	@RequestMapping("/updatePwForm.do")
	public String updatePwForm() {
		logger.info("[Controller] : updatePwForm.do");
		return "member/updatePwForm";
	}
	
	@RequestMapping("/updatePwRes.do")
	public String updatePwRes(MemberDto dto, HttpSession session) throws Exception {
		logger.info("[Controller] : updatePwRes.do");
		MemberDto dto1 = new MemberDto();
		dto1.setMember_pw(passwordEncoder.encode(dto.getMember_pw()));
		dto1.setMember_id(dto.getMember_id());
		if(biz.updatePw(dto1)>0) {
			session.invalidate();
			return "member/login";
		}
		return "member/login";
	}
	
	// 탈퇴
	@RequestMapping("/leaveAccountForm.do")
	public String leaveAccountForm() throws Exception{
		logger.info("[Controller] : leaveAccountForm.do");
		return "member/leaveAccountForm";
	}
	
	@RequestMapping("/leaveAccount.do")
	public String leaveAccount(MemberDto dto, HttpSession session, RedirectAttributes rttr) throws Exception{
		logger.info("[Controller] : leaveAccount.do");
		MemberDto member = (MemberDto) session.getAttribute("dto");
		String sessionPass = member.getMember_pw();
		String dtoPass = dto.getMember_pw();
		
		if(!(sessionPass.equals(dtoPass))) {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/member/leaveAccountForm";
		}
		biz.leaveAccount(dto);
		session.invalidate();
		return "redirect:/";
	}
	
	//아이디 찾기
	@RequestMapping("/findIdForm.do")
	public String findIdForm() {
		logger.info("[Controller]: findIdForm.do");
		return "member/findIdForm";
	}
	
	
	@RequestMapping("/findIdRes.do")
	public String findIdRes(MemberDto dto, Model model) {
		logger.info("[Controller]: findIdRes.do");
		MemberDto member = biz.findId(dto);
		
		if(member == null) {
			model.addAttribute("check", 1);
		}else {
			model.addAttribute("check", 0);
			model.addAttribute("member_id", member.getMember_id());
		}
		
		return "member/findIdForm";
	}
	
	//비밀번호 찾기
	@RequestMapping("/findPwForm.do")
	public String findPwForm() {
		logger.info("[Controller]: findPwForm.do");
		return "member/findPwForm";
	}
	
	//네이버 로그인 테스트
	@RequestMapping("/navertest.do")
	public String NaverTest() {
		logger.info("네이버 로그인 페이지 테스트");
		return "member/naverlogin";
	}
	
	/*
	@Autowired
	private MailSender mailSender;
	@Autowired
	private MailDto mailDto;
			
	@RequestMapping("/sendpw.do")
	public String sendEmailAction (@RequestParam Map<String, Object> paramMap, Model model) throws Exception{
		logger.info("[Controller]: sendpw.do");
		String member_id = (String) paramMap.get("member_id");
		String member_email = (String) paramMap.get("member_email");
		String member_pw = biz.getPw(paramMap);
		System.out.println("비밀번호: "+member_pw);
		
		if(member_pw != null) {
			mailDto.setContent("비밀번호는 "+member_pw+"입니다.");
			mailDto.setReceiver(member_email);
			mailDto.setSubject(member_id+"님의 비밀번호 찾기 메일입니다.");
			mailSender.SendEmail(mailDto);
			return "redirect:/login.do";
		}else {
			return "redirect:/logout.do";
		}
	}
	*/
	
}
