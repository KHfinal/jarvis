package kh.mark.jarvis.group.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.group.model.vo.Group;
import kh.mark.jarvis.group.model.vo.GroupAttachment;
import kh.mark.jarvis.group.model.vo.GroupComment;
import kh.mark.jarvis.group.model.vo.GroupLike;
import kh.mark.jarvis.group.model.vo.GroupPost;
import kh.mark.jarvis.member.model.vo.Member;

public interface GroupDao {

	List<Map<String, String>> myGroupList(SqlSessionTemplate Session, String mEmail);
	
	int groupInsert(SqlSessionTemplate Session, Group g);
	List<Map<String, String>> selectGroupList(SqlSessionTemplate Session);
	List<Map<String, String>> selectCategory(SqlSessionTemplate Session);
	List<Map<String, String>> groupSearch(SqlSessionTemplate Session, String titleSearch);
	List<Map<String, String>> groupFilter(SqlSessionTemplate Session, String category);
	List<GroupPost> groupView(SqlSessionTemplate Session, int groupNo);
	int categoryInsert(SqlSessionTemplate Session, Map cat);
	int groupMasterInsert(SqlSessionTemplate Session, Map master);
	
	int insertGroupPost(SqlSessionTemplate Session, GroupPost post);
	int insertAttach(SqlSessionTemplate Session, GroupAttachment a);
	List<GroupAttachment> selectAttachList(SqlSessionTemplate Session, int groupNo);
	int insertComment(SqlSessionTemplate Session, GroupComment comment);
	List<GroupComment> selectCommentList(SqlSessionTemplate Session);
	List<Map<String, String>> selectGroupMember(SqlSessionTemplate Session, int groupNo);
	
	List<Map<String, String>> selectAcceptMember(SqlSessionTemplate Session, int groupNo);
	List<Map<String, String>> selectGroupEnroll(SqlSessionTemplate Session, int groupNo);
	
	Group groupViewDetail(SqlSessionTemplate Session, int groupNo);
	
	int insertGroupPostLike(SqlSessionTemplate Session, GroupLike like);
	List<GroupLike> selectGroupPostLike(SqlSessionTemplate Session, GroupLike like);
	int selectGroupPostLikeCount(SqlSessionTemplate Session, GroupLike like);
	
	int insertGroupCommentLike(SqlSessionTemplate Session, GroupLike like);
	List<GroupLike> selectGroupCommentLike(SqlSessionTemplate Session, GroupLike like);
	int selectGroupCommentLikeCount(SqlSessionTemplate Session, GroupLike like);
	
	int groupMemberInsert(SqlSessionTemplate Session, Map groupM);
	List<Member> selectMemberList(SqlSessionTemplate Session);
	
	int deleteGroupPost(SqlSessionTemplate Session, int postNo);
	
	int UpdateGroupPost(SqlSessionTemplate Session, GroupPost post);
	int deleteGroupPostDeleteAttach(SqlSessionTemplate Session, GroupPost post);
	int deleteGroupPostLike(SqlSessionTemplate Session, GroupLike like);
	int deleteGroupCommentLike(SqlSessionTemplate Session, GroupLike like);
	List<Integer> selectMyLike(SqlSessionTemplate Session, String memberEmail);
	List<Integer> myPostNoList(SqlSessionTemplate Session);
	
	List<GroupLike> selectMyLikeOn(SqlSessionTemplate Session, String memberEmail);

	List<Map<String, Object>> startLikeCount(SqlSessionTemplate Session);
	
	int groupMemberAccept(SqlSessionTemplate Session, String mEmail);
	int groupMemberReject(SqlSessionTemplate Session, String mEmail);
	
	int groupMemberDelete(SqlSessionTemplate Session, String mEmail);
	
	Map<String, String> selectMemberCheck(SqlSessionTemplate Session, Map check);
	int deleteGroup(SqlSessionTemplate Session, int groupNo);
	
	int deleteComment(SqlSessionTemplate Session, int commentNo);
}
