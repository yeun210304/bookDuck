package com.spring.bookduck.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.model.dto.MemberDto;

@Repository
public class LoginDaoImpl implements LoginDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public MemberDto login(MemberDto dto) {
		
		MemberDto res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"login", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
		
	}

	@Override
	public MemberDto snslogin(String member_email) {
		return null;
	}

	@Override
	public int join(MemberDto dto) {
		int res = 0;
			try {
				res = sqlSession.insert(NAMESPACE+"join", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return res;
	}

	@Override
	public int updatePw(MemberDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"updatePw", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public void leaveAccount(MemberDto dto) {
		sqlSession.delete(NAMESPACE+"leaveAccount", dto);
	}

	@Override
	public int idCheck(MemberDto dto) {
		int res = 0;
			try {
				res=sqlSession.selectOne(NAMESPACE+"Id_Check", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return res;
	}

}
