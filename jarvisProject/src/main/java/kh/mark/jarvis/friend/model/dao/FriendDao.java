package kh.mark.jarvis.friend.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.member.model.vo.Member;

public interface FriendDao {
	List<String> selectFriendListJson(SqlSessionTemplate sqlSession,Map<String,String> map);
	String selectConcernList(SqlSessionTemplate sqlSession,String email);
	List<Member> selectMemberConcernList(SqlSessionTemplate sqlSession,String concern);
	List<Map<String,String>> selectSearch2(SqlSessionTemplate session, Map<String,Object> map);
	int friendRequest(SqlSessionTemplate sqlSession, Map<String, String> fr);
	List<String> requestList(SqlSessionTemplate sqlSession, Map<String,String> map);
	int friendAgree(SqlSessionTemplate sqlSession, Map<String,String> fr);
	int friendRefuse(SqlSessionTemplate sqlSession, Map<String,String> fr);
	List<String> friendList(SqlSessionTemplate sqlSession, Map map);
	String friendOne(SqlSessionTemplate sqlSession, String fEmail);
}
