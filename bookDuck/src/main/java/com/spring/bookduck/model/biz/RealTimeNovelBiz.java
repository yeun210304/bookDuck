package com.spring.bookduck.model.biz;

import java.util.List;

import com.spring.bookduck.model.dto.RealTimeNovelDto;

public interface RealTimeNovelBiz {

	public List<RealTimeNovelDto> selectList();
	public int insert(RealTimeNovelDto dto);
	
}
