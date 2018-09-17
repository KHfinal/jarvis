package kh.mark.jarvis.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kh.mark.jarvis.chatting.model.vo.ChattingRoom;

@Repository
public class ChattingDaoImpl implements ChattingDao {

	@Override
	public List<Map<String,Object>> roomList(SqlSessionTemplate sqlSession, Map<String, String> roomMap) {
		return sqlSession.selectList("chatting.roomList",roomMap);
	}

	@Override
	public ChattingRoom selectRoom(SqlSessionTemplate sqlSession, Map<String, String> roomMap) {
		return sqlSession.selectOne("chatting.selectRoom",roomMap);
	}

	@Override
	public int createRoom(SqlSessionTemplate sqlSession, Map<String, String> roomMap) {
		return sqlSession.insert("chatting.roomCreate",roomMap);
	}

	@Override
	public int saveMessage(SqlSessionTemplate sqlSession, Map<String, String> map) {
		return sqlSession.insert("chatting.saveMessage",map);
	}

	@Override
	public List<Map<String, String>> chattingList(SqlSessionTemplate sqlSession, Map<String, String> map) {
		return sqlSession.selectList("chatting.chattingList", map);
	}

	@Override
	public String lastChatting(SqlSessionTemplate sqlSession, Map<String, String> roomMap) {
		return sqlSession.selectOne("chatting.lastChat",roomMap);
	}

	@Override
	public List<Map<String, Object>> contentsList(SqlSessionTemplate sqlSession, int room_no) {
		return sqlSession.selectList("chatting.contentsList", room_no);
	}
	
	
	
	

}
