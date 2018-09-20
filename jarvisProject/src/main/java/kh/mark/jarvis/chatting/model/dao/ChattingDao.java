package kh.mark.jarvis.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.chatting.model.vo.ChattingRoom;

public interface ChattingDao {

   List<Map<String,Object>> roomList(SqlSessionTemplate sqlSession, Map<String,String> roomMap);
   ChattingRoom selectRoom(SqlSessionTemplate sqlSession, Map<String,String> roomMap);
   int createRoom(SqlSessionTemplate sqlSession, Map<String,String> roomMap);
   int saveMessage(SqlSessionTemplate sqlSession, Map<String,String> map);
   List<Map<String,String>> chattingList(SqlSessionTemplate sqlSession, Map<String,String> map);
   String lastChatting(SqlSessionTemplate sqlSession, Map<String,String> roomMap);
   
   List<Map<String,Object>> contentsList(SqlSessionTemplate sqlSession, int room_no);
   int readCheck(SqlSessionTemplate sqlSession, Map<String,String> roomMap);
   int countRead(SqlSessionTemplate sqlSession, String fEmail);
   String friendImg(SqlSessionTemplate sqlSession, String email);
}