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
import com.spring.bookduck.model.dto.ReadingChartDto;
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
	public String mypage(HttpSession session, HttpServletRequest request,MemberDto Ldto, String member_id, ReadingChartDto RCdto, Model model ) {

		logger.info("[Controller] mypage.do ");
		session= request.getSession();
		model.addAttribute("Ldto", Ldto);
		model.addAttribute("member_id",Ldto.getMember_id());
		model.addAttribute("member_payrole",Ldto.getMember_payrole());
	 	IntroduceDto intdres = biz.selectone(Ldto.getMember_id());
		model.addAttribute("intdDto",intdres);
		List<ScrapDto> scrapres = scbiz.sclist(Ldto.getMember_id());
		model.addAttribute("sclist",scrapres);
		model.addAttribute("RCdto", RCdto);
		
		HttpSession msession = request.getSession(); 
		MemberDto mdto = (MemberDto) msession.getAttribute("Ldto");
		
		System.out.println("mdto.getMember_id : " + mdto.getMember_id());
		System.out.println("memberid : " + member_id);
		
		
		if(mdto.getMember_id().equals(member_id)) {
			model.addAttribute("memberChk", "yes");
		} else {
			model.addAttribute("memberChk", "no");
		}

		return "mypage";
	}
	@RequestMapping("home.do")
	public String home(HttpSession session, HttpServletRequest request) {
		session= request.getSession();
		
		return"home";
	}
}
