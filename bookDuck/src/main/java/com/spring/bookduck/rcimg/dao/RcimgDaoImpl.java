package com.spring.bookduck.rcimg.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.rcimg.dto.RcimgDto;

@Repository
public class RcimgDaoImpl implements RcimgDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<RcimgDto> imglist(String book_isbn) {
		List<RcimgDto> list = new ArrayList<RcimgDto>();
		
		try {
			list = sqlSession.selectList(namespace+"imglist",book_isbn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return list;
	}

	@Override
	public RcimgDto imgselectone(int rcimg_no) {
		
		RcimgDto dto= new RcimgDto();
		
		try {
			dto =sqlSession.selectOne(namespace+"imgselectone",rcimg_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int imginsert(RcimgDto dto) {
		
		int res =0;
		
		try {
			res =sqlSession.insert(namespace+"imginsert",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int imgdelete(int rcimg_no) {
		
		int res = 0;
		
		try {
			res = sqlSession.delete(namespace+"imgdelete",rcimg_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
