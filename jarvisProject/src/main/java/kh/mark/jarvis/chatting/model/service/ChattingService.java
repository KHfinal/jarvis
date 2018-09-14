package kh.mark.jarvis.chatting.model.service;

import java.util.Map;

import kh.mark.jarvis.chatting.model.vo.ChattingRoom;

public interface ChattingService {

	ChattingRoom selectRoom(Map<String,String> roomMap);
	int createRoom(Map<String,String> roomMap);
}
