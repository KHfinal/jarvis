package kh.mark.jarvis.websocket.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

import kh.mark.jarvis.member.model.vo.Member;



public class SocketHandler extends TextWebSocketHandler {

	private List<WebSocketSession> sessionList=new ArrayList<>();
	private Logger logger=LoggerFactory.getLogger(SocketHandler.class);
	private List<String> userName = new ArrayList<>();
	
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		
		Member login=(Member)session.getAttributes().get("memberLoggedIn");
		
		userName.add(login.getMemberEmail());
		System.out.println("소켓 들어온사람 : " + login.getMemberEmail());
		
		for(WebSocketSession s : sessionList) {
			for(int i =0; i<userName.size();i++) {
				System.out.println("userName.get(i) : " + userName.get(i) );
				
				s.sendMessage(new TextMessage("1"+"|"+userName.get(i)));
				
			}
			
		}
		System.out.println("현재 접속자" + userName);
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		sessionList.remove(session);
		
		
		Member login=(Member)session.getAttributes().get("memberLoggedIn");
		System.out.println("나간사람 : " + login.getMemberEmail());
		userName.remove(login.getMemberEmail());
		
		for(WebSocketSession s : sessionList) {
			for(int i =0; i<userName.size();i++) {
				System.out.println("보내는 값: " + userName.get(i) );
				s.sendMessage(new TextMessage("2"+"|"+userName.get(i)));
			}
			
		}
		System.out.println("현재 접속자" + userName);
		
		
	}

	
	
	
}
