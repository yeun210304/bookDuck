package com.spring.bookduck.mypage;

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
import com.spring.bookduck.pay.controller.PayController;
import com.spring.bookduck.pay.dto.PayDto;


@Controller
public class MypageController {
	
	private Logger logger = LoggerFactory.getLogger(PayController.class);
	
	@Autowired
	private IntroduceBiz biz;
	
	@RequestMapping("mypage.do")
	public String mypage(HttpSession session, HttpServletRequest request,MemberDto dto,PayDto paydto,IntroduceDto intdDto,String intd_id,Model model ) {
		

		logger.info("[Controller] mypage.do ");
		
		session= request.getSession();
		model.addAttribute("member_id",dto.getMember_id());
		model.addAttribute("member_payrole",dto.getMember_payrole().equals("Y"));
		model.addAttribute("pay_id", paydto.getPay_id());
		model.addAttribute("intd_id",intdDto.getIntd_id());
		model.addAttribute("intd_id",biz.selectone(intd_id));
		return"mypage";
	}
}
