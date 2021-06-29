package com.spring.bookduck.classify.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.model.dto.MemberDto;

@Repository
public class SearchDaoImpl implements SearchDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<MemberDto> idsearch(String member_id) {
		
		List<MemberDto> list = new ArrayList<MemberDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"idsearch", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

}
