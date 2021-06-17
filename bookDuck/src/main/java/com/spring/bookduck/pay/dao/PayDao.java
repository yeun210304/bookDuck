package com.spring.bookduck.pay.dao;

import com.spring.bookduck.pay.dto.PayDto;

public interface PayDao {
	
	String namespace= "bookduckpay.";
	
	public int insertPay(PayDto dto);
	
	public int updatememberrole(String member_id);
	
}
