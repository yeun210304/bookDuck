package com.spring.bookduck.bookcontroller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.api.client.http.HttpRequest;
import com.spring.bookduck.bookfm.biz.BookFMBiz;
import com.spring.bookduck.bookfm.dto.BookFMDto;

@Controller
public class BooKFMController {
	
	@Autowired
	BookFMBiz bookfmbiz;

	@RequestMapping("/bookfmInsertRes.do")
	public String BookfmInsertRes(HttpServletRequest request, BookFMDto dto, HttpSession session, Model model) {
		
		String coverLargeUrl = request.getParameter("coverLargeUrl");
		String title = request.getParameter("title");
		String isbn = request.getParameter("isbn");
		String author = request.getParameter("author");
		String categoryId = request.getParameter("categoryId");
		
		if(bookfmbiz.insertBookFM(dto) > 0) {
			model.addAttribute("coverLargeUrl", coverLargeUrl);
			model.addAttribute("title", title);
			model.addAttribute("isbn", isbn);
			model.addAttribute("author", author);
			model.addAttribute("categoryId", categoryId);
			
			model.addAttribute("rowlist", bookfmbiz.selectList(isbn));
			
			
			model.addAttribute("alertMsg", "성공적으로 저장되었습니다.");
			//return "book/booksearch";
			//return "redirect:recommendBook.do?title=<%=title %>&coverLargeUrl=<%=coverLargeUrl %>&isbn=<%=isbn %>&author=<%=author %>&categoryId=<%=categoryId %>";
			return "book/recommendBook";
		} else {
			model.addAttribute("errorMsg", "한줄낭독 등록 실패");
			return "book/recommendBook";
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
