package com.spring.bookduck.bookstar.dao;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.bookstar.dto.BookStarDto;

@Repository
public class BookStarDaoImpl implements BookStarDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public int insertBookStar(BookStarDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "insertBookStar", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}
	/*
	@Override
	public BookStarDto selectOne(String isbn) {
		BookStarDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE + "selectOne", isbn);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return dto;
	}
	*/
	@Override
	public double selectAvg(String isbn) {
		double res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "selectAvg", isbn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	
}
