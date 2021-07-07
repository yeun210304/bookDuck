package com.spring.bookduck.rcimg.biz;

import java.util.List;

import com.spring.bookduck.rcimg.dto.RcimgDto;

public interface RcimgBiz {
	
	public List<RcimgDto> imglist(String book_isbn);
	public RcimgDto imgselectone(int rcimg_no);
	public int imginsert(RcimgDto dto);
	public int imgdelete(int rcimg_no);
	

}
