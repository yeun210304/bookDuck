package com.spring.bookduck.scrap.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.scrap.dto.ScrapDto;

@Repository
public class ScrapDaoImpl implements ScrapDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession; 
	
	@Override
	public List<ScrapDto> sclist(String scrap_id) {
		
		List<ScrapDto> sclist = new ArrayList<ScrapDto>();
		
		try {
			sclist =sqlSession.selectList(namespace+"scselectlist",scrap_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sclist;
	}

	@Override
	public ScrapDto scselectone(int scrap_no) {
		return null;
	}

	@Override
	public int scinsert(ScrapDto dto) {
		
		int res =0;
		try {
			res = sqlSession.insert(namespace+"scinsert",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int scdelete(int scrap_no) {
		
		int res =0;
		try {
			res= sqlSession.delete(namespace+"scdelete",scrap_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public void scalldelete(String scrap_no) {
		
		try {
		  sqlSession.delete(namespace+"scalldelete",scrap_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
