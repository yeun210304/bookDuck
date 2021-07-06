package com.spring.bookduck.rcvideo.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.rcvideo.dto.RcvideoDto;
@Repository
public class RcvideoDaoImpl implements RcvideoDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<RcvideoDto>rcselectone(String rcvideo_isbn) {
		List<RcvideoDto> list = new ArrayList<RcvideoDto>();
		
		
		try {
			list=sqlSession.selectList(namespace+"rcselectone",rcvideo_isbn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(list);
		
		return list;
	}
	@Override
	public RcvideoDto rcselectoneno(int rcvideo_no){
		RcvideoDto rcdto = new RcvideoDto();
		
		rcdto = sqlSession.selectOne(namespace+"rcselectoneno",rcvideo_no);
		
		return rcdto;
	}

	@Override
	public int rcinsert(RcvideoDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.insert(namespace+"rcinsert",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int rcupdate(RcvideoDto dto) {
		
		int res =0;
		
		try {
			res= sqlSession.update(namespace+"rcupdate",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int rcdelete(int rcvideo_no) {
		
		int res =0;
		try {
			res =sqlSession.delete(namespace+"rcdelete",rcvideo_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	@Override
	public List<RcvideoDto> rclist(String book_isbn) {
		
		List<RcvideoDto> list = new ArrayList<RcvideoDto>();
		
		try {
			list =sqlSession.selectList(namespace+"rclist",book_isbn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

}
