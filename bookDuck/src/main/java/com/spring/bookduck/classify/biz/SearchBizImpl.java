package com.spring.bookduck.classify.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.classify.dao.SearchDao;
import com.spring.bookduck.model.dto.MemberDto;

@Service
public class SearchBizImpl implements SearchBiz {
	
	@Autowired
	private SearchDao dao;

	@Override
	public List<MemberDto> idsearch(String member_id) {
		return dao.idsearch(member_id);
	}
	
	
	

}
