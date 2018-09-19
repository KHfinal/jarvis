package kh.mark.jarvis.group.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mark.jarvis.group.model.dao.GroupDao;
import kh.mark.jarvis.group.model.vo.Group;
import kh.mark.jarvis.group.model.vo.GroupAttachment;
import kh.mark.jarvis.group.model.vo.GroupComment;
import kh.mark.jarvis.group.model.vo.GroupLike;
import kh.mark.jarvis.group.model.vo.GroupPost;
import kh.mark.jarvis.member.model.vo.Member;
import kh.mark.jarvis.post.model.vo.Attachment;

@Service
public class GroupServiceImpl implements GroupService {

	@Autowired
	private GroupDao dao;
	@Autowired
	private SqlSessionTemplate Session;
	
	
	
	
	@Override
	public int deleteComment(int commentNo) {
		// TODO Auto-generated method stub
		return dao.deleteComment(Session, commentNo);
	}

	@Override
	public int deleteGroup(int groupNo) {
		// TODO Auto-generated method stub
		return dao.deleteGroup(Session, groupNo);
	}

	@Override
	public List<GroupLike> selectMyLikeOn(String memberEmail) {
		// TODO Auto-generated method stub
		return dao.selectMyLikeOn(Session, memberEmail);
	}

	@Override
	public List<Map<String, Object>> startLikeCount() {
		// TODO Auto-generated method stub
		return dao.startLikeCount(Session);
	}

	@Override
	public List<Map<String, String>> selectAcceptMember(int groupNo) {
		// TODO Auto-generated method stub
		return dao.selectAcceptMember(Session, groupNo);
	}

	@Override
	public int groupMemberReject(String mEmail) {
		// TODO Auto-generated method stub
		return dao.groupMemberReject(Session, mEmail);
	}

	@Override
	public int groupMemberDelete(String mEmail) {
		// TODO Auto-generated method stub
		return dao.groupMemberDelete(Session, mEmail);
	}

	@Override
	public int groupMemberAccept(String mEmail) {
		// TODO Auto-generated method stub
		return dao.groupMemberAccept(Session, mEmail);
	}

	@Override
	public List<Map<String, String>> myGroupList(String mEmail) {
		// TODO Auto-generated method stub
		return dao.myGroupList(Session, mEmail);
	}

	@Override
	public int groupInsert(Group g, String[] g_category) {
		
		Map cat=new HashMap();
		Map master=new HashMap();
		int result=dao.groupInsert(Session, g);
		int g_no=g.getG_no();
		if(g_category.length>0) {
			for(int i=0;i<g_category.length;i++) {
				cat.put("g_no", g_no);
				cat.put("g_category", g_category[i]);
				dao.categoryInsert(Session, cat);
			}
		}
		String groupMaster=g.getG_master();
		master.put("g_no", g_no);
		master.put("member_email", groupMaster);
		int re=dao.groupMasterInsert(Session, master);
		return result;	
	}

	@Override
	public List<Map<String, String>> selectGroupList() {
		
		return dao.selectGroupList(Session);
	}

	@Override
	public List<Map<String, String>> groupSearch(String titleSearch) {
		
		return dao.groupSearch(Session, titleSearch);
	}

	@Override
	public List<Map<String, String>> groupFilter(String category) {
		
		return dao.groupFilter(Session, category);
	}

	@Override
	public List<GroupPost> groupView(int groupNo) {
		
		return dao.groupView(Session, groupNo);
	}
	

	@Override
	public List<GroupAttachment> selectAttachList(int groupNo) {
		
		return dao.selectAttachList(Session, groupNo);
	}

	@Override
	public List<Map<String, String>> selectCategory() {
		
		return dao.selectCategory(Session);
	}

	@Override
	public int insertGroupPost(GroupPost post, List<GroupAttachment> attList) {
		
		int result = 0;
		int postNo = 0;
		
		result = dao.insertGroupPost(Session, post);
		postNo = post.getG_post_no();
		
		if(attList.size() > 0) {
			for(GroupAttachment a : attList) {
				a.setG_post_no(postNo);
				result = dao.insertAttach(Session, a);
			}
		}
		return result;
		
	}

	@Override
	public int insertComment(GroupComment comment) {
		
		return dao.insertComment(Session, comment);
	}
	

	@Override
	public List<GroupComment> selectCommentList() {
		
		return dao.selectCommentList(Session);
	}
	

	@Override
	public List<Map<String, String>> selectGroupMember(int groupNo) {
		
		return dao.selectGroupMember(Session, groupNo);
	}

	@Override
	public Group groupViewDetail(int groupNo) {
		
		return dao.groupViewDetail(Session, groupNo);
	}

	@Override
	public int insertGroupPostLike(GroupLike like) {
		
		return dao.insertGroupPostLike(Session, like);
	}

	@Override
	public List<GroupLike> selectGroupPostLike(GroupLike like) {
		
		return dao.selectGroupPostLike(Session, like);
	}

	@Override
	public int selectGroupPostLikeCount(GroupLike like) {
		
		return dao.selectGroupPostLikeCount(Session, like);
	}

	@Override
	public int insertGroupCommentLike(GroupLike like) {
		
		return dao.insertGroupCommentLike(Session, like);
	}

	@Override
	public List<GroupLike> selectGroupCommentLike(GroupLike like) {
		
		return dao.selectGroupCommentLike(Session, like);
	}

	@Override
	public int selectGroupCommentLikeCount(GroupLike like) {
		
		return dao.selectGroupCommentLikeCount(Session, like);
	}

	@Override
	public int groupMemberInsert(Map groupM) {
		
		return dao.groupMemberInsert(Session, groupM);
	}

	@Override
	public List<Member> selectMemberList() {
		
		return dao.selectMemberList(Session);
	}
	

	@Override
	public List<Map<String, String>> selectGroupEnroll(int groupNo) {
		// TODO Auto-generated method stub
		return dao.selectGroupEnroll(Session, groupNo);
	}

	@Override
	public int deleteGroupPost(int postNo) {
		
		return dao.deleteGroupPost(Session, postNo);
	}

	@Override
	public int updateGroupPost(GroupPost post, List<GroupAttachment> attList) {
		  int result = 0;
	      int postNo = 0;
	      
	      result = dao.UpdateGroupPost(Session, post);
	      postNo = post.getG_post_no();
	      result = dao.deleteGroupPostDeleteAttach(Session, post);
	      
	      if(attList.size() > 0) {
	         for(GroupAttachment a : attList) {
	            a.setG_post_no(postNo);
	            result = dao.insertAttach(Session, a);
	         }
	      }
	      return result;
	}

	@Override
	public int deleteGroupPostLike(GroupLike like) {
		
		return dao.deleteGroupPostLike(Session, like);
	}

	@Override
	public int deleteGroupCommentLike(GroupLike like) {
		
		return dao.deleteGroupCommentLike(Session, like);
	}

	@Override
	public List<Integer> selectMyLike(String memberEmail) {
		// TODO Auto-generated method stub
		return dao.selectMyLike(Session, memberEmail);
	}

	@Override
	public List<Integer> myPostNoList() {
		// TODO Auto-generated method stub
		return dao.myPostNoList(Session);
	}

	@Override
	public Map<String, String> selectMemberCheck(Map check) {
		// TODO Auto-generated method stub
		return dao.selectMemberCheck(Session, check);
	}
	
	
	
	
	
}
