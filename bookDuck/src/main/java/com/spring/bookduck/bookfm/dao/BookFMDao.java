package com.spring.bookduck.bookfm.dao;

import java.util.List;

import com.spring.bookduck.bookfm.dto.BookFMDto;

public interface BookFMDao {

	static String NAMESPACE = "bookfmMapper.";
	
	// 명대사 작성(저장)
	public int insertBookFM(BookFMDto dto);
	
	// 명대사 리스트(조회)
	public List<BookFMDto> selectList(String ISBN);
	
}
