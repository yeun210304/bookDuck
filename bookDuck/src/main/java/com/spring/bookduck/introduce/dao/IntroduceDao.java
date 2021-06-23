package com.spring.bookduck.introduce.dao;

import com.spring.bookduck.introduce.dto.IntroduceDto;

public interface IntroduceDao {
	
	String namespace= "introduce.";
	
	public IntroduceDto selectoneno(int intd_no);
	public IntroduceDto selectone(String intd_id);
	public int insert(IntroduceDto dto);
	public int update(IntroduceDto dto);
	public int delete(int intd_no);
	

}
