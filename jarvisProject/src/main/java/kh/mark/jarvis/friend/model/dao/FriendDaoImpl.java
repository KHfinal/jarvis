package kh.mark.jarvis.friend.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kh.mark.jarvis.member.model.vo.Member;
@Repository
public class FriendDaoImpl implements FriendDao{

	@Override
	public List<Member> selectFriendListJson(SqlSessionTemplate sqlSession, Map<String,String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("friend.selectFriendListJson",map);
	}
	@Override
	public String selectConcernList(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("friend.selectConcernList",email);
	}
	@Override
	public List<Member> selectMemberConcernList(SqlSessionTemplate sqlSession, String concern) {
		return sqlSession.selectList("friend.selectMemberConcernList",concern);
	}
	

	@Override
	public List<Member> selectselectCheckFriend(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectList("friend.selectCheckFriend",email);
	}
	@Override
	public List<Member> selectRecognizableList(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectList("friend.selectRecognizableList",email);
	}
	@Override
	public List<Member> selectSearch2(SqlSessionTemplate session, Map<String, String> map) {
		// TODO Auto-generated method stub
		return session.selectList("friend.keywordSearch",map);
	}
	@Override
	public int friendRequest(SqlSessionTemplate sqlSession, Map<String, String> fr) {
		System.out.println("asdasd---------------------------"+fr);
		return sqlSession.insert("friend.friendRequest",fr);
	}

	@Override
	public List<Map<String,Object>> requestList(SqlSessionTemplate sqlSession, Map<String,String> map) {
		System.out.println("dao : "+map);
		List<Map<String,Object>> list=sqlSession.selectList("friend.requestList",map);
		System.out.println("tkqnfjdkadhdsfenlwan aweihaslda sdljasndlj"+list);
		return list;
	}

	@Override
	public int friendAgree(SqlSessionTemplate sqlSession, Map<String, String> fr) {
		return sqlSession.update("friend.friendAgree",fr);
	}

	@Override
	public int friendRefuse(SqlSessionTemplate sqlSession, Map<String, String> fr) {
		System.out.println("키 : "+fr.keySet());
		System.out.println("값 : "+fr.values());
		return sqlSession.delete("friend.friendRefuse",fr);
	}

	@Override
	public List<Map<String,Object>> friendList(SqlSessionTemplate sqlSession, Map<String,String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("friend.friendList", map);
	}

	@Override
	public String friendOne(SqlSessionTemplate sqlSession, String fEmail) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("friend.friendOne",fEmail);
	}
	@Override
	public List<Map<String, Object>> autoFriendList(SqlSessionTemplate sqlSession, Map<String,String> map) {
		return sqlSession.selectList("friend.autoFriendList",map);
	}

	

}
