package com.spring.bookduck.pay.biz;

import com.spring.bookduck.pay.dto.PayDto;


public interface PayBiz {
	public int insertPay(PayDto dto);
	public int updatememberrole(String member_id);
}
