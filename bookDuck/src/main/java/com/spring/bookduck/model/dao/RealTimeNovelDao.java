package com.spring.bookduck.model.dao;

import java.util.List;

import com.spring.bookduck.model.dto.RealTimeNovelDto;

public interface RealTimeNovelDao {


	String NAMESPACE = "RealTimeNovelMapper.";
	
	public List<RealTimeNovelDto> selectList();
	public int insert(RealTimeNovelDto dto);
	
}
