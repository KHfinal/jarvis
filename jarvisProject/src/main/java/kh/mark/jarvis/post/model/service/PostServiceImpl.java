package kh.mark.jarvis.post.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mark.jarvis.member.model.vo.Member;
import kh.mark.jarvis.post.model.dao.PostDao;
import kh.mark.jarvis.post.model.vo.Attachment;
import kh.mark.jarvis.post.model.vo.JarvisComment;
import kh.mark.jarvis.post.model.vo.JarvisLike;
import kh.mark.jarvis.post.model.vo.Post;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostDao dao;

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 기훈 형
	@Override
	public List<Map<String, String>> loadCategory() {
		return dao.loadCategory(sqlSession);
	}

	// 용
	@Override
	public int insertPost(Post post, List<Attachment> attList) {
		int result = 0;
		int postNo = 0;

		result = dao.insertPost(sqlSession, post);
		postNo = post.getPostNo();

		if (attList.size() > 0) {
			for (Attachment a : attList) {
				a.setPostNo(postNo);
				result = dao.insertAttach(sqlSession, a);
			}
		}
		return result;
	}

	@Override
	public int updatePost(Post post, List<Attachment> attList) {
		int result = 0;
		int postNo = 0;

		result = dao.updatePost(sqlSession, post);
		postNo = post.getPostNo();
		result = dao.deleteAttach(sqlSession, postNo);

		if (attList.size() > 0) {
			for (Attachment a : attList) {
				a.setPostNo(postNo);
				result = dao.insertAttach(sqlSession, a);
			}
		}
		return result;
	}

	@Override
	public int deletePost(int postNo) {
		return dao.deletePost(sqlSession, postNo);
	}

	@Override
	public int deleteComment(int commentNo) {
		return dao.deleteComment(sqlSession, commentNo);
	}

	@Override
	public List<Post> selectPostList(String memberEmail) {
		return dao.selectPostList(sqlSession, memberEmail);
	}

	@Override
	public List<Attachment> selectAttachList() {
		return dao.selectAttachList(sqlSession);
	}

	@Override
	public int insertComment(JarvisComment comment) {
		int result = dao.insertComment(sqlSession, comment);
		return result;
	}

	@Override
	public List<JarvisComment> selectCommentList() {
		return dao.selectCommentList(sqlSession);
	}

	@Override
	public int insertPostLike(JarvisLike like) {
		int result = dao.insertPostLike(sqlSession, like);
		return result;
	}

	@Override
	public int insertCommentLike(JarvisLike like) {
		int result = dao.insertCommentLike(sqlSession, like);
		return result;
	}

	@Override
	public List<JarvisLike> selectPostLike(JarvisLike like) {
		return dao.selectPostLike(sqlSession, like);
	}

	@Override
	public List<JarvisLike> selectCommentLike(JarvisLike like) {
		return dao.selectCommentLike(sqlSession, like);
	}

	@Override
	public int selectPostLikeCount(JarvisLike like) {
		return dao.selectPostLikeCount(sqlSession, like);
	}

	@Override
	public int selectCommentLikeCount(JarvisLike like) {
		return dao.selectCommentLikeCount(sqlSession, like);
	}

	@Override
	public int deletePostLike(JarvisLike like) {
		return dao.deletePostLike(sqlSession, like);
	}

	@Override
	public int deleteCommentLike(JarvisLike like) {
		return dao.deleteCommentLike(sqlSession, like);
	}

	// 최초 로그인시 count값 받기 위한 select
	@Override
	public List<Integer> selectMyLike(String memberEmail) {
		return dao.selectMyLike(sqlSession, memberEmail);
	}

	@Override
	public List<Member> selectMemberList() {
		return dao.selectMemberList(sqlSession);
	}

	@Override
	public List<JarvisLike> selectMyLikeOn(String memberEmail) {
		return dao.selectMyLikeOn(sqlSession, memberEmail);
	}

	@Override
	public List<Map<String, Object>> startLikeCount() {
		return dao.startLikeCount(sqlSession);
	}

	// 마이페이지 멤버
	@Override
	public Member selectMyPageMember(String memberEmail) {
		return dao.selectMyPageMember(sqlSession, memberEmail);
	}

	@Override
	public List<Post> selecyMyPagePostList(String memberEmail) {
		return dao.selecyMyPagePostList(sqlSession, memberEmail);
	}

}