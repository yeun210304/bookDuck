package com.spring.bookduck.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
			model.addAttribute("commentDto", boardBiz.selectCommentList(post_id));
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
	
	@RequestMapping("/imageUpload.do")
	public void imageUpload(MultipartFile mpfile, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 업로드할 폴더 경로
		String savePath = request.getSession().getServletContext().getRealPath("/resources/uploadImages/");

		// 업로드할 파일 이름
		String originName = mpfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int)(Math.random() * 900000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));
			
		String changeName = currentTime + ranNum + ext;

		//System.out.println("원본 파일명 : " + originName);
		//System.out.println("저장할 파일명 : " + changeName);

		String filepath = savePath + changeName;
		System.out.println("파일경로 : " + filepath);

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		mpfile.transferTo(f);
		out.println("/resources/uploadImages/"+changeName);
		out.close();
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
	
	
	// 댓글 관련
	// 댓글 리스트
	@ResponseBody
	@RequestMapping(value="/commentList.do", produces = "application/json;")
	public Map<String, List<CommentDto>> ajaxSelectCommentList(int post_id) {
		List<CommentDto> list = boardBiz.selectCommentList(post_id);
		Map<String, List<CommentDto>> map = new HashMap<String, List<CommentDto>>();
		map.put("list", list);
		
		return map; 
	}
	
	// 댓글 등록
	@ResponseBody
	@RequestMapping("/commentInsert.do")
	public String ajaxInsertComment(CommentDto dto) {
		if(boardBiz.insertComment(dto) > 0) {
			boardBiz.increaseComment(dto.getPost_id());
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 댓글 수정
	@ResponseBody
	@RequestMapping("/commentUpdate.do")
	public String ajaxUpdateComment(CommentDto dto) {
		if(boardBiz.updateComment(dto) > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping("/commentDelete.do")
	public String ajaxDeleteComment(int comment_id, int post_id) {
		if(boardBiz.deleteComment(comment_id) > 0) {
			boardBiz.decreaseComment(post_id);
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 대댓글 작성
	@ResponseBody
	@RequestMapping("/commentAnswerInsert.do")
	public String ajaxAnswerComment(CommentDto dto) {
		if(boardBiz.answerCommentInsert(dto) > 0) {
			boardBiz.increaseComment(dto.getPost_id());
			return "success";
		}
		
		return "fail";
	}
	
	// 게시글 검색 조회
	@RequestMapping("/qnaSearch.do")
	public String qnaSearchList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
								@RequestParam("condition") String condition,
								@RequestParam("keyword") String keyword,
								@RequestParam("category") String category,
								Model model) {
		System.out.println("category : " + category);
		Map<String, String> map = new HashMap<String, String>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("category", category);
		map.put("board_id", "1");
		
		int listCount = boardBiz.selectSearchListCount(map);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		List<PostDto> list = boardBiz.selectSearchList(map, pi);
		
		model.addAttribute("map", map);
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		return "board/qnaboardList";
	}
}
