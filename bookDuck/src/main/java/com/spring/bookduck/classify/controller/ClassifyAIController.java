package com.spring.bookduck.classify.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.bookduck.classify.biz.AireBiz;
import com.spring.bookduck.classify.dto.AireDto;

@Controller
public class ClassifyAIController {
	
	private Logger logger = LoggerFactory.getLogger(ClassifyAIController.class);			
			
	@Autowired
	private AireBiz biz;
	
	@RequestMapping("/ailist.do")
	public String ailist(Model model) {
		
		logger.info("[ClassifyAIController] : ailist.do");		
		
		List<AireDto> list = biz.totalRe();		
		model.addAttribute("airelist", list);	
		
		return "classify/classifyailist";
	}
	
	@RequestMapping("/aifindreone.do")
	public String aifindreone(Model model, HttpServletRequest request) {

		logger.info("[ClassifyAIController] : aifindreone.do");	
		
		/*
		LoginDto ldto = (LoginDto) request.getAttribute("Ldto");
		AireDto aidto = biz.findReOne(ldto.getMember_id());
		model.addAttribute("aidto", aidto);
		*/
		AireDto aidto = biz.findReOne("admin");
		model.addAttribute("aidto", aidto);
		
		
		return "classify/classifyaifindone";
	}
	
	
		
	
	
	
	
	
	
	
	

}
