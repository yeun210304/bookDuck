package com.spring.bookduck.classify.dao;

import java.util.List;

import com.spring.bookduck.classify.dto.BlistDto;

public interface BlistDao {
	
	String NAMESPACE = "classifymapper.";
	
	public List<BlistDto> totalBlist();
	public List<BlistDto> personBlist(String member_id);
	public BlistDto findBOne(String member_id);
	public int insertBlist(BlistDto dto);
	public int updateBlist(BlistDto dto);
	public int deleteBlist(String member_id);
	

}
