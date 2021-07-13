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
import com.spring.bookduck.scrap.biz.ScrapBiz;
import com.spring.bookduck.bookstar.biz.BookStarBiz;
import com.spring.bookduck.classify.controller.ClassifyAIController;
import com.spring.bookduck.model.dto.MemberDto;
import com.spring.bookduck.rcimg.biz.RcimgBiz;


@Controller
public class BookController {
	
	@Autowired
	ScrapBiz biz;
	
	@Autowired
	BookFMBiz bookfmbiz;
	
	@Autowired
	BookStarBiz bookstarbiz;
	
	@Autowired
	RcvideoBiz rcbiz;
	
	@Autowired
	RcimgBiz imgbiz;
	
	@Autowired
	ScrapBiz scbiz;
	
	private Logger logger = LoggerFactory.getLogger(BookController.class);			
	
	
	@RequestMapping("/booksearch.do")
	public String search() {
		logger.info("[BookController] : booksearch.do");		
		
		return "book/booksearch";
	}
	
	@RequestMapping("/recommendBook.do")
	public String recommend(HttpSession session, HttpServletRequest request, Model model, String isbn) {
		
		logger.info("[BookController] : recommendBook.do");	
		model.addAttribute("rowlist", bookfmbiz.selectList(isbn));
		model.addAttribute("rclist",rcbiz.rclist(isbn));
		model.addAttribute("scidlist",scbiz.scidlist(isbn));
		model.addAttribute("staravgg", bookstarbiz.selectAvg(isbn));
		model.addAttribute("imglist",imgbiz.imglist(isbn));
		model.addAttribute("scidlist",biz.scidlist(isbn));

		// 로그인 안했을 때
		session = request.getSession();
		MemberDto Ldto = (MemberDto) session.getAttribute("Ldto");
		
		if(Ldto == null) {
			return "member/login";
		}
		
		return "book/recommendBook";
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
	
}
