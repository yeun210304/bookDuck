package com.spring.bookduck.classify.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring.bookduck.classify.biz.AiUtils;
import com.spring.bookduck.classify.biz.AireBiz;
import com.spring.bookduck.classify.dto.AiUtilDto;
import com.spring.bookduck.classify.dto.AireDto;
import com.spring.bookduck.classify.dto.CateGsonDto;
import com.spring.bookduck.model.dto.MemberDto;

@Controller
public class ClassifyAIController {
	
	private Logger logger = LoggerFactory.getLogger(ClassifyAIController.class);			
			
	@Autowired
	private AireBiz biz;
	
	@RequestMapping("/ailist.do")
	public String ailist(Model model) {
		
		logger.info("[ClassifyAIController] : ailist.do");		
		
		List<AireDto> list = biz.totalRe();		
		model.addAttribute("airelist", list);	
		
		return "classify/classifyailist";
	}
	
	@RequestMapping("/aifindreone.do")
	public String aifindreone(Model model, HttpServletRequest request) {

		logger.info("[ClassifyAIController] : aifindreone.do");	
		
		/*
		LoginDto ldto = (LoginDto) request.getAttribute("Ldto");
		AireDto aidto = biz.findReOne(ldto.getMember_id());
		model.addAttribute("aidto", aidto);
		*/
		AireDto aidto = biz.findReOne("admin");
		model.addAttribute("aidto", aidto);
		
		
		return "classify/classifyaifindone";
	}
	
	
	@RequestMapping("/airecommend.do")
	@ResponseBody
	public Map<String, List<AiUtilDto>> airecommend(HttpServletRequest request, String age_mw, String category){
		logger.info("[ClassifyAIController]/airecommend.do : age_mw 값 = " + age_mw);
		logger.info("[ClassifyAIController]/airecommend.do : category 값 = " + category);
		
		String path = request.getSession().getServletContext().getRealPath("/");
		
		HttpSession session = request.getSession();
		MemberDto dto = (MemberDto) session.getAttribute("Ldto");
		String id = dto.getMember_id();		
		
		Map<String, List<AiUtilDto>> map = new HashMap<String,  List<AiUtilDto>>();
		List<AiUtilDto> predictresult = new ArrayList<AiUtilDto>();
		
		AiUtils aiutil = new AiUtils();
		String makefile = aiutil.makeWekaData(id, age_mw, category, 55, path);
		if(makefile.equals("성공")) {
			logger.info("[ClassifyAIController]/airecommend.do : makefile = 성공");
			predictresult = aiutil.predict(id, path);
			if(predictresult != null) {
				logger.info("[ClassifyAIController]/airecommend.do : ML로 예상된 결과값이 있음");
				map.put("list", predictresult);
			} else {
				logger.info("[ClassifyAIController]/airecommend.do : ML로 예상된 결과값이 없음");
				map.put("list", null);
			}
		}
		
		return map;
	}
	
	
	@RequestMapping("/airecommendcate.do")
	@ResponseBody
	public Map<String, List<CateGsonDto>> airecommendcate(String onecate, String twocate, String threecate){
		
		String key = "0061C990735847032625E99195E343C959D09BD0C9ED0B84A528F56247B727BB";		
		String common_path = "http://book.interpark.com/api/bestSeller.api?key="+key+"&output=json&categoryId=";
		
		String result1 = "";
		String result2 = "";
		String result3 = "";
		
		try {			
			BufferedReader in1 = new BufferedReader(new InputStreamReader(new URL(common_path+onecate).openStream()));
			BufferedReader in2 = new BufferedReader(new InputStreamReader(new URL(common_path+twocate).openStream()));
			BufferedReader in3 = new BufferedReader(new InputStreamReader(new URL(common_path+threecate).openStream()));
			
			String inputLine1 = "";
			String inputLine2 = "";
			String inputLine3 = "";
			
			while ((inputLine1 = in1.readLine()) != null) {
				result1 += inputLine1;
			}
			while ((inputLine2 = in2.readLine()) != null) {
				result2 += inputLine2;
			}
			while ((inputLine3 = in3.readLine()) != null) {
				result3 += inputLine3;
			}
			
			in1.close();
			in2.close();
			in3.close();		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		JSONParser parser = new JSONParser();
		Object obj1 = null;
		Object obj2 = null;
		Object obj3 = null;
		
		
		try {
			obj1 = parser.parse(result1);
			obj2 = parser.parse(result2);
			obj3 = parser.parse(result3);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		JSONObject jsonObj1 = (JSONObject) obj1;
		JSONObject jsonObj2 = (JSONObject) obj2;
		JSONObject jsonObj3 = (JSONObject) obj3;
		
		JSONArray arr1 = (JSONArray)jsonObj1.get("item");
		JSONArray arr2 = (JSONArray)jsonObj2.get("item");
		JSONArray arr3 = (JSONArray)jsonObj3.get("item");
				
		//JSONObject tmp1 = (JSONObject)arr1.get(0);
		//JSONObject tmp2 = (JSONObject)arr2.get(0);
		//JSONObject tmp3 = (JSONObject)arr3.get(0);
			
		Gson gson = new Gson();
		CateGsonDto dto1 = gson.fromJson(arr1.get(0).toString(), CateGsonDto.class);
		CateGsonDto dto2 = gson.fromJson(arr2.get(0).toString(), CateGsonDto.class);
		CateGsonDto dto3 = gson.fromJson(arr3.get(0).toString(), CateGsonDto.class);
			
		// System.out.println(result1);
		// System.out.println(dto1);		
		
		List<CateGsonDto> list = new ArrayList<CateGsonDto>();
		list.add(dto1);
		list.add(dto2);
		list.add(dto3);		
		
		Map<String, List<CateGsonDto>> map = new HashMap<String, List<CateGsonDto>>();
		map.put("list", list);
		
		return map;
	}
	
	
	

}
