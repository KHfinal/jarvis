package kh.mark.jarvis.chatting.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.chatting.model.vo.ChattingRoom;

public interface ChattingDao {

	ChattingRoom selectRoom(SqlSessionTemplate sqlSession, Map<String,String> roomMap);
	int createRoom(SqlSessionTemplate sqlSession, Map<String,String> roomMap);
	
}
