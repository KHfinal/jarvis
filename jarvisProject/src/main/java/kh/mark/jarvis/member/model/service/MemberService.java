package kh.mark.jarvis.member.model.service;

import java.util.List;
import java.util.Map;

import kh.mark.jarvis.member.model.vo.Member;

public interface MemberService {
	Member selectLogin(String memberEmail); //로그인

	int insertMember(Member member);	//회원가입

	List<Map<String,String>> memberList();			//회원리스트

	Object selectOne(String userEmail);

	int memberVerify(String memberEmail);

	int addInfoUpdate(Member m);
	
	String emailSearch(Member member);	//이메일 찾기

	Member selectPw(String memberEmail); //비밀번호 찾기

	int pwUpdate(Member m);	//패스워드 변경하기

	List<Map<String, Object>> loadSiteInfo();
	
	int myInfoUpdate(Member m);	//내 정보 수정

	int myPFPupdate(Member m); //프로필사진 수정

	Member selectBlockMember(String memberEmail);

	List<Map<String, String>> searchList(Map map);

	int memberNext(int memberNo);

	Member selectMemberNo(int memberNo);


	

}
