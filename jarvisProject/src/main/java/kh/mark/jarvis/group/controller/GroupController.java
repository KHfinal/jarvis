package kh.mark.jarvis.group.controller;

import java.io.File;
import java.io.IOError;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
            /*?쒕쾭???대떦寃쎈줈???뚯씪??? ?ν븯??紐낅졊*/
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
   public ModelAndView groupView(int groupNo, HttpSession hs, HttpServletRequest request) {
      ModelAndView mv=new ModelAndView();
      System.out.println("asdfsadfasdfasdfasdfasdfasdfasdf"+groupNo);
      
      Member m = (Member)hs.getAttribute("memberLoggedIn");
      String mEmail = m.getMemberEmail();
      
      Map check=new HashMap();
	  check.put("groupNo", groupNo);
	  check.put("mEmail", mEmail);
	  
	  mv.addObject("host", request.getRemoteAddr());
      
      logger.debug("멤버 세션 이메일"+mEmail);
      
      List<GroupPost> postList = service.groupView(groupNo); // 전체 Post
      Group g = service.groupViewDetail(groupNo);
      System.out.println(g);
      List<GroupAttachment> attachmentList = service.selectAttachList(groupNo); 
      List<GroupComment> commentList = service.selectCommentList();
      List<Member> memberList = service.selectMemberList();
      List<Integer> myLikeList = service.selectMyLike(m.getMemberEmail());
      
      List<Map<String, String>> gmList = service.selectAcceptMember(groupNo);
      
      List<Map<String, String>> gMemberList = service.selectGroupMember(groupNo);
      Map<String, String> groupMemberCheck = service.selectMemberCheck(check);
      List<Map<String, String>> groupEnrollList = service.selectGroupEnroll(groupNo);
      
      /*logger.debug(groupMemberCheck.toString());*/
      logger.debug(postList.toString());
      int memberCheck=0;
      
      logger.debug("멤버 그룹 디테일 : "+g.toString());
      logger.debug(commentList.toString());
      logger.debug("멤버 리스트"+memberList.toString());
      for(int i=0;i<gMemberList.size();i++) {
         logger.debug("그룹 멤버 셀렉트"+gMemberList.get(i).values().toString());
         logger.debug("그룹 멤버 셀렉트"+gMemberList.get(i));
         logger.debug("그룹 멤버 셀렉트"+gMemberList.get(i).containsValue(mEmail));
         
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
      
      if (myLikeList.size() == 0) {
			int flagCnt = 1;
			mv.addObject("flagCnt", flagCnt);
	  }
      
      if(postList != null && attachmentList != null) {
         mv.addObject("postList", postList);
         mv.addObject("attachmentList", attachmentList);
         
      }
      
      if(groupMemberCheck != null) {
    	 mv.addObject("groupMemberCheck", groupMemberCheck);  
      }
      
      mv.addObject("gmList", gmList);
      mv.addObject("groupEnrollList", groupEnrollList);
      mv.addObject("g", g);
      mv.addObject("commentList", commentList);
      mv.addObject("memberList", memberList);
      mv.addObject("gMemberList", gMemberList);
      mv.addObject("groupNo", groupNo);
      mv.setViewName("group/groupView");
      
      return mv;
   }
   
   @RequestMapping("/group/insertGroupPost.do")
   public ModelAndView insertGroupPost(GroupPost post, MultipartFile[] upFile, HttpServletRequest request) {
      logger.debug(post.getG_post_writer());
      logger.debug(post.getG_post_contents());
      logger.debug("그룹 번호"+post.getG_no());
      
      int groupNo= Integer.parseInt(post.getG_no());

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
      
      logger.debug("게시글 등록하고 그룹 번호 가져오기 : "+groupNo);
      
      String msg="";
      String loc="";
      
      if(result>0) {
         msg = "POST를 성공적으로 등록하였습니다.";
         loc = "/group/groupView.do?groupNo="+groupNo;
      } else {
         msg = "POST 등록이 실패하였습니다.";
         loc = "/group/groupView.do?groupNo="+groupNo;
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
            msg = "그룹 가입 요청이 성공하였습니다.";
            loc = "/group/groupView.do?groupNo="+groupNo;
         } else {
            msg = "그룹 가입 요청이 실패하였습니다. 다시 시도해 주세요.";
            loc = "/group/groupView.do?groupNo="+groupNo;
         }
         
         mv.addObject("msg", msg);
         mv.addObject("loc", loc);
         
         mv.setViewName("common/msg");
         return mv;
      }
      
      @RequestMapping("/group/deleteGroupPost.do")
      public ModelAndView deleteGroupPost(int postNo, int groupNo) {
         ModelAndView mv=new ModelAndView();
         
         logger.debug(String.valueOf(postNo));
         logger.debug(String.valueOf(groupNo));
         
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
      
      // 게시물 수정
      @RequestMapping("/group/updateGroupPost.do")
      public ModelAndView postUpdate(GroupPost post, int g_no, MultipartFile[] upFile, HttpServletRequest request) throws ParseException {
         String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload/group");
         List<GroupAttachment> attList = new ArrayList<GroupAttachment>();
         
         logger.debug("게시물 업데이트 : "+post.toString());
         
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
         
         int result = service.updateGroupPost(post, attList);
         
         String msg="";
         String loc="";
         
         if(result>0) {
            msg = "POST를 성공적으로 수정하였습니다.";
            loc = "/group/groupView.do?groupNo="+post.getG_no();
         } else {
            msg = "POST 수정이 실패하였습니다.";
            loc = "/group/groupView.do?groupNo="+post.getG_no();
         }
         
         ModelAndView mv = new ModelAndView();
         
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
         logger.debug("g_like_member = " + like.getG_like_member());
         logger.debug("g_post_ref = " + like.getG_post_ref());
         logger.debug("g_comment_ref = " + like.getG_comment_ref());
         logger.debug("g_like_check = " + like.getG_like_check());
         
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
      @ResponseBody
      @RequestMapping(value="/group/likeDeleteAndSelect.do", method=RequestMethod.POST)
      public ModelAndView likeDeleteAndSelect(@ModelAttribute GroupLike like) throws Exception {
         ModelAndView mv = new ModelAndView();
         
         logger.debug("likeDeleteAndSelect.do 입장");
         logger.debug("g_like_member = " + like.getG_like_member());
         logger.debug("g_post_ref = " + like.getG_post_ref());
         logger.debug("g_comment_ref = " + like.getG_comment_ref());
         logger.debug("g_like_check = " + like.getG_like_check());
         
         List<GroupLike> likeList = new ArrayList<GroupLike>();
         
         if(like.getG_comment_ref() == 0) {
            int result = service.deleteGroupPostLike(like);
            if(result > 0) {
               likeList = service.selectGroupPostLike(like);
               
               int count = service.selectGroupPostLikeCount(like);
               System.out.println("selectPostLikeCount = " + count);
               
               mv.addObject("likeList", likeList);
               mv.addObject("count", count);
            }
         } else {
            int result = service.deleteGroupCommentLike(like);
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
      
      @ResponseBody
      @RequestMapping(value="/group/startLike.do", method=RequestMethod.POST)
      public ModelAndView startLike(HttpSession session) throws Exception {
         System.out.println("들어오니??");
         ModelAndView mv = new ModelAndView();
         Member m = (Member) session.getAttribute("memberLoggedIn");
         
         // 로그인 시 하트 검색
 		 List<GroupLike> myLikeOnList = service.selectMyLikeOn(m.getMemberEmail());
 		 
 		 for(GroupLike gl : myLikeOnList) {
 			 System.out.println("########" + gl.getG_post_ref() + "########");
 		 }

 		 // 로그인 시 count값 검색
 		 List<Map<String, Object>> startLikeCount = service.startLikeCount();
 		 
         
         mv.addObject("myLikeOnList", myLikeOnList);
         mv.addObject("startLikeCount", startLikeCount);
         
         mv.setViewName("jsonView");
         
         return mv;
      }

      @RequestMapping("/group/groupMemberAccept.do")
      public void groupMemberAccept(String mEmail, HttpServletResponse response) throws IOException {
         ModelAndView mv=new ModelAndView();
         
         logger.debug(mEmail);
         
         int result = service.groupMemberAccept(mEmail);
         
         response.setContentType("application/json;charset=utf-8");
         
         response.getWriter().println(result); 
      }
      @RequestMapping("/group/groupMemberReject.do")
      public void groupMemberReject(String mEmail, HttpServletResponse response) throws IOException {
         ModelAndView mv=new ModelAndView();
         
         logger.debug(mEmail);
         
         int result = service.groupMemberDelete(mEmail);
         
         response.setContentType("application/json;charset=utf-8");
         
         response.getWriter().println(result); 
      }
      
      @RequestMapping("/group/groupMemberDelete.do")
      public ModelAndView groupMemberDelete(String mEmail ) {
            ModelAndView mv=new ModelAndView();
         
            logger.debug("탈퇴 : "+mEmail);
            
         int result = service.groupMemberDelete(mEmail);
         
         String msg="";
         String loc="";
            
         if(result>0) {
            msg = "탈퇴에 성공하였습니다.";
            loc = "/post/socialHomeView.do";
         } else {
            msg = "탈퇴에 실패하였습니다.";
            loc = "/post/socialHomeView.do";
         }
            
            
         mv.addObject("msg", msg);
         mv.addObject("loc", loc);
            
         mv.setViewName("common/msg");
         
         return mv;
      }
      
      @RequestMapping("/group/groupMemberDelete1.do")
      public ModelAndView groupMemberDelete1(String mEmail, int groupNo) {
            ModelAndView mv=new ModelAndView();
         
            logger.debug("강퇴 : "+mEmail);
            
         int result = service.groupMemberDelete(mEmail);
         
         String msg="";
         String loc="";
            
         if(result>0) {
            msg = "회원 삭제에 성공하였습니다.";
            loc = "/group/groupView.do?groupNo="+groupNo;
         } else {
            msg = "회원 삭제에 실패하였습니다.";
            loc = "/group/groupView.do?groupNo="+groupNo;
         }
            
            
         mv.addObject("msg", msg);
         mv.addObject("loc", loc);
            
         mv.setViewName("common/msg");
         
         return mv;
      }
      
      @RequestMapping("/group/deleteGroup.do")
      public ModelAndView deleteGroup(int groupNo) {
    	  ModelAndView mv=new ModelAndView();
    	  
    	  int result = service.deleteGroup(groupNo);
    	  
    	  String msg="";
          String loc="";
             
          if(result>0) {
             msg = "그룹 삭제에 성공하였습니다.";
             loc = "/post/socialHomeView.do";
          } else {
             msg = "그룹 삭제에 실패하였습니다.";
             loc = "/post/socialHomeView.do";
          }
             
             
          mv.addObject("msg", msg);
          mv.addObject("loc", loc);
             
          mv.setViewName("common/msg");
          
          return mv;
    	 
      }
      
      @RequestMapping("/group/deleteComment.do")
  	public ModelAndView deleteComment(int commentNo, String groupNo) {
  		ModelAndView mv = new ModelAndView();

  		int result = service.deleteComment(commentNo);

  		String msg = "";
  		String loc = "";

  		if (result > 0) {
  			msg = "Comment가 성공적으로 삭제되었습니다.";
  			loc = "/group/groupView.do?groupNo="+groupNo;
  		} else {
  			msg = "Comment 삭제가 실패하였습니다.";
  			loc = "/group/groupView.do?groupNo="+groupNo;
  		}

  		mv.addObject("msg", msg);
  		mv.addObject("loc", loc);

  		mv.setViewName("common/msg");

  		return mv;
  	}

}