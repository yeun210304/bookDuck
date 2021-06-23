package com.spring.bookduck.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.bookduck.introduce.biz.IntroduceBiz;
import com.spring.bookduck.introduce.dto.IntroduceDto;
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
	public Map<String, Boolean> ajaxLogin(HttpSession session, @RequestBody MemberDto dto ){
		
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
	
	// 로그아웃
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
	
	// 비번 변경
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
	
	// 탈퇴
	@RequestMapping("/leaveAccountForm.do")
	public String leaveAccountForm() throws Exception{
		logger.info("[Controller] : leaveAccountForm.do");
		return "member/leaveAccountForm";
	}
	
	@RequestMapping("/leaveAccount.do")
	public String leaveAccount(MemberDto dto, HttpSession session, RedirectAttributes rttr) throws Exception{
		logger.info("[Controller] : leaveAccount.do");
		MemberDto member = (MemberDto) session.getAttribute("Ldto");
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
		
		return "member/login";
	}
	
	
	
	//비밀번호 찾기
	@RequestMapping("/findPwForm.do")
	public String findPwForm() {
		logger.info("[Controller]: findPwForm.do");
		return "member/findPwForm";
	}
	
}
