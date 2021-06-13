package com.spring.bookduck.paybiz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.paydao.PayDao;
import com.spring.bookduck.paydto.PayDto;
@Service
public class PayBizImpl implements PayBiz {
	
	@Autowired
	private PayDao dao;
	
	@Override
	public int insertPay(PayDto dto) {
		
		return dao.insertPay(dto);
	}

	@Override
	public int updatememberrole(String member_id) {
		return dao.updatememberrole(member_id);
	}

}
