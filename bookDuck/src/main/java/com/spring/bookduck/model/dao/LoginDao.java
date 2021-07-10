package com.spring.bookduck.model.dao;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
	public int leaveAccount(MemberDto dto);
	
	//아이디 중복 확인
	public int idCheck(MemberDto dto);
	
	//이메일 중복 확인
	public int emailCheck(MemberDto dto);
	
	//ID찾기
	public MemberDto findId(MemberDto dto);
	
	//sns 로그인 토큰 체크
	public int tokenchk(String member_email);
	
	//PW찾기
	public void findPw(HttpServletResponse response, MemberDto dto);

	public String getPw(Map<String, Object> paramMap);
	

}
