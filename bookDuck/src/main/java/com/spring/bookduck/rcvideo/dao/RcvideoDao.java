package com.spring.bookduck.rcvideo.dao;

import java.util.List;

import com.spring.bookduck.rcvideo.dto.RcvideoDto;

public interface RcvideoDao {
	
	String namespace ="rcvideo.";
	
	public List<RcvideoDto> rcselectone(String rcvideo_isbn);
	public int rcinsert (RcvideoDto dto);
	public int rcupdate (RcvideoDto dto);
	public int rcdelete(int rcvideo_no);
}
