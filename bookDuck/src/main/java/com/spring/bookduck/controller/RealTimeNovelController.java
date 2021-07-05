package com.spring.bookduck.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.model.biz.RealTimeNovelBiz;
import com.spring.bookduck.model.dto.RealTimeNovelDto;

@Controller
public class RealTimeNovelController {

	@Autowired
	private RealTimeNovelBiz biz;
	
	@RequestMapping("/insertNovel.do")
	public  String insertNovel(RealTimeNovelDto dto) {
		
		if (biz.insert(dto) > 0) {
			 return "redirect:home.do";
			// return "home";
		}
		return "redirect:goHome.do";
	}
	
}
