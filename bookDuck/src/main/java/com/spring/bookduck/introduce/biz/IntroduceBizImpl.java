package com.spring.bookduck.introduce.biz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.introduce.dao.IntroduceDao;
import com.spring.bookduck.introduce.dto.IntroduceDto;
@Service
public class IntroduceBizImpl implements IntroduceBiz {
	
	@Autowired
	private IntroduceDao dao;
	
	@Override
	public IntroduceDto selectone(int intd_no) {
		return dao.selectone(intd_no);
	}

	@Override
	public int insert(IntroduceDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int update(IntroduceDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int delete(IntroduceDto dto) {
		return dao.insert(dto);
	}

}
