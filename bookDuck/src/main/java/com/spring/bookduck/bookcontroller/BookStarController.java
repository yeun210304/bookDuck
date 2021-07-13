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
import com.spring.bookduck.bookstar.biz.BookStarBiz;
import com.spring.bookduck.bookstar.dto.BookStarDto;
import com.spring.bookduck.scrap.biz.ScrapBiz;

@Controller
public class BookStarController {

	@Autowired
	ScrapBiz biz;
	
	@Autowired
	BookStarBiz bookstarbiz;
	
	@Autowired
	BookFMBiz bookfmbiz;
	
	private Logger logger = LoggerFactory.getLogger(BookStarController.class);	

	@RequestMapping("/bookstarInsertRes.do")
	public String BookstarInsertRes(HttpServletRequest request, BookStarDto dto, HttpSession session, Model model) {
		
		logger.info("[BookController] : bookstarInsertRes.do");	
		
		String coverLargeUrl = request.getParameter("coverLargeUrl");
		String title = request.getParameter("title");
		String isbn = request.getParameter("isbn");
		String author = request.getParameter("author");
		String categoryId = request.getParameter("categoryId");
		
		System.out.println(isbn);

		//model.addAttribute("staravg", bookstarbiz.selectOne(isbn));
		model.addAttribute("staravgg", bookstarbiz.selectAvg(isbn));
		model.addAttribute("rowlist", bookfmbiz.selectList(isbn));
		
		if(bookstarbiz.insertBookStar(dto) > 0) {
			model.addAttribute("coverLargeUrl", coverLargeUrl);
			model.addAttribute("title", title);
			model.addAttribute("isbn", isbn);
			model.addAttribute("author", author);
			model.addAttribute("categoryId", categoryId);
			model.addAttribute("scidlist",biz.scidlist(isbn));
			
			//model.addAttribute("staravg", bookstarbiz.selectOne(isbn));
			//System.out.println("실행중??");
			//System.out.println(bookstarbiz.selectOne(isbn));
			
			// 연습
			System.out.println("연습중");
			model.addAttribute("staravgg", bookstarbiz.selectAvg(isbn));
			System.out.println(bookstarbiz.selectAvg(isbn));
			
			model.addAttribute("alertMsg", "성공적으로 저장되었습니다.");
			return "book/recommendBook";
		} else {
			model.addAttribute("errorMsg", "별점 등록 실패");
			return "book/recommendBook";
		}
		
	}
}
