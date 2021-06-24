package com.spring.bookduck.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.model.dao.ReadingChartDao;
import com.spring.bookduck.model.dto.ReadingChartDto;

@Service
public class ReadingChartBizImpl implements ReadingChartBiz {

	@Autowired
	private ReadingChartDao dao;
	
	@Override
	public List<ReadingChartDto> chartData(String chartId) {
		return dao.chartData(chartId);
	}

	@Override
	public int insert(ReadingChartDto dto) {
		return dao.insert(dto);
	}

}
