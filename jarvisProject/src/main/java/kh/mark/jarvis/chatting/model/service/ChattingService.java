package kh.mark.jarvis.chatting.model.service;

import java.util.List;
import java.util.Map;

import kh.mark.jarvis.chatting.model.vo.ChattingRoom;

public interface ChattingService {

	List<Map<String,Object>> roomList(Map<String,String> roomMap);
	ChattingRoom selectRoom(Map<String,String> roomMap);
	int createRoom(Map<String,String> roomMap);
	int saveMessage(Map<String,String> map);
	List<Map<String,String>> chattingList(Map<String,String> map);
	String lastChatting(Map<String,String> roomMap);
	
	List<Map<String,Object>> contentsList(int room_no);
}
