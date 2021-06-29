package com.spring.bookduck.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.model.dto.CommentDto;
import com.spring.bookduck.model.dto.PageInfo;
import com.spring.bookduck.model.dto.PostDto;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount(int board_id) {
		return sqlSession.selectOne(NAMESPACE+"listCount", board_id);
	};
	
	@Override
	public List<PostDto> selectList(PageInfo pi, int board_id){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (List)sqlSession.selectList(NAMESPACE+"selectList", board_id, rowBounds);
	};
	
	@Override
	public int increaseCount(int post_id) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "increaseCount", post_id);
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
			res = sqlSession.insert(NAMESPACE + "insertNotice", dto);
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
			//System.out.println("res : " + res);
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
	
	@Override
	public List<CommentDto> selectCommentList(int post_id){
		List<CommentDto> list = new ArrayList<CommentDto>();

		try {
			list = sqlSession.selectList(NAMESPACE + "selectCommentList", post_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int insertComment(CommentDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "insertComment", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int increaseComment(int post_id) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "increaseComment", post_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int updateComment(CommentDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "updateComment", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return res;
	}

	@Override
	public int deleteComment(int comment_id) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"deleteComment", comment_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int decreaseComment(int post_id) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "decreaseComment", post_id);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int deleteAllComment(int post_id) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "allCommentDelete", post_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<PostDto> selectSearchList(Map<String, String> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (List)sqlSession.selectList(NAMESPACE+"selectSearchList", map, rowBounds);
	}

	@Override
	public int selectSearchListCount(Map<String, String> map) {
		return sqlSession.selectOne(NAMESPACE + "selectSearchCount", map);
	}

	@Override
	public int answerCommentUpdate(int comment_id) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"answerCommentUpdate", comment_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int answerCommentInsert(CommentDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"answerCommentInsert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
