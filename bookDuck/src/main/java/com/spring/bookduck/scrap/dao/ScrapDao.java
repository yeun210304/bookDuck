package com.spring.bookduck.scrap.dao;

import java.util.List;

import com.spring.bookduck.scrap.dto.ScrapDto;

public interface ScrapDao {
	
	String namespace = "scrap.";
	
	public List<ScrapDto> sclist(String scrap_id);
	public ScrapDto scselectone(int scrap_no);
	public int scinsert(ScrapDto dto);
	public int scdelete(int scrap_no);
	public void scalldelete(String scrap_no);
	
}
