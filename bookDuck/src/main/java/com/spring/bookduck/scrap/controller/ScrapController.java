package com.spring.bookduck.scrap.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.introduce.dto.IntroduceDto;
import com.spring.bookduck.model.dto.MemberDto;
import com.spring.bookduck.scrap.biz.ScrapBiz;
import com.spring.bookduck.scrap.dto.ScrapDto;

@Controller
public class ScrapController {
	
	@Autowired
	private ScrapBiz biz;
	
	
	
	
	@RequestMapping("scdelete.do")
	public String scdelete(int scrap_no,HttpSession session, HttpServletRequest request,MemberDto Ldto,IntroduceDto indDto,ScrapDto scDto) {
		session = request.getSession();
		
		if(biz.scdelete(scrap_no)>0) {
			return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole="
					+ Ldto.getMember_payrole();
		}
		
		return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole="
		+ Ldto.getMember_payrole()+indDto.getIntd_content()+biz.sclist(Ldto.getMember_id());
	}
	
	@RequestMapping(value ="scalldelete.do")
	public String ajaxdelete(HttpServletRequest request,MemberDto Ldto,IntroduceDto indDto,ScrapDto scDto) {
		
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for(int i = 0 ; i<size ;i++) {
			biz.scalldelete(ajaxMsg[i]);
		}
		
		return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole="
				+ Ldto.getMember_payrole();
	}
	

}
