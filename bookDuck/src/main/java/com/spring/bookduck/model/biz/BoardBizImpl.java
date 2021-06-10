package com.spring.bookduck.model.biz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.model.dao.BoardDao;
import com.spring.bookduck.model.dto.PostDto;

@Service
public class BoardBizImpl implements BoardBiz {

	@Autowired
	BoardDao dao;
	
	@Override
	public int increaseCount(int post_no) {
		return dao.increaseCount(post_no);
	}

	@Override
	public PostDto selectOne(int post_no) {
		return dao.selectOne(post_no);
	}

	@Override
	public int insertBoard(PostDto dto) {
		return dao.insertBoard(dto);
	}

	@Override
	public int updateBoard(PostDto dto) {
		return dao.updateBoard(dto);
	}

	@Override
	public int deleteBoard(int post_id) {
		return dao.deleteBoard(post_id);
	}

}
