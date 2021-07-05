package com.spring.bookduck.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@ServerEndpoint("/RealTimeNovel.do")
public class WebSocketController {

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
				} else {
				}
			}
		}
		return;
	}
	
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
