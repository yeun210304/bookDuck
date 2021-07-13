package com.spring.bookduck.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.bookduck.introduce.biz.IntroduceBiz;
import com.spring.bookduck.introduce.dto.IntroduceDto;
import com.spring.bookduck.model.biz.ReadingChartBiz;
import com.spring.bookduck.model.dao.ReadingChartDao;
import com.spring.bookduck.model.dto.MemberDto;
import com.spring.bookduck.model.dto.ReadingChartDto;
import com.spring.bookduck.scrap.biz.ScrapBiz;
import com.spring.bookduck.scrap.dto.ScrapDto;

@Controller
public class ReadingChartController {

	private Logger logger = LoggerFactory.getLogger(ReadingChartController.class);
	
	@Autowired
	private ReadingChartBiz biz;
	
	@Autowired
	private IntroduceBiz Introbiz;
	
	@Autowired
	private ScrapBiz scbiz;
	
	@Autowired
	private ReadingChartDao dao;
	
	@RequestMapping(value="/chartData.do", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, ReadingChartDto> chartData(String chartId){
		
		logger.info("[ReadingChartController] : chartData.do");		
		
		Map map = new HashMap();
		List<ReadingChartDto> list = biz.chartData(chartId);
		map.put("map", list);
		
		return map;
	}
	
	@RequestMapping("/readingTimeInsert.do")
	public String chartInsert(ReadingChartDto dto, MemberDto Ldto, Model model, String chartId) {
		
		if (biz.insert(dto) > 0){
			
			logger.info("[ReadingChartController] : readingTimeInsert.do");		
			System.out.println("Ldto 여기임!!!!!" + chartId);
			model.addAttribute("member_id", chartId);
			IntroduceDto intdres = Introbiz.selectone(Ldto.getMember_id());
			model.addAttribute("intdDto",intdres);
			List<ScrapDto> scrapres = scbiz.sclist(Ldto.getMember_id());
			model.addAttribute("sclist",scrapres);
			model.addAttribute("member_payrole",Ldto.getMember_payrole());
			return "redirect:mypage.do";
		} 
		return "redirect:mypage.do";
	}
}




















