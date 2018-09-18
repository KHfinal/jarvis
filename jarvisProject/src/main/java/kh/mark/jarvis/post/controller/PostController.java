package kh.mark.jarvis.post.controller;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kh.mark.jarvis.member.model.vo.Member;
import kh.mark.jarvis.post.model.service.PostService;
import kh.mark.jarvis.post.model.vo.Attachment;
import kh.mark.jarvis.post.model.vo.JarvisComment;
import kh.mark.jarvis.post.model.vo.JarvisLike;
import kh.mark.jarvis.post.model.vo.Post;

@SessionAttributes(value= {"categoryList"})
@Controller
public class PostController {

	private Logger logger = LoggerFactory.getLogger(PostController.class);

	@Autowired
	private PostService service;

	// 1. 게시물 조회
	@RequestMapping("/post/socialHomeView.do")
	public String selectPost(Model model, HttpSession s, HttpServletRequest request) {

		Member m = (Member) s.getAttribute("memberLoggedIn");
		List<Map<String, String>> categoryList = service.loadCategory();
		model.addAttribute("categoryList", categoryList);
		logger.debug(m.toString());
		if (m.getAddInfo().equals("N")) {

			return "member/memberInfoAdd";
		}

		// 용석
		List<Post> postList = service.selectPostList(m.getMemberEmail()); // 전체 Post
		List<Attachment> attachmentList = service.selectAttachList();
		List<JarvisComment> commentList = service.selectCommentList();
		List<Integer> myLikeList = service.selectMyLike(m.getMemberEmail()); // count 값이 0일때 빈 하트 출력을 위해 사용
		List<Member> memberList = service.selectMemberList(); // 전체 회원 리스트

		if (myLikeList.size() == 0) {
			int flagCnt = 1;
			model.addAttribute("flagCnt", flagCnt);
		}

		if (postList != null && attachmentList != null) {
			model.addAttribute("postList", postList);
			model.addAttribute("attachmentList", attachmentList);
		}

		model.addAttribute("commentList", commentList);
		model.addAttribute("myLikeList", myLikeList);
		model.addAttribute("memberList", memberList);

		String loc = "social/socialHome";

		return loc;
	}

	// 2. 게시물 등록
	@RequestMapping("/post/insertPost.do")
	public ModelAndView insertPost(Post post, MultipartFile[] upFile, HttpServletRequest request)
			throws ParseException {

		// postDate를 미리 지정해줘야한다.
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload/post");
		List<Attachment> attList = new ArrayList<Attachment>();

		File dir = new File(saveDir);
		if (dir.exists() == false)
			dir.mkdirs();

		for (MultipartFile f : upFile) {
			if (!f.isEmpty()) {
				String originalFileName = f.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);

				SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd_HHmmssSS");

				int rndNum = (int) (Math.random() * 1000);
				String renamedFileName = sdf.format(new Date(System.currentTimeMillis()));
				renamedFileName += "_" + rndNum + "." + ext;

				try {
					f.transferTo(new File(saveDir + "/" + renamedFileName));
				} catch (Exception e) {
					e.printStackTrace();
				}

				Attachment attach = new Attachment();
				attach.setOriginalFileName(originalFileName);
				attach.setRenamedFileName(renamedFileName);
				attList.add(attach);

			}
		}

		int result = service.insertPost(post, attList);

		String msg = "";
		String loc = "";

		if (result > 0) {
			msg = "POST를 성공적으로 등록하였습니다.";
			loc = "/post/socialHomeView.do";
		} else {
			msg = "POST 등록이 실패하였습니다.";
			loc = "/post/socialHomeView.do";
		}

		ModelAndView mv = new ModelAndView();

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);

		mv.setViewName("common/msg");

		return mv;
	}

	// 3. 게시물 수정
	@RequestMapping("/post/postUpdate.do")
	public ModelAndView postUpdate(Post post, MultipartFile[] upFile1, HttpServletRequest request)
			throws ParseException {
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload/post");
		List<Attachment> attList = new ArrayList<Attachment>();

		File dir = new File(saveDir);
		if (dir.exists() == false)
			dir.mkdirs();

		for (MultipartFile f : upFile1) {
			if (!f.isEmpty()) {
				String originalFileName = f.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);

				SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd_HHmmssSS");

				int rndNum = (int) (Math.random() * 1000);
				String renamedFileName = sdf.format(new Date(System.currentTimeMillis()));
				renamedFileName += "_" + rndNum + "." + ext;

				try {
					f.transferTo(new File(saveDir + "/" + renamedFileName));
				} catch (Exception e) {
					e.printStackTrace();
				}

				Attachment attach = new Attachment();
				attach.setOriginalFileName(originalFileName);
				attach.setRenamedFileName(renamedFileName);
				attach.setPostNo(post.getPostNo());
				attList.add(attach);
			}
		}

		int result = service.updatePost(post, attList); // service.UpdatePost(post, attList);

		String msg = "";
		String loc = "";

		if (result > 0) {
			msg = "POST를 성공적으로 수정하였습니다.";
			loc = "/post/socialHomeView.do";
		} else {
			msg = "POST 수정이 실패하였습니다.";
			loc = "/post/socialHomeView.do";
		}

		ModelAndView mv = new ModelAndView();

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);

		mv.setViewName("common/msg");

		return mv;
	}

	// 3-1. 댓글 수정
	@RequestMapping("/post/commentUpdate.do")
	public ModelAndView commentUpdate(int commentNo) {
		ModelAndView mv = new ModelAndView();

		System.out.println("###########################################commentNo = " + commentNo);

		return mv;
	}

	// 4. 게시물 삭제
	@RequestMapping("/post/deletePost.do")
	public ModelAndView deletePost(int postNo) {
		ModelAndView mv = new ModelAndView();

		int result = service.deletePost(postNo);

		String msg = "";
		String loc = "";

		if (result > 0) {
			msg = "POST가 성공적으로 삭제되었습니다.";
			loc = "/post/socialHomeView.do";
		} else {
			msg = "POST 삭제가 실패하였습니다.";
			loc = "/post/socialHomeView.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);

		mv.setViewName("common/msg");

		return mv;
	}

	// 4-1. 댓글 삭제
	@RequestMapping("/post/deleteComment.do")
	public ModelAndView deleteComment(int commentNo) {
		ModelAndView mv = new ModelAndView();

		int result = service.deleteComment(commentNo);

		String msg = "";
		String loc = "";

		if (result > 0) {
			msg = "Comment가 성공적으로 삭제되었습니다.";
			loc = "/post/socialHomeView.do";
		} else {
			msg = "Comment 삭제가 실패하였습니다.";
			loc = "/post/socialHomeView.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);

		mv.setViewName("common/msg");

		return mv;
	}

	// 5. 댓글 등록
	@RequestMapping(value = "/post/postCommentInsert.do", method = RequestMethod.POST)
	public ModelAndView insertComment(JarvisComment comment) {
		ModelAndView mv = new ModelAndView();

		int result = service.insertComment(comment);

		String msg = "";
		String loc = "";

		if (result > 0) {
			msg = "댓글이 성공적으로 등록되었습니다.";
			loc = "/post/socialHomeView.do";
		} else {
			msg = "댓글 등록이 실패하였습니다.";
			loc = "/post/socialHomeView.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);

		mv.setViewName("common/msg");

		return mv;
	}

	// 6. 좋아요 등록 및 조회
	@ResponseBody
	@RequestMapping(value = "/post/likeInsertAndSelect.do", method = RequestMethod.POST)
	public ModelAndView likeInsertAndSelect(@ModelAttribute JarvisLike like) throws Exception {
		ModelAndView mv = new ModelAndView();

		logger.debug("likeInsertAndSelect.do 입장");
		logger.debug("likeMember = " + like.getLikeMember());
		logger.debug("postRef = " + like.getPostRef());
		logger.debug("commentRef = " + like.getCommentRef());
		logger.debug("likeCheck = " + like.getLikeCheck());

		List<JarvisLike> likeList = new ArrayList<JarvisLike>();

		if (like.getCommentRef() == 0) { // post 좋아요 일 때
			int result = service.insertPostLike(like);
			if (result > 0) {
				likeList = service.selectPostLike(like);
				int count = service.selectPostLikeCount(like);

				mv.addObject("likeList", likeList);
				mv.addObject("count", count);
			}
		} else { // comment 좋아요일 때
			int result = service.insertCommentLike(like);
			if (result > 0) {
				likeList = service.selectCommentLike(like);
				int count = service.selectCommentLikeCount(like);

				mv.addObject("likeList", likeList);
				mv.addObject("count", count);
			}
		}

		mv.setViewName("jsonView");

		return mv;
	}

	// 7. 좋아요 삭제 및 조회
	@ResponseBody
	@RequestMapping(value = "/post/likeDeleteAndSelect.do", method = RequestMethod.POST)
	public ModelAndView likeDeleteAndSelect(@ModelAttribute JarvisLike like) throws Exception {
		ModelAndView mv = new ModelAndView();

		logger.debug("likeDeleteAndSelect.do 입장");
		logger.debug("likeMember = " + like.getLikeMember());
		logger.debug("postRef = " + like.getPostRef());
		logger.debug("commentRef = " + like.getCommentRef());
		logger.debug("likeCheck = " + like.getLikeCheck());

		List<JarvisLike> likeList = new ArrayList<JarvisLike>();

		if (like.getCommentRef() == 0) { // post 좋아요일 때
			int result = service.deletePostLike(like);
			if (result > 0) {
				likeList = service.selectPostLike(like);

				int count = service.selectPostLikeCount(like);

				mv.addObject("likeList", likeList);
				mv.addObject("count", count);
			}
		} else { // comment 좋아요일 때
			int result = service.deleteCommentLike(like);
			if (result > 0) {
				likeList = service.selectCommentLike(like);

				int count = service.selectCommentLikeCount(like);

				mv.addObject("likeList", likeList);
				mv.addObject("count", count);
			}
		}

		mv.setViewName("jsonView");

		return mv;
	}

	// 8. 최초 로그인 시 하트 상태, Count 출력
	@ResponseBody
	@RequestMapping(value = "/post/startLike.do", method = RequestMethod.POST)
	public ModelAndView startLike(HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		Member m = (Member) session.getAttribute("memberLoggedIn");

		// 로그인 시 하트 검색
		List<JarvisLike> myLikeOnList = service.selectMyLikeOn(m.getMemberEmail());

		// 로그인 시 count값 검색
		List<Map<String, Object>> startLikeCount = service.startLikeCount();

		mv.addObject("myLikeOnList", myLikeOnList);
		mv.addObject("startLikeCount", startLikeCount);

		mv.setViewName("jsonView");

		return mv;
	}
	
	@RequestMapping("/post/myPage")
	public ModelAndView myPage(HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Member m = (Member) session.getAttribute("memberLoggedIn");
		
		String memberEmail = request.getParameter("memberEmail");
		
		Member MpMember = service.selectMyPageMember(memberEmail); // 마이페이지 주인

		List<Post> postList = service.selecyMyPagePostList(memberEmail); // 마이페이지 주인의 게시물 + 주인 친구 게시물
		List<Attachment> attachmentList = service.selectAttachList();
		List<JarvisComment> commentList = service.selectCommentList();
		List<Integer> myLikeList = service.selectMyLike(m.getMemberEmail()); // count 값이 0일때 빈 하트 출력을 위해 사용
		List<Member> memberList = service.selectMemberList(); // 전체 회원 리스트
		
		if (myLikeList.size() == 0) {
			int flagCnt = 1;
			mv.addObject("flagCnt", flagCnt);
		}

		if (postList != null && attachmentList != null) {
			mv.addObject("postList", postList);
			mv.addObject("attachmentList", attachmentList);
		}
		
		mv.addObject("MpMember", MpMember);
		mv.addObject("commentList", commentList);
		mv.addObject("myLikeList", myLikeList);
		mv.addObject("memberList", memberList);
		
		
		mv.setViewName("social/myPage"); 
		
		return mv;
	}
}