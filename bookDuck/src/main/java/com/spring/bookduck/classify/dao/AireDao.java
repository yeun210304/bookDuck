package com.spring.bookduck.classify.dao;

import java.util.List;

import com.spring.bookduck.classify.dto.AireDto;

public interface AireDao {
	
	String NAMESPACE = "classifyaimapper.";
	
	public List<AireDto> totalRe();
	public AireDto findReOne(String memberId);
	public int insertRe(AireDto dto);
	public int updateRe(AireDto dto);
	public int deleteRe(String memberId);
	

}
