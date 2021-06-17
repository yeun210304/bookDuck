package com.spring.bookduck.pay.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bookduck.pay.dto.PayDto;
@Repository
public class PayDaoImpl implements PayDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertPay(PayDto dto) {
		int res = 0;
		
		try {
			res= sqlSession.insert(namespace+"insertpay",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	return res;
	}

	@Override
	public int updatememberrole(String member_id) {
		
		int res =0;
		
		try {
			res =sqlSession.update(namespace+"payroleupdate",member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

}
