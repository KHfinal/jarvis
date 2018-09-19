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


		List<Map<String, Object>> loadSiteInfo(SqlSessionTemplate sqlSession);
		
		int myInfoUpdate(SqlSessionTemplate sqlSession, Member m);	//내정보 업데이트

		int myPFPupdate(SqlSessionTemplate sqlSession, Member m); //프로필사진 업데이트


		Member selectBlockMember(SqlSessionTemplate sqlSession, String memberEmail);


		List<Map<String, String>> searchList(SqlSessionTemplate sqlSession, Map map);


		int memberNext(SqlSessionTemplate sqlSession, int memberNo);


		Member selectMemberNo(SqlSessionTemplate sqlSession, int memberNo);


}
