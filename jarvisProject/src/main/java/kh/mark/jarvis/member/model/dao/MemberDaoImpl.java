package kh.mark.jarvis.member.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kh.mark.jarvis.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Override	//로그인
	public Member selectLogin(SqlSessionTemplate sqlSession, String memberEmail) {
		return sqlSession.selectOne("member.selectLogin", memberEmail);
				
	}

	@Override	//회원가입
	public int insertMember(SqlSessionTemplate sqlSession, Member member) {
		// TODO Auto-generated method stub
		return sqlSession.insert("member.insertMember",member);

	}

	@Override
	public List<Map<String,String>> memberList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("member.memberList");
	}

	@Override
	public Object memberSelectOne(SqlSessionTemplate sqlSession, String userEmail) {
		return sqlSession.selectOne("member.memberSelectOne", userEmail);
	}

	@Override
	public int memberVerify(SqlSessionTemplate sqlSession, String memberEmail) {
		return sqlSession.update("member.memberVerify", memberEmail);
	}

	@Override
	public int addInfoUpdate(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("member.addInfoUpdate",m);
	}


	@Override	//이메일 찾기
	public String emailSearch(SqlSessionTemplate sqlSession, Member member) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.emailSearch", member);
		//하나의 값을 검색 할떄에는 selectOne로  
	}

	@Override	//암호변경 이메일 전송
	public Member selectPw(SqlSessionTemplate sqlSession, String memberEmail) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.selectPw",memberEmail);
	}

	@Override	//암호변경하기
	public int pwUpdate(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.pwUpdate", m);
	}

	@Override
	public List<Map<String, Object>> loadSiteInfo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("member.loadSiteInfo");
	}


	
}
