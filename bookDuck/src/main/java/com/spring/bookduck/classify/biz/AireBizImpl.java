package com.spring.bookduck.classify.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.classify.dao.AireDao;
import com.spring.bookduck.classify.dto.AireDto;

@Service
public class AireBizImpl implements AireBiz {

	@Autowired
	private AireDao dao;
	
	@Override
	public List<AireDto> totalRe() {
		return dao.totalRe();
	}

	@Override
	public AireDto findReOne(String member_id) {
		return dao.findReOne(member_id);
	}

	@Override
	public int insertRe(AireDto dto) {
		return dao.insertRe(dto);
	}

	@Override
	public int updateRe(AireDto dto) {
		return dao.updateRe(dto);
	}

	@Override
	public int deleteRe(String member_id) {
		return dao.deleteRe(member_id);
	}

}
