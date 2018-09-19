package kh.mark.jarvis.friend.model.service;

import java.util.List;
import java.util.Map;

import kh.mark.jarvis.member.model.vo.Member;

public interface FriendService {
	/*List<Friend> selectFriendList(String member_email);*/
	List<Member> selectFriendListJson(Map<String,String> map);
	String selectConcernList(String email);
	List<Member> selectMemberConcernList(String concern);
	List<Member> selectRecognizableList(String email);
	List<Member> selectSearch2(Map<String,String> map);
	List<Member> selectCheckFriend(String email);
	int friendRequest(Map<String, String> fr);
	List<Map<String,Object>> requestList(Map<String,String> map);
	int friendAgree(Map<String, String> fr);
	int friendRefuse(Map<String, String> fr);
	List<Map<String,Object>> friendList(Map<String,String> map);
	String friendOne(String fEmail);
	List<Map<String,Object>> autoFriendList(Map<String,String> map);
}
