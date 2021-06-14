package com.spring.bookduck.model.biz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.model.dao.LoginDao;
import com.spring.bookduck.model.dto.MemberDto;

@Service
public class LoginBizImpl implements LoginBiz {
	
	@Autowired
	private LoginDao dao;

	@Override
	public MemberDto login(MemberDto dto) {
		return dao.login(dto);
	}

	@Override
	public int join(MemberDto dto) {
		return dao.join(dto);
	}

	@Override
	public MemberDto snslogin(String member_email) {
		return null;
	}

	@Override
	public int updatePw(MemberDto dto) {
		return 0;
	}

	@Override
	public int leaveAccount(int member_no) {
		return 0;
	}

	@Override
	public int idCheck(String member_id) {
		return 0;
	}

}
