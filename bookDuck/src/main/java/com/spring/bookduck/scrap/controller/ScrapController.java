package com.spring.bookduck.scrap.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.bookfm.biz.BookFMBiz;
import com.spring.bookduck.bookstar.biz.BookStarBiz;
import com.spring.bookduck.introduce.biz.IntroduceBiz;
import com.spring.bookduck.introduce.dto.IntroduceDto;
import com.spring.bookduck.model.biz.LoginBiz;
import com.spring.bookduck.model.dto.MemberDto;
import com.spring.bookduck.rcvideo.biz.RcvideoBiz;
import com.spring.bookduck.rcvideo.dto.RcvideoDto;
import com.spring.bookduck.scrap.biz.ScrapBiz;
import com.spring.bookduck.scrap.dto.ScrapDto;

@Controller
public class ScrapController {
	
	@Autowired
	private ScrapBiz biz;
	
	@Autowired
	private RcvideoBiz rcbiz;
	
	@Autowired
	private BookStarBiz bookstarbiz;
	
	@Autowired
	private BookFMBiz bookfmbiz;
  
	@Autowired
	private IntroduceBiz ibiz;

	
	@RequestMapping("scinsert.do")
	public String scinsert(HttpSession session, HttpServletRequest request,Model model) {
		
		HttpSession sess = request.getSession();
		
		MemberDto Ldto = (MemberDto) sess.getAttribute("Ldto");
		
		// 로그인 안했을 때
		if(Ldto == null) {
			return "member/login";
		}
		
		Ldto.getMember_id();
		String path = request.getContextPath();
		String title = request.getParameter("title");
		String isbn = request.getParameter("isbn");
		String coverLargeUrl = request.getParameter("coverLargeUrl");
		String author = request.getParameter("author");
		String categoryId = request.getParameter("categoryId");
		System.out.println(Ldto.getMember_id()+title+isbn+coverLargeUrl+author+categoryId);
		
		ScrapDto scdto = new ScrapDto();
		
		scdto.setBook_isbn(isbn);
		scdto.setBook_title(title);
		scdto.setBook_coverLargeUrl(coverLargeUrl);
		scdto.setBook_author(author);
		scdto.setBook_categoryId(categoryId);
		scdto.setScrap_id(Ldto.getMember_id());
		
		biz.scinsert(scdto);
			
		return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole="
		+ Ldto.getMember_payrole();
	}
	@RequestMapping("scselectone.do")
	public String scselectone(HttpSession session, HttpServletRequest request,Model model) {
		
		session = request.getSession();
		MemberDto Ldto = (MemberDto) session.getAttribute("Ldto");
		Ldto.getMember_id();
		
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
		model.addAttribute("scdto",scdto);
		System.out.println(Ldto.getMember_id()+title+isbn+coverLargeUrl+author+categoryId);
		
		List<RcvideoDto> list = rcbiz.rcselectone(isbn);  
		model.addAttribute("rclist",list);
		
		model.addAttribute("staravgg", bookstarbiz.selectAvg(isbn));
		
		model.addAttribute("rowlist", bookfmbiz.selectList(isbn));
		model.addAttribute("scidlist",biz.scidlist(isbn));
		
		return "book/recommendBook";
	}
	
	
	@RequestMapping("scdelete.do")
	public String scdelete(int scrap_no,HttpSession session, HttpServletRequest request,MemberDto Ldto,IntroduceDto indDto,ScrapDto scDto) {
		session = request.getSession();
		
		if(biz.scdelete(scrap_no)>0) {
			return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole="
					+ Ldto.getMember_payrole();
		}
		
		return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole="
		+ Ldto.getMember_payrole()+indDto.getIntd_content()+biz.sclist(Ldto.getMember_id());
	}
	
	@RequestMapping(value ="scalldelete.do")
	public String ajaxdelete(HttpServletRequest request,MemberDto Ldto,IntroduceDto indDto,ScrapDto scDto) {
		
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for(int i = 0 ; i<size ;i++) {
			biz.scalldelete(ajaxMsg[i]);
		}
		
		return "redirect:mypage.do?member_id=" + Ldto.getMember_id() + "&member_payrole="
				+ Ldto.getMember_payrole();
	}
	

}
