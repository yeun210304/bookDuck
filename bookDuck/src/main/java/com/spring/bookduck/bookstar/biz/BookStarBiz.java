package com.spring.bookduck.bookstar.biz;

import com.spring.bookduck.bookstar.dto.BookStarDto;

public interface BookStarBiz {

	static String NAMESPACE = "bookfmMapper.";
	
	// 별점 등록
	public int insertBookStar(BookStarDto dto);
	
	// 별점 평균(조회)
	//public BookStarDto selectOne(String isbn);
	
	// 별점 평균(연습)
	public double selectAvg(String isbn);
}
