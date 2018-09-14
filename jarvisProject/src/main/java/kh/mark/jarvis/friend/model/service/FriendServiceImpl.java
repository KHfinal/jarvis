package kh.mark.jarvis.friend.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mark.jarvis.friend.model.dao.FriendDao;
import kh.mark.jarvis.member.model.vo.Member;
@Service
public class FriendServiceImpl implements FriendService{

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Autowired
	private FriendDao dao;
	
	
	@Override
	public List<String> selectFriendListJson(Map<String,String> map) {
		// TODO Auto-generated method stub
		return dao.selectFriendListJson(sqlSession,map);
	}
	@Override
	public String selectConcernList(String email) {
		// TODO Auto-generated method stub
		return dao.selectConcernList(sqlSession,email);
	}
	@Override
	public List<Member> selectMemberConcernList(String concern) {
		return dao.selectMemberConcernList(sqlSession,concern);
	}
	

	@Override
	public List<Map<String, String>> selectSearch2(Map<String, Object> map) {
		return dao.selectSearch2(sqlSession,map);
	}
	@Override
	public int friendRequest(Map<String, String> fr) {
		// TODO Auto-generated method stub
		return dao.friendRequest(sqlSession,fr);
	}

	@Override
	public List<String> requestList(Map<String,String> map) {
		// TODO Auto-generated method stub
		return dao.requestList(sqlSession, map);
	}

	@Override
	public int friendAgree(Map<String, String> fr) {
		// TODO Auto-generated method stub
		return dao.friendAgree(sqlSession, fr);
	}

	@Override
	public int friendRefuse(Map<String, String> fr) {
		// TODO Auto-generated method stub
		return dao.friendRefuse(sqlSession, fr);
	}

	@Override
	public List<String> friendList(Map map) {
		// TODO Auto-generated method stub
		return dao.friendList(sqlSession, map);
	}

	@Override
	public String friendOne(String fEmail) {
		return dao.friendOne(sqlSession, fEmail);
	};

	

}
