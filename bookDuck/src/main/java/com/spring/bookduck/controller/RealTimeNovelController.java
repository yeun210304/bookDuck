package com.spring.bookduck.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.bookduck.model.biz.RealTimeNovelBiz;
import com.spring.bookduck.model.dto.RealTimeNovelDto;

@Controller
@ServerEndpoint("/RealTimeNovel.do")
public class RealTimeNovelController {

	@Autowired
	private RealTimeNovelBiz biz;
	
	private static Set<Object> clients = Collections.synchronizedSet(new HashSet<Object>());

	@RequestMapping("/")
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		
		System.out.println(message);
		
		synchronized (clients) { // Iterate over the connected sessions
			// and broadcast the received message
			for (Object client : clients) {
				if (!client.equals(session)) {
					((Session) client).getBasicRemote().sendText(message);
				}
			}
		}
		return;
	}

	/*
	@RequestMapping("submitForm.do")
	public String select(Model model) {
		List<RealTimeNovelDto> list = biz.select();
		model.addAttribute("list", list);
		return "home";
	}
	*/
	
	@RequestMapping("/insertNovel.do")
	public  String insertNovel(RealTimeNovelDto dto) {
		
		if (biz.insert(dto) > 0) {
			 return "redirect:/";
			// return "home";
		}
		return "redirect:/";
	}
	
	/*	
	@RequestMapping("insertContent.do")
	@ResponseBody
	public Map<String, String> insertContent(RealTimeNovelDto dto) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		if (biz.insert(dto) > 0) {
			map.put("success", "success");
		} else {
			map.put("success", "fail");
		}
		
		return map;
	}
	*/
	@OnOpen
	public void onOpen(Session session) { // Add session to the connected
										  // sessions set
		System.out.println("세션연결 성공" + session);
		clients.add(session);
	}

	@OnClose
	public void onClose(Session session) {
		// Remove session from the connected sessions set
		clients.remove(session);
	}
	
	
}
