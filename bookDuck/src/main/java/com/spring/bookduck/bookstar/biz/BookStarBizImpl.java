package com.spring.bookduck.bookstar.biz;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.bookstar.dao.BookStarDao;
import com.spring.bookduck.bookstar.dto.BookStarDto;

@Service
public class BookStarBizImpl implements BookStarBiz{

	@Autowired
	BookStarDao dao;
	
	@Override
	public int insertBookStar(BookStarDto dto) {
		return dao.insertBookStar(dto);
	}

	/*
	@Override
	public BookStarDto selectOne(String isbn) {
		return dao.selectOne(isbn);
	}
	*/
	@Override
	public double selectAvg(String isbn) {
		return dao.selectAvg(isbn);
	}

	
	
}
