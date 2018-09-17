package kh.mark.jarvis.friend.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.member.model.vo.Member;

public interface FriendDao {
	List<Member> selectFriendListJson(SqlSessionTemplate sqlSession,Map<String,String> map);
	String selectConcernList(SqlSessionTemplate sqlSession,String email);
	List<Member> selectMemberConcernList(SqlSessionTemplate sqlSession,String concern);
	List<Member> selectSearch2(SqlSessionTemplate session, Map<String,String> map);
	List<Member> selectRecognizableList(SqlSessionTemplate sqlSession, String email);
	int friendRequest(SqlSessionTemplate sqlSession, Map<String, String> fr);
	List<Map<String,Object>> requestList(SqlSessionTemplate sqlSession, Map<String,String> map);
	int friendAgree(SqlSessionTemplate sqlSession, Map<String,String> fr);
	int friendRefuse(SqlSessionTemplate sqlSession, Map<String,String> fr);
	List<Map<String,Object>> friendList(SqlSessionTemplate sqlSession, Map<String,String> map);
	String friendOne(SqlSessionTemplate sqlSession, String fEmail);
	List<Map<String,Object>> autoFriendList(SqlSessionTemplate sqlSession, Map<String,String> map);
}
