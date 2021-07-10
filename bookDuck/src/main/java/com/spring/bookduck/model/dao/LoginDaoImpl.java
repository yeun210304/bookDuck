package com.spring.bookduck.model.dao;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
		
		MemberDto res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"snslogin", member_email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
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

	@Transactional
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
	public int leaveAccount(MemberDto dto) {
		int res=0;
		try {
			res=sqlSession.delete(NAMESPACE+"leaveAccount", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
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
	
	@Override
	public int emailCheck(MemberDto dto) {
		int res = 0;
			try {
				res=sqlSession.selectOne(NAMESPACE+"Email_Check", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return res;
	}

	@Override
	public MemberDto findId(MemberDto dto) {
		
		MemberDto res = null;
		
		try {
			res=sqlSession.selectOne(NAMESPACE+"findId", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public void findPw(HttpServletResponse response, MemberDto dto) {
		
	}

	@Override
	public String getPw(Map<String, Object> paramMap) {
		
		String res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"getPw", paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int tokenchk(String member_email) {
		int res = 0;
		
		try {
			res=sqlSession.selectOne(NAMESPACE+"tokenchk", member_email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

}
