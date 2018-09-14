package kh.mark.jarvis.friend.model.service;

import java.util.List;
import java.util.Map;

import kh.mark.jarvis.member.model.vo.Member;

public interface FriendService {
	/*List<Friend> selectFriendList(String member_email);*/
	List<String> selectFriendListJson(Map<String,String> map);
	String selectConcernList(String email);
	List<Member> selectMemberConcernList(String concern);
	List<Map<String,String>> selectSearch2(Map<String,Object> map);
	int friendRequest(Map<String, String> fr);
	List<String> requestList(Map<String,String> map);
	int friendAgree(Map<String, String> fr);
	int friendRefuse(Map<String, String> fr);
	List<String> friendList(Map map);
	String friendOne(String fEmail);
}
