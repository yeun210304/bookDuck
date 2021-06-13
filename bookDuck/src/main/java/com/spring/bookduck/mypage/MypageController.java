package com.spring.bookduck.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MypageController {
	
	@RequestMapping("mypage.do")
	public String mypage() {
		
		
		return"mypage";
	}
}
