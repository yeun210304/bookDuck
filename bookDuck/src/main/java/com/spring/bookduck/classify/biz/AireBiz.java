package com.spring.bookduck.classify.biz;

import java.util.List;

import com.spring.bookduck.classify.dto.AireDto;

public interface AireBiz {
	
	public List<AireDto> totalRe();
	public AireDto findReOne(String member_id);
	public int insertRe(AireDto dto);
	public int updateRe(AireDto dto);
	public int deleteRe(String member_id);

}
