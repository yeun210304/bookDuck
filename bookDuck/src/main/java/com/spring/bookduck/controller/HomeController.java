package com.spring.bookduck.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.scrap.dto.ScrapDto;

@Controller
public class HomeController {

	@RequestMapping("/goHome.do")
	public String home(ScrapDto scrapDto, Model model) {
		
		model.addAttribute("scrapDto", scrapDto);
		
		return "home";
	}
	
}
