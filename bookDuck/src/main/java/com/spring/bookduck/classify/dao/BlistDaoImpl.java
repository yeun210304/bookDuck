package com.spring.bookduck.classify.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.classify.dto.BlistDto;
@Repository
public class BlistDaoImpl implements BlistDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<BlistDto> totalBlist() {
		
		List<BlistDto> list = new ArrayList<BlistDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "totalblist");
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return list;
	}

	@Override
	public List<BlistDto> personBlist(String member_id) {
		
		List<BlistDto> list = new ArrayList<BlistDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "personblist", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public BlistDto findBOne(String member_id) {
		
		BlistDto dto = new BlistDto();
		
		try {
			dto = sqlSession.selectOne(NAMESPACE + "findbone", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int insertBlist(BlistDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "insertblist", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int updateBlist(BlistDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "updateblist", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return res;
	}

	@Override
	public int deleteBlist(String member_id) {
		
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE + "deleteblist", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
