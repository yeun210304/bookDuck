package com.spring.bookduck.model.dao;

import com.spring.bookduck.model.dto.LoginDto;

public interface JoinDao {
	
	//회원가입 처리
	void register(LoginDto joinDto) throws Exception;

}
