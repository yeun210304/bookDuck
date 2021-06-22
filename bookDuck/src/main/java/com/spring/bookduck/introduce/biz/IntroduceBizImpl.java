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
	public IntroduceDto selectoneno(int intd_no) {
		return dao.selectoneno(intd_no);
	}
	
	@Override
	public IntroduceDto selectone(String intd_id) {
		return dao.selectone(intd_id);
	}

	@Override
	public int insert(IntroduceDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int update(IntroduceDto dto) {
		return dao.update(dto);
	}

	@Override
	public int delete(int intd_no) {
		return dao.delete(intd_no);
	}

	

}
