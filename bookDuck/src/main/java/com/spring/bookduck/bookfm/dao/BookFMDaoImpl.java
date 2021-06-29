package com.spring.bookduck.bookfm.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.bookfm.dto.BookFMDto;
import com.spring.bookduck.model.dto.PostDto;

@Repository
public class BookFMDaoImpl implements BookFMDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertBookFM(BookFMDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "insertBookFM", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public List<BookFMDto> selectList(String ISBN) {
		
		List<BookFMDto> list = null;
		
		try {
			list = sqlSession.selectList(NAMESPACE + "selectList", ISBN);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return list;
	}

}
