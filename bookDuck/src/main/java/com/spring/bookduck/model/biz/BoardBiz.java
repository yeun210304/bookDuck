package com.spring.bookduck.model.biz;

import com.spring.bookduck.model.dto.PostDto;

public interface BoardBiz {

	// 게시글 상세조회
	public int increaseCount(int post_no);
	public PostDto selectOne(int post_no);
	
	// 게시글 작성
	int insertBoard(PostDto dto);
	
	// 게시글 수정
	int updateBoard(PostDto dto);
	
	// 게시글 삭제
	int deleteBoard(int post_id);
	

}
