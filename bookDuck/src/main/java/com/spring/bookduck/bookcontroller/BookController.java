package com.spring.bookduck.bookcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.bookfm.biz.BookFMBiz;
import com.spring.bookduck.bookstar.biz.BookStarBiz;

@Controller
public class BookController {
	
	@Autowired
	BookFMBiz bookfmbiz;
	BookStarBiz bookstarbiz;
	
	@RequestMapping("/booksearch.do")
	public String search() {
		
		return "book/booksearch";
	}
	
	@RequestMapping("/recommendBook.do")
	public String recommend(Model model, String isbn) {
		
		model.addAttribute("rowlist", bookfmbiz.selectList(isbn));
		//model.addAttribute("staravg", bookstarbiz.selectOne(isbn));
		
		
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
	
	
}
