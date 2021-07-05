package com.spring.bookduck.introduce.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.introduce.biz.IntroduceBiz;
import com.spring.bookduck.introduce.dto.IntroduceDto;
import com.spring.bookduck.model.dto.MemberDto;

@Controller
public class IntroduceController {

	@Autowired
	private IntroduceBiz biz;

	@RequestMapping("intdinsertres.do")
	public String intdinsertres(Model model, MemberDto dto) {

		IntroduceDto intdres = biz.selectone(dto.getMember_id());

		model.addAttribute("intdDto", intdres);
		System.out.println(intdres);

		return "introduce/intdinsertres";
	}

	@RequestMapping("intdinsert.do")
	public String intdinsert(HttpSession session, HttpServletRequest request, IntroduceDto intdDto, MemberDto Ldto) {
		session = request.getSession();
		if (biz.insert(intdDto) > 0) {
			System.out.println(Ldto);
			return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole="
					+ Ldto.getMember_payrole();
		}
		return "introduce/intdinsertres";
	}

	@RequestMapping("updateintdres.do")
	public String updateintdres(int intd_no, Model model) {

		model.addAttribute("intdDto", biz.selectoneno(intd_no));

		return "introduce/updateintdres";
	}

	@RequestMapping("updateintd.do")
	public String updateintd(HttpSession session, HttpServletRequest request, IntroduceDto intdDto, MemberDto Ldto) {
		session = request.getSession();
		if (biz.update(intdDto) > 0) {

			return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole="
					+ Ldto.getMember_payrole();
		}

		return "redirect:updateintdres.do?intd_no=" + intdDto.getIntd_no();
	}

	@RequestMapping("deleteintd.do")
	public String deleteintd(int intd_no, MemberDto Ldto) {

		if (biz.delete(intd_no) > 0) {
			return "home";
		}

		return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole=" + Ldto.getMember_payrole();
	}
	
	
	
	

	
}
