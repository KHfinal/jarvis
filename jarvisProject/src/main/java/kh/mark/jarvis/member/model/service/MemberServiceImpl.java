package kh.mark.jarvis.member.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mark.jarvis.member.model.dao.MemberDao;
import kh.mark.jarvis.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao memberDao;
	
	@Override	//로그인
	public Member selectLogin(String memberEmail) {
		// TODO Auto-generated method stub
		return memberDao.selectLogin(sqlSession,memberEmail);
	}

	@Override	//회원가입
	public int insertMember(Member member) {
		// TODO Auto-generated method stub
		return memberDao.insertMember(sqlSession,member);
	}

	@Override
	public List<Map<String,String>> memberList() {
		// TODO Auto-generated method stub
		return memberDao.memberList(sqlSession);
	}

	@Override
	public Object selectOne(String userEmail) {
		return memberDao.memberSelectOne(sqlSession,userEmail);
	}

	@Override
	public int memberVerify(String memberEmail) {
		return memberDao.memberVerify(sqlSession,memberEmail);
	}

	@Override
	public int addInfoUpdate(Member m) {

		return memberDao.addInfoUpdate(sqlSession,m);
	}
	
	@Override	//이메일 찾기
	public String emailSearch(Member member) {
		// TODO Auto-generated method stub
		return memberDao.emailSearch(sqlSession,member);
	}

	@Override //이메일로 암호 변경유도
	public Member selectPw(String memberEmail) {
		// TODO Auto-generated method stub
		return memberDao.selectPw(sqlSession,memberEmail);
	}

	@Override	//암호변경하기
	public int pwUpdate(Member m) {
		// TODO Auto-generated method stub
		return memberDao.pwUpdate(sqlSession,m);
	}

	@Override
	public List<Map<String, Object>> loadSiteInfo() {
		return memberDao.loadSiteInfo(sqlSession);
	}

	@Override	//내 정보 수정
	public int myInfoUpdate(Member m) {
		// TODO Auto-generated method stub
		return memberDao.myInfoUpdate(sqlSession,m);
	}

	@Override
	public int myPFPupdate(Member m) {
		// TODO Auto-generated method stub
		return memberDao.myPFPupdate(sqlSession,m);
	}

	@Override
	public Member selectBlockMember(String memberEmail) {
		return memberDao.selectBlockMember(sqlSession,memberEmail);
	}

	@Override
	public List<Map<String, String>> searchList(Map map) {
		return memberDao.searchList(sqlSession,map);
	}

}
