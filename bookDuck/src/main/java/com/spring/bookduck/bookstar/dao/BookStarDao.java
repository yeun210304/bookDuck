package com.spring.bookduck.bookstar.dao;


import com.spring.bookduck.bookstar.dto.BookStarDto;

public interface BookStarDao {

	static String NAMESPACE = "bookstarMapper.";
	
	// 별점 등록
	public int insertBookStar(BookStarDto dto);
	
	// 별점 평균(조회)
	//public BookStarDto selectOne(String isbn);
	
	// 별점 평균(연습)
	public double selectAvg(String isbn);
}
