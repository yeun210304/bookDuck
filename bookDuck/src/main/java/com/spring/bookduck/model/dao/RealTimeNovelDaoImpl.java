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
	public List<RealTimeNovelDto> select() {
		
		List<RealTimeNovelDto> list = new ArrayList<RealTimeNovelDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "list");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public int insert(RealTimeNovelDto dto) {
		int res = 0;
		System.out.println("dao.content : " + dto.getNovel_content());
		System.out.println("dao.id : " + dto.getNovel_id());
		System.out.println("dao.no : " + dto.getNovel_no());
		System.out.println("dao.regdate : " + dto.getNovel_regdate());

		try {
			res = sqlSession.insert(NAMESPACE + "insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}


}
