package kh.mark.jarvis.post.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.member.model.vo.Member;
import kh.mark.jarvis.post.model.vo.Attachment;
import kh.mark.jarvis.post.model.vo.JarvisComment;
import kh.mark.jarvis.post.model.vo.JarvisLike;
import kh.mark.jarvis.post.model.vo.Post;

public interface PostDao {

   int insertPost(SqlSessionTemplate sqlSession, Post post);

   int insertAttach(SqlSessionTemplate sqlSession, Attachment a);
   
   int UpdatePost(SqlSessionTemplate sqlSession, Post post);

   List<Post> selectPostList(SqlSessionTemplate sqlSession);

   List<Attachment> selectAttachList(SqlSessionTemplate sqlSession);

   int insertComment(SqlSessionTemplate sqlSession, JarvisComment comment);

   List<JarvisComment> selectCommentList(SqlSessionTemplate sqlSession);

   int insertPostLike(SqlSessionTemplate sqlSession, JarvisLike like);
   
   int insertCommentLike(SqlSessionTemplate sqlSession, JarvisLike like);

   List<JarvisLike> selectPostLike(SqlSessionTemplate sqlSession, JarvisLike like);

   List<JarvisLike> selectCommentLike(SqlSessionTemplate sqlSession, JarvisLike like);
   
   int selectPostLikeCount(SqlSessionTemplate sqlSession, JarvisLike like);

   int selectCommentLikeCount(SqlSessionTemplate sqlSession, JarvisLike like);

   int deletePostLike(SqlSessionTemplate sqlSession, JarvisLike like);

   int deleteCommentLike(SqlSessionTemplate sqlSession, JarvisLike like);

   List<Integer> selectMyLike(SqlSessionTemplate sqlSession, String memberEmail);

   List<Member> selectMemberList(SqlSessionTemplate sqlSession);

   int deletePostDeleteAttach(SqlSessionTemplate sqlSession, Post post);

   int deletePost(SqlSessionTemplate sqlSession, Post post);

   int deletePostDeleteLike(SqlSessionTemplate sqlSession, Post post);

List<Integer> myPostNoList(SqlSessionTemplate sqlSession);

List<Map<String, String>> loadCategory(SqlSessionTemplate sqlSession);


}