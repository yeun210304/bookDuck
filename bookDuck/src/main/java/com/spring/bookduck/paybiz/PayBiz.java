package com.spring.bookduck.paybiz;

import com.spring.bookduck.paydto.PayDto;


public interface PayBiz {
	public int insertPay(PayDto dto);
	public int updatememberrole(String member_id);
}
