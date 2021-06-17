package com.spring.bookduck.model.dao;

import java.util.Map;

import com.spring.bookduck.model.dto.MemberDto;

public interface LoginDao {
	
	String NAMESPACE = "memberMapper.";
	
	//로그인
	public MemberDto login(MemberDto dto);
	
	//sns로그인
	public MemberDto snslogin(String member_email);
	
	//회원가입
	public int join(MemberDto dto);
	
	//비밀번호 변경
	public int updatePw(MemberDto dto);
	
	//회원 탈퇴
	public int leaveAccount(int member_no);
	
	//아이디 중복 확인
	public int idCheck(MemberDto dto);
	

}
