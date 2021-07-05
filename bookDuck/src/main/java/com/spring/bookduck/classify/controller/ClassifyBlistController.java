package com.spring.bookduck.classify.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@RequestMapping("/blistinsert.do")
	@ResponseBody
	public Map<String, Integer> blistinsert(String blist_from, String blist_to, String blist_contents){
		
		BlistDto dto = new BlistDto();
		dto.setBlacklist_from(blist_from);
		dto.setBlacklist_to(blist_to);
		dto.setBlacklist_contents(blist_contents);
		
		logger.info("[ClassifyBlistController]/blistinsert.do : blist_from = " + blist_from);
		logger.info("[ClassifyBlistController]/blistinsert.do : blist_to = " + blist_to);
		logger.info("[ClassifyBlistController]/blistinsert.do : blist_contents = " + blist_contents);
		
		int res = biz.insertBlist(dto);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		if(res > 0) {
			logger.info("[ClassifyBlistController]/blistinsert.do : 인서트 성공");
			map.put("list", res);
		} else {
			logger.info("[ClassifyBlistController]/blistinsert.do : 인서트 실패");
			map.put("list", null);
		}
		
		return map;
	}
	
	
	
	

}
