package com.spring.bookduck.scrap.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.scrap.dao.ScrapDao;
import com.spring.bookduck.scrap.dto.ScrapDto;

@Service
public class ScrapBizImpl implements ScrapBiz {

	@Autowired
	private ScrapDao dao;
	
	@Override
	public List<ScrapDto> sclist(String scrap_id) {
		return dao.sclist(scrap_id);
	}

	@Override
	public ScrapDto scselectone(int scrap_no) {
		return dao.scselectone(scrap_no);
	}

	@Override
	public int scinsert(ScrapDto dto) {
		return dao.scinsert(dto);
	}

	@Override
	public int scdelete(int scrap_no) {
		return dao.scdelete(scrap_no);
	}

	@Override
	public ScrapDto scalldelete(String scrap_id) {
		return dao.scalldelete(scrap_id);
	}

}
