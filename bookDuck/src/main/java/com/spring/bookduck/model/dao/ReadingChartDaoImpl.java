package com.spring.bookduck.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.model.dto.ReadingChartDto;

@Repository
public class ReadingChartDaoImpl implements ReadingChartDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<ReadingChartDto> chartData(String chartId) {
		
			List<ReadingChartDto> list = new ArrayList<ReadingChartDto>();
			
			try {
				list = sqlSession.selectList(NAMESPACE + "chartData", chartId);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		return list;
	}

	@Override
	public int insert(ReadingChartDto dto) {
		
			int res = 0;
			
			try {
				res = sqlSession.insert(NAMESPACE + "insert", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		return res;
	}

}






















