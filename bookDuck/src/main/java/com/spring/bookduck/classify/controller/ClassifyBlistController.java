package com.spring.bookduck.classify.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.classify.biz.BlistBiz;
import com.spring.bookduck.classify.dto.BlistDto;

@Controller
public class ClassifyBlistController {
	
	private Logger logger = LoggerFactory.getLogger(ClassifyBlistController.class);
	
	@Autowired
	private BlistBiz biz;
	
	@RequestMapping("/blist.do")
	public String blist(Model model) {
		
		logger.info("[ClassifyBlistController] : blist.do");	
		
		List<BlistDto> list = new ArrayList<BlistDto>();
		list = biz.totalBlist();
		model.addAttribute("blist", list);
				
		return "/classify/classifyblist";
	}
	
	
	
	

}
