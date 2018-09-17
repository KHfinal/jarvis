package kh.mark.jarvis.group.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kh.mark.jarvis.group.model.vo.Group;
import kh.mark.jarvis.group.model.vo.GroupAttachment;
import kh.mark.jarvis.group.model.vo.GroupComment;
import kh.mark.jarvis.group.model.vo.GroupLike;
import kh.mark.jarvis.group.model.vo.GroupPost;
import kh.mark.jarvis.member.model.vo.Member;

@Repository
public class GroupDaoImpl implements GroupDao {

	
	
	
	@Override
	public int groupMemberDelete(SqlSessionTemplate Session, String mEmail) {
		// TODO Auto-generated method stub
		return Session.delete("group.groupMemberDelete", mEmail);
	}

	@Override
	public int groupMemberAccept(SqlSessionTemplate Session, String mEmail) {
		// TODO Auto-generated method stub
		return Session.update("group.groupMemberAccept", mEmail);
	}

	@Override
	public List<Map<String, String>> selectGroupEnroll(SqlSessionTemplate Session, int groupNo) {
		// TODO Auto-generated method stub
		return Session.selectList("group.selectGroupEnroll", groupNo);
	}

	@Override
	public List<Map<String, String>> myGroupList(SqlSessionTemplate Session, String mEmail) {
		// TODO Auto-generated method stub
		return Session.selectList("group.myGroupList", mEmail);
	}

	@Override
	public int groupInsert(SqlSessionTemplate Session, Group g) {
	
		return Session.insert("group.groupInsert", g);
	}

	@Override
	public List<Map<String, String>> selectGroupList(SqlSessionTemplate Session) {
		
		return Session.selectList("group.selectGroupList");
	}

	@Override
	public List<Map<String, String>> groupSearch(SqlSessionTemplate Session, String titleSearch) {
		
		return Session.selectList("group.groupSearch", titleSearch);
	}

	@Override
	public List<Map<String, String>> groupFilter(SqlSessionTemplate Session, String category) {
		
		return Session.selectList("group.groupFilter", category);
	}

	@Override
	public List<GroupPost> groupView(SqlSessionTemplate Session, int groupNo) {
		
		return Session.selectList("group.groupView", groupNo);
	}
	

	@Override
	public List<GroupAttachment> selectAttachList(SqlSessionTemplate Session, int groupNo) {
		
		return Session.selectList("group.selectAttachList", groupNo);
	}

	@Override
	public int categoryInsert(SqlSessionTemplate Session, Map cat) {
		
		return Session.insert("group.categoryInsert", cat);
	}

	@Override
	public int groupMasterInsert(SqlSessionTemplate Session, Map master) {
		// TODO Auto-generated method stub
		return Session.insert("group.groupMasterInsert", master);
	}

	@Override
	public List<Map<String, String>> selectCategory(SqlSessionTemplate Session) {
		
		return Session.selectList("group.selectCategory");
	}

	@Override
	public int insertGroupPost(SqlSessionTemplate Session, GroupPost post) {
		
		return Session.insert("group.insertGroupPost", post);
	}

	@Override
	public int insertAttach(SqlSessionTemplate Session, GroupAttachment a) {
		
		return Session.insert("group.insertAttach", a);
	}

	@Override
	public int insertComment(SqlSessionTemplate Session, GroupComment comment) {
		
		return Session.insert("group.insertComment", comment);
	}

	@Override
	public List<GroupComment> selectCommentList(SqlSessionTemplate Session) {
		
		return Session.selectList("group.selectCommentList");
	}
	

	@Override
	public List<Map<String, String>> selectGroupMember(SqlSessionTemplate Session, int groupNo) {
		
		return Session.selectList("group.selectGroupMember", groupNo);
	}
	

	@Override
	public Group groupViewDetail(SqlSessionTemplate Session, int groupNo) {
		// TODO Auto-generated method stub
		return Session.selectOne("group.groupViewDetail", groupNo);
	}

	@Override
	public int insertGroupPostLike(SqlSessionTemplate Session, GroupLike like) {
		// TODO Auto-generated method stub
		return Session.insert("group.insertGroupPostLike", like);
	}

	@Override
	public List<GroupLike> selectGroupPostLike(SqlSessionTemplate Session, GroupLike like) {
		// TODO Auto-generated method stub
		return Session.selectList("group.selectGroupPostLike", like);
	}

	@Override
	public int selectGroupPostLikeCount(SqlSessionTemplate Session, GroupLike like) {
		// TODO Auto-generated method stub
		return Session.selectOne("group.selectGroupPostLikeCount", like);
	}

	@Override
	public int insertGroupCommentLike(SqlSessionTemplate Session, GroupLike like) {
		// TODO Auto-generated method stub
		return Session.insert("group.insertGroupCommentLike", like);
	}

	@Override
	public List<GroupLike> selectGroupCommentLike(SqlSessionTemplate Session, GroupLike like) {
		// TODO Auto-generated method stub
		return Session.selectList("group.selectGroupCommentLike", like);
	}

	@Override
	public int selectGroupCommentLikeCount(SqlSessionTemplate Session, GroupLike like) {
		// TODO Auto-generated method stub
		return Session.selectOne("group.selectGroupCommentLikeCount", like);
	}

	@Override
	public int groupMemberInsert(SqlSessionTemplate Session, Map groupM) {
		// TODO Auto-generated method stub
		return Session.insert("group.groupMemberInsert", groupM);
	}

	@Override
	public List<Member> selectMemberList(SqlSessionTemplate Session) {
		// TODO Auto-generated method stub
		return Session.selectList("group.selectMemberList");
	}

	@Override
	public int deleteGroupPost(SqlSessionTemplate Session, int postNo) {
		
		return Session.delete("group.deleteGroupPost", postNo);
	}

	
	@Override
	public int UpdateGroupPost(SqlSessionTemplate Session, GroupPost post) {
		// TODO Auto-generated method stub
		return Session.update("group.UpdateGroupPost", post);
	}

	@Override
	public int deleteGroupPostDeleteAttach(SqlSessionTemplate Session, GroupPost post) {
		// TODO Auto-generated method stub
		return Session.delete("group.deleteGroupPostDeleteAttach", post);
	}

	@Override
	public int deleteGroupPostLike(SqlSessionTemplate Session, GroupLike like) {
		// TODO Auto-generated method stub
		return Session.delete("group.deleteGroupPostLike", like);
	}

	@Override
	public int deleteGroupCommentLike(SqlSessionTemplate Session, GroupLike like) {
		// TODO Auto-generated method stub
		return Session.delete("group.deleteGroupCommentLike", like);
	}

	@Override
	public List<Integer> selectMyLike(SqlSessionTemplate Session, String memberEmail) {
		// TODO Auto-generated method stub
		return Session.selectList("group.selectMyLike", memberEmail);
	}

	@Override
	public List<Integer> myPostNoList(SqlSessionTemplate Session) {
		// TODO Auto-generated method stub
		return Session.selectList("group.myPostNoList");
	}
	
	
	

	
	
	

	
}
