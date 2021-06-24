package com.spring.bookduck.model.biz;

import java.util.List;

import com.spring.bookduck.model.dto.ReadingChartDto;

public interface ReadingChartBiz {

	public List<ReadingChartDto> chartData(String chartId);
	public int insert(ReadingChartDto dto);
	
}
