package com.spring.bookduck.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.model.dao.RealTimeNovelDao;
import com.spring.bookduck.model.dto.RealTimeNovelDto;

@Service
public class RealTimeNovelBizImpl implements RealTimeNovelBiz {

	@Autowired
	private RealTimeNovelDao dao;
	
	@Override
	public int insert(RealTimeNovelDto dto) {
		System.out.println("biz.content : " + dto.getNovel_content());
		System.out.println("biz.id : " + dto.getNovel_id());
		System.out.println("biz.no : " + dto.getNovel_no());
		System.out.println("biz.regdate : " + dto.getNovel_regdate());
		return dao.insert(dto);
	}

	@Override
	public List<RealTimeNovelDto> select() {
		return dao.select();
	}

}
