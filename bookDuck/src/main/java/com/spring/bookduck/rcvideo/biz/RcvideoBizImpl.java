package com.spring.bookduck.rcvideo.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.rcvideo.dao.RcvideoDao;
import com.spring.bookduck.rcvideo.dto.RcvideoDto;

@Service
public class RcvideoBizImpl implements RcvideoBiz {
	
	@Autowired
	private RcvideoDao dao;
	
	@Override
	public List<RcvideoDto> rcselectone(String rcvideo_isbn) {
		return dao.rcselectone(rcvideo_isbn);
	}
	@Override
	public RcvideoDto rcselectoneno(int rcvideo_no) {
		return dao.rcselectoneno(rcvideo_no);
	}

	@Override
	public int rcinsert(RcvideoDto dto) {
		return dao.rcinsert(dto);
	}

	@Override
	public int rcupdate(RcvideoDto dto) {
		return dao.rcupdate(dto);
	}

	@Override
	public int rcdelete(int rcvideo_no) {
		return dao.rcdelete(rcvideo_no);
	}
	@Override
	public List<RcvideoDto> rclist(String book_isbn) {
		return dao.rclist(book_isbn);
	}

}
