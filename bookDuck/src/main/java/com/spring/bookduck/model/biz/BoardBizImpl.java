package com.spring.bookduck.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.model.dao.BoardDao;
import com.spring.bookduck.model.dto.CommentDto;
import com.spring.bookduck.model.dto.PageInfo;
import com.spring.bookduck.model.dto.PostDto;

@Service
public class BoardBizImpl implements BoardBiz {

	@Autowired
	BoardDao dao;
	
	@Override
	public int selectListCount(int board_id) {
		return dao.selectListCount(board_id);
	}

	@Override
	public List<PostDto> selectList(PageInfo pi, int board_id) {
		return dao.selectList(pi, board_id);
	}
	
	@Override
	public int increaseCount(int post_id) {
		return dao.increaseCount(post_id);
	}

	@Override
	public PostDto selectOne(int post_id) {
		return dao.selectOne(post_id);
	}

	@Override
	public int insertNotice(PostDto dto) {
		
		return dao.insertNotice(dto);
	}
	
	@Override
	public int insertQNA(PostDto dto) {
		return dao.insertQNA(dto);
	}

	@Override
	public int updateBoard(PostDto dto) {
		return dao.updateBoard(dto);
	}

	@Override
	public int deleteBoard(int post_id) {
		return dao.deleteBoard(post_id);
	}

	@Override
	public List<CommentDto> selectCommentList(int post_id) {
		return dao.selectCommentList(post_id);
	}

	@Override
	public int insertComment(CommentDto dto) {
		return dao.insertComment(dto);
	}

	@Override
	public int increaseComment(int post_id) {
		return dao.increaseComment(post_id);
	}
	
}
