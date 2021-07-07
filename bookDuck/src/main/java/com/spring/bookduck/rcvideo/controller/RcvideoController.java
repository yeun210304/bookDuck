package com.spring.bookduck.rcvideo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.bookduck.bookfm.biz.BookFMBiz;
import com.spring.bookduck.model.dto.MemberDto;
import com.spring.bookduck.rcvideo.biz.RcvideoBiz;
import com.spring.bookduck.rcvideo.dto.RcvideoDto;
import com.spring.bookduck.scrap.biz.ScrapBiz;
import com.spring.bookduck.scrap.dto.ScrapDto;

@Controller
public class RcvideoController {

	@Autowired
	private RcvideoBiz biz;
	
	@Autowired
	private ScrapBiz scbiz;
	
	@Autowired
	private BookFMBiz bookfmbiz;

	@RequestMapping("rcinsertres.do")
	public String rcinsertres(HttpSession session, HttpServletRequest request,Model model) {
		
		
		String title = request.getParameter("title");
		String isbn = request.getParameter("isbn");
		String coverLargeUrl = request.getParameter("coverLargeUrl");
		String author = request.getParameter("author");
		String categoryId = request.getParameter("categoryId");
		
		ScrapDto scdto = new ScrapDto();
		
		scdto.setBook_isbn(isbn);
		scdto.setBook_title(title);
		scdto.setBook_coverLargeUrl(coverLargeUrl);
		scdto.setBook_author(author);
		scdto.setBook_categoryId(categoryId);
		model.addAttribute("scrapDto",scdto);
		
		return "rcvideo/rcinsertres";
	}
	@RequestMapping("rcinsert.do")
	public String rcinsert(HttpSession session, HttpServletRequest request,RcvideoDto rcdto,Model model) {
		String title = request.getParameter("book_title");
		String isbn = request.getParameter("book_isbn");
		String coverLargeUrl = request.getParameter("book_coverLargeUrl");
		String author = request.getParameter("book_author");
		String categoryId = request.getParameter("book_categoryId");
		
		ScrapDto scdto = new ScrapDto();
		
		scdto.setBook_isbn(isbn);
		scdto.setBook_title(title);
		scdto.setBook_coverLargeUrl(coverLargeUrl);
		scdto.setBook_author(author);
		scdto.setBook_categoryId(categoryId);
		model.addAttribute("scrapDto",scdto);
		System.out.println(title+isbn+coverLargeUrl+author+categoryId);
		if(biz.rcinsert(rcdto)>0) {
			model.addAttribute("rclist",biz.rclist(isbn));
			return "book/recommendBook";
		}
			
		return "redirect";
	}
	
	
	
	
	
	
	
	@RequestMapping("updatercvideores.do")
	public String rcupdateres(HttpSession session, HttpServletRequest request,Model model,int rcvideo_no) {
		session = request.getSession();
		String title = request.getParameter("title");
		String isbn = request.getParameter("isbn");
		String coverLargeUrl = request.getParameter("coverLargeUrl");
		String author = request.getParameter("author");
		String categoryId = request.getParameter("categoryId");
		
		ScrapDto scdto = new ScrapDto();
		
		scdto.setBook_isbn(isbn);
		scdto.setBook_title(title);
		scdto.setBook_coverLargeUrl(coverLargeUrl);
		scdto.setBook_author(author);
		scdto.setBook_categoryId(categoryId);
		model.addAttribute("scrapDto",scdto);
		
		model.addAttribute("rcvideoDto",biz.rcselectoneno(rcvideo_no));
		
		return "rcvideo/rcupdateres";
	}
	
	@RequestMapping("updatercvideo.do")
	public String rcupdate(HttpSession session, HttpServletRequest request,Model model,RcvideoDto rcvideoDto) {
		
		session = request.getSession();
		
		String title = request.getParameter("book_title");
		String isbn = request.getParameter("book_isbn");
		String coverLargeUrl = request.getParameter("book_coverLargeUrl");
		String author = request.getParameter("book_author");
		String categoryId = request.getParameter("book_categoryId");
		
		ScrapDto scdto = new ScrapDto();
		
		scdto.setBook_isbn(isbn);
		scdto.setBook_title(title);
		scdto.setBook_coverLargeUrl(coverLargeUrl);
		scdto.setBook_author(author);
		scdto.setBook_categoryId(categoryId);
		model.addAttribute("scrapDto",scdto);
		System.out.println("여기맞나"+title+isbn+coverLargeUrl+author+categoryId);
		if(biz.rcupdate(rcvideoDto)>0) {
			model.addAttribute("rclist",biz.rclist(isbn));
			return "book/recommendBook";
		}
		
		return "home";
	}
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("deletercvideo.do")
	public String rcdelete(HttpSession session, HttpServletRequest request,Model model,int rcvideo_no) {
		
		if(biz.rcdelete(rcvideo_no)>0) {
			String title = request.getParameter("title");
			String isbn = request.getParameter("isbn");
			String coverLargeUrl = request.getParameter("coverLargeUrl");
			String author = request.getParameter("author");
			String categoryId = request.getParameter("categoryId");
			
			return "redirect:recommendBook.do?title="+title+"&coverLargeUrl="+coverLargeUrl+"&isbn="+isbn+"&author="+author+"&categoryId="+categoryId;
		}
		
		return "home";
	}
	@ResponseBody
	@RequestMapping(value="rcvideolist.do",produces = "application/json;")
	public Map<String, List<RcvideoDto>> rcvideolist(String book_isbn ) {
		
		List<RcvideoDto> list = biz.rclist(book_isbn);
		Map<String, List<RcvideoDto>> map = new HashMap<String, List<RcvideoDto>>(); 
		map.put("list", list);
		
		
		
		return map;
	}
	@ResponseBody
	@RequestMapping("rcvideoinsert.do")
	public int rcvidelinsert(RcvideoDto rcdto) {
		
		if(biz.rcinsert(rcdto)>0) {
			return 1;
		}
		
		
		return 0;
		
	}
	@ResponseBody
	@RequestMapping("deleterc.do")
	public String deleterc(int rcvideo_no) {
		
		if(biz.rcdelete(rcvideo_no)>0) {
			
			
			return "1";
		}
		
		return "0";
	}
}














