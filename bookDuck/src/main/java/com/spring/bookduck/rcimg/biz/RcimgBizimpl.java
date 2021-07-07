package com.spring.bookduck.rcimg.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.rcimg.dao.RcimgDao;
import com.spring.bookduck.rcimg.dto.RcimgDto;
@Service
public class RcimgBizimpl implements RcimgBiz {
	
	@Autowired
	private RcimgDao dao;
	
	@Override
	public List<RcimgDto> imglist(String book_isbn) {
		return dao.imglist(book_isbn);
	}

	@Override
	public RcimgDto imgselectone(int rcimg_no) {
		return dao.imgselectone(rcimg_no);
	}

	@Override
	public int imginsert(RcimgDto dto) {
		return dao.imginsert(dto);
	}

	@Override
	public int imgdelete(int rcimg_no) {
		return dao.imgdelete(rcimg_no);
	}

}
