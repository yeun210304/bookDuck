package com.spring.bookduck.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.model.dto.PostDto;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public int increaseCount(int post_no) {
		return 0;
	}

	@Override
	public PostDto selectOne(int post_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertBoard(PostDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateBoard(PostDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBoard(int post_id) {
		// TODO Auto-generated method stub
		return 0;
	}

}
