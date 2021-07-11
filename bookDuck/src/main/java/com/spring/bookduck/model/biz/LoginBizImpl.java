package com.spring.bookduck.model.biz;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
		return dao.snslogin(member_email);
	}

	@Override
	public int updatePw(MemberDto dto) {
		return dao.updatePw(dto);
	}

	@Override
	public int leaveAccount(MemberDto dto) {
		return dao.leaveAccount(dto);
	}

	@Override
	public int idCheck(MemberDto dto) {
		return dao.idCheck(dto);
	}

	@Override
	public MemberDto findId(MemberDto dto) {
		return dao.findId(dto);
	}

	@Override
	public void findPw(HttpServletResponse response, MemberDto dto) {
		
	}

	@Override
	public String getPw(Map<String, Object> paramMap) {
		return dao.getPw(paramMap);
	}

	@Override
	public int tokenchk(String member_email) {
		return dao.tokenchk(member_email);
	}

	@Override
	public int emailCheck(MemberDto dto) {
		return dao.emailCheck(dto);
	}
}
