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
		
		
		
		return null;
	}

	@Override
	public List<BlistDto> personBlist(String memberId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BlistDto findBOne(String memberId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertBlist(BlistDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateBlist(BlistDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBlist(String memberId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
