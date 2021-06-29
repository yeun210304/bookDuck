package com.spring.bookduck.bookfm.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.bookfm.dao.BookFMDao;
import com.spring.bookduck.bookfm.dto.BookFMDto;

@Service
public class BookFMBizImpl implements BookFMBiz{
	
	@Autowired
	BookFMDao dao;
	
	@Override
	public int insertBookFM(BookFMDto dto) {
		return dao.insertBookFM(dto);
	}

	@Override
	public List<BookFMDto> selectList(String ISBN) {
		return dao.selectList(ISBN);
	}

}
