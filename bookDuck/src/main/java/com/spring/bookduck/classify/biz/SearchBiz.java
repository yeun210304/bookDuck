package com.spring.bookduck.classify.biz;

import java.util.List;
import com.spring.bookduck.model.dto.MemberDto;

public interface SearchBiz {
	
	public List<MemberDto> idsearch(String member_id);
	

}
