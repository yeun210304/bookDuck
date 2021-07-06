package com.spring.bookduck.bookcontroller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.bookfm.biz.BookFMBiz;
import com.spring.bookduck.rcvideo.biz.RcvideoBiz;
import com.spring.bookduck.bookstar.biz.BookStarBiz;
import com.spring.bookduck.classify.controller.ClassifyAIController;
import com.spring.bookduck.model.dto.MemberDto;


@Controller
public class BookController {
	
	@Autowired
	BookFMBiz bookfmbiz;
	
	@Autowired
	BookStarBiz bookstarbiz;
	
	@Autowired
	RcvideoBiz rcbiz;
	
	private Logger logger = LoggerFactory.getLogger(BookController.class);			
	
	
	@RequestMapping("/booksearch.do")
	public String search() {
		logger.info("[BookController] : booksearch.do");		
		
		return "book/booksearch";
	}
	
	@RequestMapping("/booksearch5.do")
	public String search5() {
		logger.info("[BookController] : booksearch.do");		
		
		return "book/booksearch5";
	}
	
	
	@RequestMapping("/recommendBook.do")
	public String recommend(HttpSession session, HttpServletRequest request, Model model, String isbn) {
		
		logger.info("[BookController] : recommendBook.do");	
		model.addAttribute("rowlist", bookfmbiz.selectList(isbn));
		model.addAttribute("rclist",rcbiz.rcselectone(isbn));
    
		model.addAttribute("staravgg", bookstarbiz.selectAvg(isbn));

		// 로그인 안했을 때
		session = request.getSession();
		MemberDto Ldto = (MemberDto) session.getAttribute("Ldto");
		
		if(Ldto == null) {
			return "member/login";
		}
		
		return "book/recommendBook";
	}
	
	@RequestMapping("/recommendBook2.do")
	public String recommend2(HttpSession session, HttpServletRequest request, Model model, String isbn) {
		
		logger.info("[BookController] : recommendBook.do");	
		model.addAttribute("rowlist", bookfmbiz.selectList(isbn));
		model.addAttribute("rclist",rcbiz.rcselectone(isbn));
    
		model.addAttribute("staravgg", bookstarbiz.selectAvg(isbn));

		// 로그인 안했을 때
		session = request.getSession();
		MemberDto Ldto = (MemberDto) session.getAttribute("Ldto");
		
		if(Ldto == null) {
			return "member/login";
		}
		
		return "book/recommendBook2";
	}
	
	@RequestMapping("/newBook.do")
	public String newBook() {
		
		logger.info("[BookController] : newBook.do");	
		return "book/newBook";
	}
	
	@RequestMapping("/bookbest.do")
	public String best() {
		
		logger.info("[BookController] : bookbest.do");	
		return "book/bookbest";
	}
	
	
	// 여기서부턴 연습 
	@RequestMapping("/searchcss.do")
	public String searchcss() {
		
		return "book/searchcss";
	}
	
	@RequestMapping("/cssprac.do")
	public String cssprac() {
		
		return "book/cssprac";
	}
	
	@RequestMapping("/booksearchprac.do")
	public String searchprac() {
		
		return "book/booksearchprac";
	}
	
	@RequestMapping("/booksearchprac2.do")
	public String searchprac2() {
		
		return "book/booksearchprac2";
	}
	
	
	@RequestMapping("/headerprac.do")
	public String headerprac() {
		
		return "book/headerprac";
	}
	
	@RequestMapping("/cssprac3.do")
	public String cssprac3() {
		
		return "book/cssprac3";
	}
	
	@RequestMapping("/cssprac4.do")
	public String cssprac4() {
		
		return "book/cssprac4";
	}
	
}
