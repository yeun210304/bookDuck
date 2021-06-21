package com.spring.bookduck.bookcontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BookController {
	
	@RequestMapping("/booksearch.do")
	public String search() {
		
		return "book/booksearch";
	}
	
	@RequestMapping("/bookrecommend.do")
	public String recommend() {
		
		return "book/bookrecommend";
	}
	
	@RequestMapping("/newBook.do")
	public String newBook() {
		
		return "book/newBook";
	}
	
	@RequestMapping("/bookbest.do")
	public String best() {
		
		return "book/bookbest";
	}
	
}
