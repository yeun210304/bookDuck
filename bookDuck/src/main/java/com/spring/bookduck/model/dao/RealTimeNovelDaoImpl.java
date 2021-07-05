package com.spring.bookduck.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.model.dto.RealTimeNovelDto;

@Repository
public class RealTimeNovelDaoImpl implements RealTimeNovelDao {

	@Autowired
	private SqlSessionTemplate sqlSession;


	@Override
	public List<RealTimeNovelDto> selectList() {
		
		List<RealTimeNovelDto> RTNovelList = new ArrayList<RealTimeNovelDto>();
		
		try {
			RTNovelList = sqlSession.selectList(NAMESPACE + "selectList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return RTNovelList;
	}
	
	@Override
	public int insert(RealTimeNovelDto dto) {
		int res = 0;

		try {
			res = sqlSession.insert(NAMESPACE + "insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

}
