package com.spring.bookduck.bookcontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BookController {
	
	@RequestMapping("/booksearch.do")
	public String search() {
		
		return "book/booksearch";
	}
	
	@RequestMapping("/recommendBook.do")
	public String recommend() {
		
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
	
}
