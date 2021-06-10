package com.spring.bookduck.classify.biz;

import java.util.List;

import com.spring.bookduck.classify.dto.BlistDto;

public interface BlistBiz {

	public List<BlistDto> totalBlist();
	public List<BlistDto> personBlist(String memberId);
	public BlistDto findBOne(String memberId);
	public int insertBlist(BlistDto dto);
	public int updateBlist(BlistDto dto);
	public int deleteBlist(String memberId);
	
	
}
