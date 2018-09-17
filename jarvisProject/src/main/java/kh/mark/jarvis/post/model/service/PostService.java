package kh.mark.jarvis.post.model.service;

import java.util.List;
import java.util.Map;

import kh.mark.jarvis.member.model.vo.Member;
import kh.mark.jarvis.post.model.vo.Attachment;
import kh.mark.jarvis.post.model.vo.JarvisComment;
import kh.mark.jarvis.post.model.vo.JarvisLike;
import kh.mark.jarvis.post.model.vo.Post;

public interface PostService {

   int insertPost(Post post, List<Attachment> attList);

   int UpdatePost(Post post, List<Attachment> attList);

   List<Attachment> selectAttachList();

   List<Post> selectPostList();

   int insertComment(JarvisComment comment);

   List<JarvisComment> selectCommentList();

   int insertPostLike(JarvisLike like);
   
   int insertCommentLike(JarvisLike like);

   List<JarvisLike> selectPostLike(JarvisLike like);
   
   List<JarvisLike> selectCommentLike(JarvisLike like);

   int selectPostLikeCount(JarvisLike like);
   
   int selectCommentLikeCount(JarvisLike like);

   int deletePostLike(JarvisLike like);

   int deleteCommentLike(JarvisLike like);

   List<Integer> selectMyLike(String memberEmail);

   List<Member> selectMemberList();

   int deletePost(Post post);

   List<Integer> myPostNoList();

   List<Map<String, String>> loadCategory();





}