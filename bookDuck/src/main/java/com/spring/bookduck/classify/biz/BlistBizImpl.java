package com.spring.bookduck.classify.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.classify.dao.BlistDao;
import com.spring.bookduck.classify.dto.BlistDto;


@Service
public class BlistBizImpl implements BlistBiz {

	@Autowired
	private BlistDao dao;
	
	@Override
	public List<BlistDto> totalBlist() {
		return dao.totalBlist();
	}

	@Override
	public List<BlistDto> personBlist(String member_id) {
		return dao.personBlist(member_id);
	}

	@Override
	public BlistDto findBOne(String member_id) {
		return dao.findBOne(member_id);
	}

	@Override
	public int insertBlist(BlistDto dto) {
		return dao.insertBlist(dto);
	}

	@Override
	public int updateBlist(BlistDto dto) {
		return dao.updateBlist(dto);
	}

	@Override
	public int deleteBlist(String member_id) {
		return dao.deleteBlist(member_id);
	}

}
