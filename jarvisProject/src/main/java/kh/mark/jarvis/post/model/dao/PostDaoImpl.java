package kh.mark.jarvis.post.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kh.mark.jarvis.member.model.vo.Member;
import kh.mark.jarvis.post.model.vo.Attachment;
import kh.mark.jarvis.post.model.vo.JarvisComment;
import kh.mark.jarvis.post.model.vo.JarvisLike;
import kh.mark.jarvis.post.model.vo.Post;

@Repository
public class PostDaoImpl implements PostDao {
	
	//기훈 형
	@Override
	public List<Map<String, String>> loadCategory(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("post.loadCategory");
	}
	
	//용
	/* post 등록 */
	@Override
	public int insertPost(SqlSessionTemplate sqlSession, Post post) {
		return sqlSession.insert("post.insertPost", post);
	}

	@Override
	public int insertAttach(SqlSessionTemplate sqlSession, Attachment a) {
		return sqlSession.insert("post.insertAttach", a);
	}

	/* Post, Comment 수정 삭제 */
	@Override
	public int updatePost(SqlSessionTemplate sqlSession, Post post) {
		return sqlSession.update("post.updatePost", post);
	}

	@Override
	public int deleteAttach(SqlSessionTemplate sqlSession, int postNo) {
		return sqlSession.delete("post.deleteAttach", postNo);
	}

	@Override
	public int deletePost(SqlSessionTemplate sqlSession, int postNo) {
		return sqlSession.delete("post.deletePost", postNo);
	}
	
	@Override
	public int updateComment(SqlSessionTemplate sqlSession, JarvisComment comment) {
		return sqlSession.update("post.updateComment", comment);
	}

	@Override
	public int deleteComment(SqlSessionTemplate sqlSession, int commentNo) {
		return sqlSession.delete("post.deleteComment", commentNo);
	}

	/* post 조회 */
	@Override
	public List<Post> selectPostList(SqlSessionTemplate sqlSession, String memberEmail) {
		return sqlSession.selectList("post.selectPostList", memberEmail);
	}

	@Override
	public List<Attachment> selectAttachList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("post.selectAttachList");
	}

	/* comment 등록 */
	@Override
	public int insertComment(SqlSessionTemplate sqlSession, JarvisComment comment) {
		return sqlSession.insert("post.insertComment", comment);
	}

	/* comment 조회 */
	@Override
	public List<JarvisComment> selectCommentList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("post.selectCommentList");
	}

	/* Like 등록 및 조회 */
	@Override
	public int insertPostLike(SqlSessionTemplate sqlSession, JarvisLike like) {
		return sqlSession.insert("post.insertPostLike", like);
	}

	@Override
	public int insertCommentLike(SqlSessionTemplate sqlSession, JarvisLike like) {
		return sqlSession.insert("post.insertCommentLike", like);
	}

	@Override
	public List<JarvisLike> selectPostLike(SqlSessionTemplate sqlSession, JarvisLike like) {
		return sqlSession.selectList("post.selectPostLike", like);
	}

	@Override
	public List<JarvisLike> selectCommentLike(SqlSessionTemplate sqlSession, JarvisLike like) {
		return sqlSession.selectList("post.selectCommentLike", like);
	}

	@Override
	public int selectPostLikeCount(SqlSessionTemplate sqlSession, JarvisLike like) {
		return sqlSession.selectOne("post.selectPostLikeCount", like);
	}

	@Override
	public int selectCommentLikeCount(SqlSessionTemplate sqlSession, JarvisLike like) {
		return sqlSession.selectOne("post.selectCommentLikeCount", like);
	}

	// Like 삭제
	@Override
	public int deletePostLike(SqlSessionTemplate sqlSession, JarvisLike like) {
		return sqlSession.delete("post.deletePostLike", like);
	}

	@Override
	public int deleteCommentLike(SqlSessionTemplate sqlSession, JarvisLike like) {
		return sqlSession.delete("post.deleteCommentLike", like);
	}

	// 최초 로그인시 count값 받기 위한 select
	@Override
	public List<Integer> selectMyLike(SqlSessionTemplate sqlSession, String memberEmail) {
		return sqlSession.selectList("post.selectMyLike", memberEmail);
	}

	@Override
	public List<Member> selectMemberList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("post.selectMemberList");
	}

	@Override
	public List<JarvisLike> selectMyLikeOn(SqlSessionTemplate sqlSession, String memberEmail) {
		return sqlSession.selectList("post.selectMyLikeOn", memberEmail);
	}

	@Override
	public List<Map<String, Object>> startLikeCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("post.startLikeCount");
	}

	@Override
	public Member selectMyPageMember(SqlSessionTemplate sqlSession, String memberEmail) {
		return sqlSession.selectOne("post.selectMyPageMember", memberEmail);
	}

	@Override
	public List<Post> selecyMyPagePostList(SqlSessionTemplate sqlSession, String memberEmail) {
		return sqlSession.selectList("post.selecyMyPagePostList", memberEmail);
	}



}