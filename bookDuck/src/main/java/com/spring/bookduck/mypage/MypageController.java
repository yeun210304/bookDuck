package com.spring.bookduck.mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.introduce.biz.IntroduceBiz;
import com.spring.bookduck.introduce.dto.IntroduceDto;
import com.spring.bookduck.model.dto.MemberDto;
import com.spring.bookduck.model.dto.RealTimeNovelDto;
import com.spring.bookduck.pay.controller.PayController;
import com.spring.bookduck.pay.dto.PayDto;
import com.spring.bookduck.scrap.biz.ScrapBiz;
import com.spring.bookduck.scrap.dto.ScrapDto;


@Controller
public class MypageController {
	
	private Logger logger = LoggerFactory.getLogger(PayController.class);
	
	@Autowired
	private IntroduceBiz biz;
	
	@Autowired
	private ScrapBiz scbiz;
	
	@RequestMapping("mypage.do")
	public String mypage(HttpSession session, HttpServletRequest request,MemberDto dto,Model model ) {
		

		logger.info("[Controller] mypage.do ");
		session= request.getSession();
		model.addAttribute("member_id",dto.getMember_id());
		model.addAttribute("member_payrole",dto.getMember_payrole());
	 	IntroduceDto intdres = biz.selectone(dto.getMember_id());
		model.addAttribute("intdDto",intdres);
		List<ScrapDto> scrapres = scbiz.sclist(dto.getMember_id());
		model.addAttribute("sclist",scrapres);
		return "mypage";
	}
	@RequestMapping("home.do")
	public String home(HttpSession session, HttpServletRequest request, RealTimeNovelDto dto) {
		session= request.getSession();
		session.setAttribute("RealTimeNovelDto", dto);
		
		return"home";
	}
}
