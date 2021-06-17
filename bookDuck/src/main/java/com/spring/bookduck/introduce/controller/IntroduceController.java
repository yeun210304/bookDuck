package com.spring.bookduck.introduce.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.introduce.biz.IntroduceBiz;

@Controller
public class IntroduceController {
	
	@Autowired
	private IntroduceBiz biz;
	
	

}
