package com.spring.bookduck.classify.dao;

import java.util.List;

import com.spring.bookduck.model.dto.MemberDto;

public interface SearchDao {
	
	String NAMESPACE = "classifymapper.";
	
	public List<MemberDto> idsearch(String member_id);

}
