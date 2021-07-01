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
	
	/*
	@RequestMapping("submitForm.do")
	public String select(Model model) {
		List<RealTimeNovelDto> list = biz.select();
		model.addAttribute("list", list);
		return "home";
	}
	*/
	
	@RequestMapping("/insertNovel.do")
	public  String insertNovel(RealTimeNovelDto dto) {
		
		if (biz.insert(dto) > 0) {
			 return "redirect:home.do";
			// return "home";
		}
		return "redirect:home.do";
	}
	
	
	
	/*	
	@RequestMapping("insertContent.do")
	@ResponseBody
	public Map<String, String> insertContent(RealTimeNovelDto dto) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		if (biz.insert(dto) > 0) {
			map.put("success", "success");
		} else {
			map.put("success", "fail");
		}
		
		return map;
	}
	*/
	
}
