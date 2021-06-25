package com.spring.bookduck.model.dao;

import java.util.List;

import com.spring.bookduck.model.dto.ReadingChartDto;

public interface ReadingChartDao {

	String NAMESPACE = "ReadingChartMapper.";
	
	public List<ReadingChartDto> chartData(String chartId);
	public int insert(ReadingChartDto dto);
	
}
