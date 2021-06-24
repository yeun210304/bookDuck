package com.spring.bookduck.model.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.bookduck.model.biz.ReadingChartBiz;
import com.spring.bookduck.model.dao.ReadingChartDao;
import com.spring.bookduck.model.dto.ReadingChartDto;

public class ReadingChartController {

	@Autowired
	private ReadingChartBiz biz;
	
	@Autowired
	private ReadingChartDao dao;
	
	@RequestMapping(value="/chartData.do", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, ReadingChartDto> chartData(String chartId){
		
		Map map = new HashMap();
		List<ReadingChartDto> list = biz.chartData(chartId);
		map.put("map", list);
		
		return map;
	}
	
	
	public String chartInsert(ReadingChartDto dto) {

		if (biz.insert(dto) > 0){
			return "";
		} 
		return "";
	}
}





























