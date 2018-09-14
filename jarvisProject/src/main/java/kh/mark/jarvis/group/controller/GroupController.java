package kh.mark.jarvis.group.controller;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kh.mark.jarvis.group.model.service.GroupService;
import kh.mark.jarvis.group.model.vo.Group;
import kh.mark.jarvis.group.model.vo.GroupAttachment;
import kh.mark.jarvis.group.model.vo.GroupComment;
import kh.mark.jarvis.group.model.vo.GroupLike;
import kh.mark.jarvis.group.model.vo.GroupPost;
import kh.mark.jarvis.member.model.vo.Member;

@Controller
public class GroupController {
	
	private Logger logger=LoggerFactory.getLogger(GroupController.class);
	@Autowired
	private GroupService service;
	
	@RequestMapping("/group/myGroupList.do")
	public ModelAndView myGroupList(HttpSession hs) {
		ModelAndView mv = new ModelAndView();
		
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String mEmail = m.getMemberEmail();
		
		List<Map<String, String>> myList = service.myGroupList(mEmail);
		List<Map<String, String>> cateList=service.selectCategory();
		
		mv.addObject("list", myList);
		mv.addObject("cateList", cateList);
		mv.setViewName("group/myGroupList");
		
		return mv;
	}
	
	@RequestMapping("/group/groupList.do")
	public ModelAndView selectGroupList() {
		ModelAndView mv=new ModelAndView();
		List<Map<String, String>> list=service.selectGroupList();
		List<Map<String, String>> cateList=service.selectCategory();
		System.out.println(cateList);
		
		logger.debug("list"+list);
		mv.addObject("list", list);
		mv.addObject("cateList", cateList);
		mv.setViewName("group/groupList");
		return mv;
	}
	
	@RequestMapping("/group/groupInsert.do")
	public ModelAndView groupInsert(Group g, String[] g_category, String m, MultipartFile upFile, HttpServletRequest request) {
		
		System.out.println(g.getG_name());
		System.out.println(g.getG_intro());
		System.out.println(m);
		
		g.setG_master(m);
		
		logger.debug("寃뚯떆???낅줈??: "+upFile);
		/*?곸꽭??multipartFile?뚯븘蹂닿린*/
		logger.debug("param.group : "+g);
		logger.debug("파일 이름 : "+upFile.getName());
		logger.debug("기존 파일 이름: "+upFile.getOriginalFilename());
		logger.debug("파일 크기: "+upFile.getSize());
		
		
		String saveDir=request.getSession().getServletContext().getRealPath("/resources/upload/group");
		String renamedFileName=null;
		String originalFilename=null;
		File dir=new File(saveDir);
		if(dir.exists()==false) dir.mkdirs();
		
		if(!upFile.isEmpty()) {
			originalFilename=upFile.getOriginalFilename();
			String ext=originalFilename.substring(originalFilename.lastIndexOf(".")+1);
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSS");
			int rndNum=(int)(Math.random()*1000);
			renamedFileName=sdf.format(new Date(System.currentTimeMillis()));
			renamedFileName+="_"+rndNum+"."+ext;
			try {
				/*?쒕쾭???대떦寃쎈줈???뚯씪????ν븯??紐낅졊*/
				upFile.transferTo(new File(saveDir+"/"+renamedFileName));
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			g.setG_originalFilename(originalFilename);
			g.setG_renamedFilename(renamedFileName);
		}
		else {
			originalFilename="03-thumbnail.jpg";
			renamedFileName="20180913_001734151_740.jpg";
			g.setG_originalFilename(originalFilename);
			g.setG_renamedFilename(renamedFileName);
		}
		
		
		int result=service.groupInsert(g, g_category);
		
		ModelAndView mv=new ModelAndView();
		String msg="";
		String loc="/group/groupList.do";
		if(result>0) {
			msg="그룹이 생성되었습니다.";
		}
		else {
			msg="그룹 생성에 실패하였습니다.";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/group/groupSearch.do")
	public ModelAndView groupSearch(String titleSearch) {
		ModelAndView mv=new ModelAndView();
		logger.debug(titleSearch);
		List<Map<String, String>> list=service.groupSearch(titleSearch);
		List<Map<String, String>> cateList=service.selectCategory();
		
		mv.addObject("list", list);
		mv.addObject("cateList", cateList);
		mv.setViewName("group/groupList");
		return mv;
	}
	
	@RequestMapping("/group/groupFilter.do")
	public ModelAndView groupFilter(String category) {
		ModelAndView mv=new ModelAndView();
		logger.debug(category);
		List<Map<String, String>> list=service.groupFilter(category);
		List<Map<String, String>> cateList=service.selectCategory();
		
		mv.addObject("list", list);
		mv.addObject("cateList", cateList);
		mv.setViewName("group/groupList");
		
		return mv;
	}
	
	@RequestMapping("/group/groupView.do")
	public ModelAndView groupView(int groupNo, HttpSession hs) {
		ModelAndView mv=new ModelAndView();
		
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String mEmail = m.getMemberEmail();
		
		logger.debug("멤버 세션 이메일"+mEmail);
		
		List<GroupPost> postList = service.groupView(groupNo); // 전체 Post
		Group g = service.groupViewDetail(groupNo);
		List<GroupAttachment> attachmentList = service.selectAttachList(groupNo); 
		List<GroupComment> commentList = service.selectCommentList();
		List<Member> memberList = service.selectMemberList(); 
		
		List<Map<String, String>> gMemberList = service.selectGroupMember(groupNo);
		
		logger.debug(postList.toString());
		int memberCheck=0;
		
		logger.debug("멤버 그룹 디테일 : "+g.toString());
		logger.debug(commentList.toString());
		logger.debug(memberList.toString());
		for(int i=0;i<gMemberList.size();i++) {
			/*logger.debug("그룹 멤버 셀렉트"+gMemberList.get(i).values().toString());
			logger.debug("그룹 멤버 셀렉트"+gMemberList.get(i).get("MEMBER_EMAIL"));
			logger.debug("그룹 멤버 셀렉트"+gMemberList.get(i).containsValue(mEmail));*/
			if(gMemberList.get(i).containsValue(mEmail)) {
				memberCheck=1;
				mv.addObject("memberCheck", memberCheck);
				logger.debug("멤버 체크 :"+memberCheck);
				break;
			}
			else {
				memberCheck=0;
				mv.addObject("memberCheck", memberCheck);
				logger.debug("멤버 체크 :"+memberCheck);
			}
		
			
		}
			
		if(postList != null && attachmentList != null) {
			mv.addObject("postList", postList);
			mv.addObject("attachmentList", attachmentList);
			
		}
		
		
		
		mv.addObject("g", g);
		mv.addObject("commentList", commentList);
		mv.addObject("memberList", memberList);
		
		mv.addObject("groupNo", groupNo);
		mv.setViewName("group/groupView");
		
		return mv;
	}
	
	@RequestMapping("/group/insertGroupPost.do")
	public ModelAndView insertGroupPost(GroupPost post, MultipartFile[] upFile, HttpServletRequest request) {
		logger.debug(post.getG_post_writer());
		logger.debug(post.getG_post_contents());
		logger.debug(post.getG_no());

		for(int i=0; i<upFile.length; i++) {
			logger.debug(upFile[i].getOriginalFilename());
		}
		
		// postDate를 미리 지정해줘야한다.
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload/group");
		List<GroupAttachment> attList = new ArrayList<GroupAttachment>();
		
		File dir = new File(saveDir);
		if(dir.exists() == false) dir.mkdirs();
		
		for(MultipartFile f : upFile) {
			if(!f.isEmpty()) {
				String originalFileName = f.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);

				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd_HHmmssSS");
				
				int rndNum = (int) (Math.random() * 1000);
				String renamedFileName = sdf.format(new Date(System.currentTimeMillis()));
				renamedFileName += "_" + rndNum + "." + ext; 
				
				try {
					f.transferTo(new File(saveDir + "/" + renamedFileName));
				} catch(Exception e) {
					e.printStackTrace();
				}
				
				GroupAttachment attach = new GroupAttachment();
				attach.setG_original_filename(originalFileName);
				attach.setG_renamed_filename(renamedFileName);
				attList.add(attach);
				
			}
		}
		
		int result = service.insertGroupPost(post, attList);
		
		String msg="";
		String loc="";
		
		if(result>0) {
			msg = "POST를 성공적으로 등록하였습니다.";
			loc = "/group/groupView.do?groupNo="+post.getG_no();
		} else {
			msg = "POST 등록이 실패하였습니다.";
			loc = "/group/groupView.do?groupNo="+post.getG_no();
		}
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	// 3. 댓글 등록
		@RequestMapping(value="/group/postCommentInsert.do", method=RequestMethod.POST)
		public ModelAndView insertComment(GroupComment comment, int groupNo) {
			ModelAndView mv = new ModelAndView();
			
			logger.debug("댓글 등록 로거"+comment.toString());
			int result = service.insertComment(comment);
			
			String msg = "";
			String loc = "";
			
			if(result>0) {
				msg = "댓글이 성공적으로 등록되었습니다.";
				loc = "/group/groupView.do?groupNo="+groupNo;
			} else {
				msg = "댓글 등록이 실패하였습니다.";
				loc = "/group/groupView.do?groupNo="+groupNo;
			}
			
			mv.addObject("msg", msg);
			mv.addObject("loc", loc);
			
			mv.setViewName("common/msg");
			
			return mv;
		}
		
		// 4. 좋아요 등록 및 조회
		@ResponseBody
		@RequestMapping(value="/group/likeInsertAndSelect.do", method=RequestMethod.POST)
		public ModelAndView likeInsertAndSelect(@ModelAttribute GroupLike like) throws Exception {
			ModelAndView mv = new ModelAndView();
			
			logger.debug("likeInsertAndSelect.do 입장");
			logger.debug("likeMember = " + like.getG_like_member());
			logger.debug("postRef = " + like.getG_post_ref());
			logger.debug("commentRef = " + like.getG_comment_ref());
			logger.debug("likeCheck = " + like.getG_like_check());
			
			List<GroupLike> likeList = new ArrayList<GroupLike>();
			
			if(like.getG_comment_ref() == 0) {
				int result = service.insertGroupPostLike(like);
				if(result > 0) {
					likeList = service.selectGroupPostLike(like);
					
					int count = service.selectGroupPostLikeCount(like);
					System.out.println("selectPostLikeCount = " + count);
					
					mv.addObject("likeList", likeList);
					mv.addObject("count", count);
				}
			} else {
				int result = service.insertGroupCommentLike(like);
				if(result > 0) {
					likeList = service.selectGroupCommentLike(like);
					int count = service.selectGroupCommentLikeCount(like);
					
					System.out.println("selectCommentLikeCount = " + count);
					
					mv.addObject("likeList", likeList);
					mv.addObject("count", count);
				}
			}
			
			mv.setViewName("jsonView");
			
			return mv;
		}
		
		// 5. 좋아요 삭제 및 조회
		/*@ResponseBody
		@RequestMapping(value="/post/likeDeleteAndSelect.do", method=RequestMethod.POST)
		public ModelAndView likeDeleteAndSelect(@ModelAttribute JarvisLike like) throws Exception {
			ModelAndView mv = new ModelAndView();
			
			logger.debug("likeDeleteAndSelect.do 입장");
			logger.debug("likeMember = " + like.getLikeMember());
			logger.debug("postRef = " + like.getPostRef());
			logger.debug("commentRef = " + like.getCommentRef());
			logger.debug("likeCheck = " + like.getLikeCheck());
			
			List<JarvisLike> likeList = new ArrayList<JarvisLike>();
			
			if(like.getCommentRef() == 0) {
				int result = service.deletePostLike(like);
				if(result > 0) {
					likeList = service.selectPostLike(like);
					
					int count = service.selectPostLikeCount(like);
					System.out.println("selectPostLikeCount = " + count);
					mv.addObject("likeList", likeList);
					mv.addObject("count", count);
				}
			} else {
				int result = service.deleteCommentLike(like);
				if(result > 0) {
					likeList = service.selectCommentLike(like);
					
					int count = service.selectCommentLikeCount(like);
					System.out.println("selectCommentLikeCount = " + count);
					mv.addObject("likeList", likeList);
					mv.addObject("count", count);
				}
			}
			
			mv.setViewName("jsonView");
			
			return mv;
		}*/
		
		@RequestMapping("/group/groupMemberInsert.do")
		public ModelAndView groupMemberInsert(int groupNo, HttpSession hs) {
			ModelAndView mv=new ModelAndView();
			Member m = (Member)hs.getAttribute("memberLoggedIn");
			String mEmail = m.getMemberEmail();
			Map groupM=new HashMap();
			groupM.put("groupNo", groupNo);
			groupM.put("mEmail", mEmail);
			
			int result = service.groupMemberInsert(groupM);
			
			String msg = "";
			String loc = "";
			
			if(result>0) {
				msg = "그룹 가입이 성공하였습니다.";
				loc = "/group/groupView.do?groupNo="+groupNo;
			} else {
				msg = "그룹 가입이 실패하였습니다. 다시 시도해 주세요.";
				loc = "/group/groupView.do?groupNo="+groupNo;
			}
			
			mv.addObject("msg", msg);
			mv.addObject("loc", loc);
			
			mv.setViewName("common/msg");
			return mv;
		}
		
		@RequestMapping("/group/deleteGroupPost.do")
	      public ModelAndView deleteGroupPost(int postNo, String groupNo) {
	         ModelAndView mv=new ModelAndView();
	         
	         logger.debug(String.valueOf(postNo));
	         logger.debug(groupNo);
	         
	         int result = service.deleteGroupPost(postNo);
	         
	         String msg = "";
	         String loc = "";
	         
	         if(result>0) {
	            msg = "POST가 성공적으로 삭제되었습니다.";
	            loc = "/group/groupView.do?groupNo="+groupNo;
	         } else {
	            msg = "POST 삭제가 실패하였습니다.";
	            loc = "/group/groupView.do?groupNo="+groupNo;
	         }
	         
	         mv.addObject("msg", msg);
	         mv.addObject("loc", loc);
	         
	         mv.setViewName("common/msg");
	         return mv;
	      }
	

}
