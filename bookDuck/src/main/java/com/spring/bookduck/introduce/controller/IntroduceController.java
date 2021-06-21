package com.spring.bookduck.introduce.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.introduce.biz.IntroduceBiz;
import com.spring.bookduck.introduce.dto.IntroduceDto;

@Controller
public class IntroduceController {
	
	@Autowired
	private IntroduceBiz biz;
	
	@RequestMapping("intdinsertres.do")
	public String intdinsertres(Model model, IntroduceDto intdDto) {
		
		
		
		model.addAttribute("intdDto",intdDto);
		
		
		return "introduce/intdinsertres";
	}
	@RequestMapping("intdinsert.do")
	public String intdinsert(IntroduceDto dto) {
		if(biz.insert(dto)>0) {
			return "redirect:mypage.do";
		}
		return "introduce/intdinsertres";
	}
	

}
