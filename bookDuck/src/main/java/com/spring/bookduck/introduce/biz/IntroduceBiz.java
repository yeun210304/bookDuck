package com.spring.bookduck.introduce.biz;

import com.spring.bookduck.introduce.dto.IntroduceDto;

public interface IntroduceBiz {
	
	
	public IntroduceDto selectone(int intd_no);
	public int insert(IntroduceDto dto);
	public int update(IntroduceDto dto);
	public int delete(IntroduceDto dto);
	

}
