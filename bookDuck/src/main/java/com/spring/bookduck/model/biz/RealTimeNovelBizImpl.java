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
	public List<RealTimeNovelDto> selectList() {
		return dao.selectList();
	}
	
	@Override
	public int insert(RealTimeNovelDto dto) {
		return dao.insert(dto);
	}

}
