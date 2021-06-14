package com.spring.bookduck.model.dao;

import com.spring.bookduck.model.dto.PostDto;

public interface BoardDao {
	
	static String NAMESPACE = "boardMapper.";
	
	// 게시글 상세조회
	public int increaseCount(int post_id);
	public PostDto selectOne(int post_id);
	
	// 게시글 작성
	public int insertNotice(PostDto dto);
	public int insertQNA(PostDto dto);
	
	// 게시글 수정
	int updateBoard(PostDto dto);
	
	// 게시글 삭제
	int deleteBoard(int post_id);

}
