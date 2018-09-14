package kh.mark.jarvis.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kh.mark.jarvis.chatting.model.vo.ChattingRoom;

@Repository
public class ChattingDaoImpl implements ChattingDao {

	
	@Override
	public ChattingRoom selectRoom(SqlSessionTemplate sqlSession, Map<String, String> roomMap) {
		return sqlSession.selectOne("chatting.selectRoom",roomMap);
	}

	@Override
	public int createRoom(SqlSessionTemplate sqlSession, Map<String, String> roomMap) {
		return sqlSession.insert("chatting.roomCreate",roomMap);
	}

}
