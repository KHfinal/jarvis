package kh.mark.jarvis.chatting.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mark.jarvis.chatting.model.dao.ChattingDao;
import kh.mark.jarvis.chatting.model.vo.ChattingRoom;

@Service
public class ChattingServiceImpl implements ChattingService {

	@Autowired
	private ChattingDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<Map<String, Object>> roomList(Map<String, String> roomMap) {
		return dao.roomList(sqlSession, roomMap);
	}

	@Override
	public ChattingRoom selectRoom(Map<String, String> roomMap) {
		return dao.selectRoom(sqlSession, roomMap);
	}

	@Override
	public int createRoom(Map<String, String> roomMap) {
		return dao.createRoom(sqlSession, roomMap);
	}

	@Override
	public int saveMessage(Map<String, String> map) {
		return dao.saveMessage(sqlSession, map);
	}

	@Override
	public List<Map<String, String>> chattingList(Map<String, String> map) {
		return dao.chattingList(sqlSession, map);
	}

	@Override
	public String lastChatting(Map<String, String> roomMap) {
		return dao.lastChatting(sqlSession, roomMap);
	}
	
	

}
