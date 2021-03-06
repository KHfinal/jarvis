package kh.mark.jarvis.group.model.service;

import java.util.List;
import java.util.Map;

import kh.mark.jarvis.group.model.vo.Group;
import kh.mark.jarvis.group.model.vo.GroupAttachment;
import kh.mark.jarvis.group.model.vo.GroupComment;
import kh.mark.jarvis.group.model.vo.GroupLike;
import kh.mark.jarvis.group.model.vo.GroupPost;
import kh.mark.jarvis.member.model.vo.Member;
import kh.mark.jarvis.post.model.vo.Attachment;
import kh.mark.jarvis.post.model.vo.JarvisLike;
import kh.mark.jarvis.post.model.vo.Post;

public interface GroupService {

	List<Map<String, String>> myGroupList(String mEmail);
	
	int groupInsert(Group g, String[] g_category);
	List<Map<String, String>> selectGroupList();
	List<Map<String, String>> selectCategory();
	List<Map<String, String>> groupSearch(String titleSearch);
	List<Map<String, String>> groupFilter(String category);
	List<GroupPost> groupView(int groupNo);
	int insertGroupPost(GroupPost post, List<GroupAttachment> attList);
	List<GroupAttachment> selectAttachList(int groupNo);
	int insertComment(GroupComment comment);
	List<GroupComment> selectCommentList();
	List<Map<String, String>> selectGroupMember(int groupNo);
	
	List<Map<String, String>> selectGroupEnroll(int groupNo);
	
	List<Map<String, String>> selectAcceptMember(int groupNo);
	
	Group groupViewDetail(int groupNo);

	int groupMemberInsert(Map groupM);
	
	List<Member> selectMemberList();
	
	int deleteGroupPost(int postNo);

	int insertGroupPostLike(GroupLike like);
	List<GroupLike> selectGroupPostLike(GroupLike like);
	int selectGroupPostLikeCount(GroupLike like);
	
	int insertGroupCommentLike(GroupLike like);
	List<GroupLike> selectGroupCommentLike(GroupLike like);
	int selectGroupCommentLikeCount(GroupLike like);
	
	int updateGroupPost(GroupPost post, List<GroupAttachment> attList);
	int deleteGroupPostLike(GroupLike like);
	int deleteGroupCommentLike(GroupLike like);
	List<Integer> selectMyLike(String memberEmail);
	List<Integer> myPostNoList();
	
	List<GroupLike> selectMyLikeOn(String memberEmail);

	List<Map<String, Object>> startLikeCount();
	
	int groupMemberAccept(Map rm);
	int groupMemberReject(Map rm);
	
	int groupMemberDelete(String mEmail);
	
	Map<String, String> selectMemberCheck(Map check);
	
	int deleteGroup(int groupNo);
	int deleteComment(int commentNo);
}
