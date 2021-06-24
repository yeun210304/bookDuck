package com.spring.bookduck.scrap.biz;

import java.util.List;

import com.spring.bookduck.scrap.dto.ScrapDto;

public interface ScrapBiz {
	
	public List<ScrapDto> sclist(String scrap_id);
	public ScrapDto scselectone(int scrap_no);
	public int scinsert(ScrapDto dto);
	public int scdelete(int scrap_no);
	public ScrapDto scalldelete(String scrap_id);
	
	

}
