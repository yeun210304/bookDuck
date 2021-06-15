package com.spring.bookduck.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.bookduck.Pagination;
import com.spring.bookduck.model.biz.BoardBiz;
import com.spring.bookduck.model.dto.CommentDto;
import com.spring.bookduck.model.dto.PageInfo;
import com.spring.bookduck.model.dto.PostDto;

@Controller
public class QNABoardController {

	@Autowired
	BoardBiz boardBiz;
	
	@RequestMapping("/qnaList.do")
	public String qnaList(@RequestParam(value="currentPage", defaultValue="1") int currentPage, Model model) {
		int listCount = boardBiz.selectListCount(1);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		List<PostDto> list = boardBiz.selectList(pi, 1);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		return "board/qnaboardList";
	}
	
	@RequestMapping("/qnaDetail.do")
	public String qnaDetail(int post_id, Model model) {

		if(boardBiz.increaseCount(post_id) > 0) {
			model.addAttribute("dto", boardBiz.selectOne(post_id));
			return "board/qnaboardDetail";
		} else {
			model.addAttribute("errorMsg", "게시글 상세조회 실패");
			return "board/errorPage";
		}
	}
	
	@RequestMapping("/qnaInsertForm.do")
	public String qnaInsert() {
		
		return "board/qnaboardInsert";
	}
	
	@RequestMapping("/qnaInsertRes.do")
	public String qnaInsertRes(PostDto dto, MultipartFile mpfile, HttpSession session, Model model) {
		if(!mpfile.getOriginalFilename().equals("")) {
			String changeName = saveFile(session, mpfile);
			
			dto.setOriginName(mpfile.getOriginalFilename());
			dto.setChangeName("resources/uploadFiles/" + changeName);
		}
		
		if(boardBiz.insertQNA(dto) > 0) {
			session.setAttribute("alertMsg", "성공적으로 게시글 작성되었습니다.");
			return "redirect:qnaList.do";
		} else {
			model.addAttribute("errorMsg", "게시글 작성 실패");
			return "board/errorPage";
		}
	}
	
	// 전달받은 첨부파일 수정명 작업해서 서버에 업로드 시킨 후 해당 수정된파일명(서버에 업로된파일명)을 반환하는 메소드
	public String saveFile(HttpSession session, MultipartFile mpfile) {
		
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		
		File storage = new File(savePath);
		
		if(!storage.exists()) {
			storage.mkdirs();
		}
		
		String originName = mpfile.getOriginalFilename();  // 원본명 ("aaa.jpg")
			
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int)(Math.random() * 900000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));
			
		String changeName = currentTime + ranNum + ext;
		
		try {
			mpfile.transferTo(new File(savePath + changeName));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return changeName;
		}
	
	@RequestMapping("/qnaUpdateForm.do")
	public String updateForm(int post_id, Model model) {
		model.addAttribute("dto", boardBiz.selectOne(post_id)); 
		
		return "board/qnaboardUpdate";
	}
	
	@RequestMapping("/qnaUpdateRes.do")
	public String updateRes(PostDto dto, MultipartFile reupfile, HttpSession session, Model model) {
		if(!reupfile.getOriginalFilename().equals("")) {
			if(dto.getChangeName() != null) {
				new File(session.getServletContext().getRealPath(dto.getChangeName())).delete();
			}
			
			String changeName = saveFile(session, reupfile);
			dto.setOriginName(reupfile.getOriginalFilename());
			dto.setChangeName("resources/uploadFiles/" + changeName);
		}
		
		if(boardBiz.updateBoard(dto) > 0) {
			session.setAttribute("alertMsg", "게시글이 성공적으로 수정되었습니다.");
			return "redirect:qnaDetail.do?post_id="+dto.getPost_id();
		} else {
			model.addAttribute("errorMsg", "게시글 수정 실패");
			return "board/errorPage";
		}
	}
	
	@RequestMapping("/qnaDelete.do")
	public String qnaDelete(int post_id, String filePath, HttpSession session, Model model) {
		if(boardBiz.deleteBoard(post_id) > 0) {
			if(!filePath.equals("")) {
				new File(session.getServletContext().getRealPath(filePath)).delete();
			}
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			return "redirect:qnaList.do";
		} else {
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			return "board/errorPage";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/commentList.do", produces="application/json; charset=utf-8")
	public Map<String, List<CommentDto>> ajaxSelectCommentList(int post_id) {
		List<CommentDto> list = boardBiz.selectCommentList(post_id);
		Map<String, List<CommentDto>> map = new HashMap<String, List<CommentDto>>();
		map.put("list", list);
		
		return map; 
	}
	
	@ResponseBody
	@RequestMapping("/commentInsert.do")
	public String ajaxInsertComment(@RequestBody CommentDto dto) {
		if(boardBiz.insertComment(dto) > 0) {
			boardBiz.increaseComment(dto.getPost_id());
			return "success";
		} else {
			return "fail";
		}
	}
	
}
