package com.spring.bookduck.rcimg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.bookduck.rcimg.biz.RcimgBiz;
import com.spring.bookduck.rcimg.dto.RcimgDto;


@Controller
public class RcimgController {
	
	@Autowired
	private RcimgBiz biz;
	
	@ResponseBody
	@RequestMapping(value="rcimglist.do", produces = "application/json;")
	public Map<String, List<RcimgDto>> rcimglist(String book_isbn){
		
		List<RcimgDto>list = biz.imglist(book_isbn);
		Map<String, List<RcimgDto>> map = new HashMap<String, List<RcimgDto>>();
		map.put("list", list);
		
		return map;
	}
	@ResponseBody
	@RequestMapping("rcimginsert.do")
	public int rcimginsert(RcimgDto dto) {
		
		if(biz.imginsert(dto)>0) {
			return 1;
		}
		
		
		return 0;
		
	}
	@ResponseBody
	@RequestMapping("rcimgdelete.do")
	public int imgdelete(int rcimg_no) {
		
		if(biz.imgdelete(rcimg_no)>0) {
			
			
			return 1;
		}
		
		return 0;
	}
}