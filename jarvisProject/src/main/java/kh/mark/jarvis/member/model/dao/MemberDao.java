package kh.mark.jarvis.member.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.member.model.vo.Member;

public interface MemberDao {
	
	Member selectLogin(SqlSessionTemplate sqlSession, String memberEmail); //로그인
	
	
	int insertMember(SqlSessionTemplate sqlSession, Member member);  //회원추가

	
	
	List<Map<String,String>> memberList(SqlSessionTemplate sqlSession);		//회원리스트


	Object memberSelectOne(SqlSessionTemplate sqlSession, String userEmail);


	int memberVerify(SqlSessionTemplate sqlSession, String memberEmail);


	int addInfoUpdate(SqlSessionTemplate sqlSession, Member m);

		//이메일 찾기 
		String emailSearch(SqlSessionTemplate sqlSession, Member member);

		//비밀번호 찾기
		Member selectPw(SqlSessionTemplate sqlSession, String memberEmail);


		int pwUpdate(SqlSessionTemplate sqlSession, Member m);	//암호 변경


}
