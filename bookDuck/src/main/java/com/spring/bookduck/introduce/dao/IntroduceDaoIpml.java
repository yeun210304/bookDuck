package com.spring.bookduck.introduce.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.introduce.dto.IntroduceDto;
@Repository
public class IntroduceDaoIpml implements IntroduceDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public IntroduceDto selectoneno(int intd_no) {
		
		IntroduceDto dto = new IntroduceDto();
		
		try {
			dto= sqlSession.selectOne(namespace+"intdselectoneno",intd_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public IntroduceDto selectone(String intd_id) {
		
		IntroduceDto dto = new IntroduceDto();
		
		try {
			dto= sqlSession.selectOne(namespace+"intdselectone",intd_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int insert(IntroduceDto dto) {
		
		int res =0;
		
		try {
			res= sqlSession.insert(namespace+"insertintd",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int update(IntroduceDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(namespace+"updateintd",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int delete(int intd_no) {
		
		int res =0;
		try {
			res = sqlSession.delete(namespace+"deleteintd",intd_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	

}
