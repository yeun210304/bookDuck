package com.spring.bookduck.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.model.biz.BoardBiz;

@Controller
public class NoticeBoardController {

	@Autowired
	BoardBiz boardBiz;
	
	@RequestMapping("/noticeList.do")
	public String noticeList() {
		
		return "board/noticeboardList";
	}
	
	public String noticeDetail(int post_no, Model model) {
		int res = boardBiz.increaseCount(post_no);
		
		if(res > 0) {
			model.addAttribute("dto", boardBiz.selectOne(post_no));
			return "board/noticeboardDetail";
		}
		
		return "";
	}
	
	@RequestMapping("/noticeInsert.do")
	public String noticeInsert() {
		
		return "board/noticeboardInsert";
	}
	
}
