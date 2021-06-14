package com.spring.bookduck.classify.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.classify.dto.AireDto;
@Repository
public class AireDaoImpl implements AireDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<AireDto> totalRe() {
		
		List<AireDto> list = new ArrayList<AireDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "totalre");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public AireDto findReOne(String member_id) {
		
		AireDto dto = new AireDto();
		
		try {
			dto = sqlSession.selectOne(NAMESPACE+"findreone", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return dto;
	}

	@Override
	public int insertRe(AireDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insertre", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int updateRe(AireDto dto) {

		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"updatere", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int deleteRe(String member_id) {
		
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"deletere", member_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return res;
	}

}
