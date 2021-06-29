package com.spring.bookduck.bookfm.biz;

import java.util.List;

import com.spring.bookduck.bookfm.dto.BookFMDto;

public interface BookFMBiz {
	
	static String NAMESPACE = "bookfmMapper.";
	
	// 명대사 작성(저장)
	public int insertBookFM(BookFMDto dto);
		
	// 명대사 리스트(조회)
	public List<BookFMDto> selectList(String ISBN);

}
