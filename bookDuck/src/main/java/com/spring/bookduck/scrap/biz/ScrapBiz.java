package com.spring.bookduck.scrap.biz;

import java.util.List;

import com.spring.bookduck.scrap.dto.ScrapDto;

public interface ScrapBiz {
	
	public List<ScrapDto> sclist(String scrap_id);
	public ScrapDto scselectone(String book_isbn);
	public int scinsert(ScrapDto dto);
	public int scdelete(int scrap_no);
	public void scalldelete(String scrap_no);
	public List<ScrapDto> scidlist(String book_isbn);
	
	

}
