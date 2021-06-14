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
	public int increaseCount(int post_id) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "increseCount", post_id);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public PostDto selectOne(int post_id) {
		PostDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE + "selectOne", post_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return dto;
	}

	@Override
	public int insertNotice(PostDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "insertNotcie", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}
	
	@Override
	public int insertQNA(PostDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "insertQNA", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int updateBoard(PostDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "updateBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int deleteBoard(int post_id) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "deleteBoard", post_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
