package com.spring.bookduck.bookcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.bookfm.biz.BookFMBiz;
import com.spring.bookduck.rcvideo.biz.RcvideoBiz;

@Controller
public class BookController {
	
	@Autowired
	BookFMBiz bookfmbiz;
	
	@Autowired
	RcvideoBiz rcbiz;
	
	@RequestMapping("/booksearch.do")
	public String search() {
		
		return "book/booksearch";
	}
	
	@RequestMapping("/recommendBook.do")
	public String recommend(Model model, String isbn) {
		
		model.addAttribute("rowlist", bookfmbiz.selectList(isbn));
		model.addAttribute("rclist",rcbiz.rcselectone(isbn));
		
		return "book/recommendBook";
	}
	
	@RequestMapping("/newBook.do")
	public String newBook() {
		
		return "book/newBook";
	}
	
	@RequestMapping("/bookbest.do")
	public String best() {
		
		return "book/bookbest";
	}
	
	@RequestMapping("/darkmode.do")
	public String darkmode() {
		
		return "book/darkmode";
	}
	
	@RequestMapping("/inbooklist.do")
	public String inbooklist() {
		
		return "book/inbooklist";
	}
	
	@RequestMapping("/outbooklist.do")
	public String outbooklist() {
		
		return "book/outbooklist";
	}
	
	@RequestMapping("/101소설.do")
	public String novel() {
		
		return "book/101소설";
	}
	
	@RequestMapping("/102시에세이.do")
	public String poem() {
		
		return "book/102시에세이";
	}
	
	@RequestMapping("/tts.do")
	public String tts() {
		
		return "book/tts";
	}
	
	@RequestMapping("/ttsPrac.do")
	public String ttsPrac() {
		
		return "book/ttsPrac";
	}
	
}
