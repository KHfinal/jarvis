
package kh.mark.jarvis.admin.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kh.mark.jarvis.admin.model.service.AdminService;
import kh.mark.jarvis.admin.model.vo.Notify;
import kh.mark.jarvis.admin.model.vo.PageInfo;
import kh.mark.jarvis.common.Page;
import kh.mark.jarvis.member.model.service.MemberService;
import kh.mark.jarvis.post.model.vo.Attachment;
import kh.mark.jarvis.post.model.vo.Post;
import kh.mark.jarvis.schedule.controller.ScheduleController;

@SessionAttributes(value= {"siteInfo"})
@Controller
public class AdminController {
	
	private Logger logger = LoggerFactory.getLogger(ScheduleController.class);
	
	@Autowired
	private AdminService service;
	
	@Autowired
	private MemberService memberService;
	
	//커스터마이징 가능한 UI 페이지로 이동
	@RequestMapping("/admin/customizing.do")
	public String customizingView() {
		return "admin/customizingView";
	}
	
	@RequestMapping("/admin/changeMainImg.do")
	public String changeMainImg(MultipartFile mainImg,HttpServletRequest request) {
		  String saveDir=request.getSession().getServletContext().getRealPath("/resources/img");
		  String reNamedFilename=null;
		  logger.debug(mainImg.getOriginalFilename());
		  File dir = new File(saveDir);
		  if(dir.exists()==false) dir.mkdirs();
		  if(!mainImg.isEmpty()) {
			  reNamedFilename = "mainImg.jpg";  
		  }

		  try {
				mainImg.transferTo(new File(saveDir+"/"+reNamedFilename));
				logger.debug(saveDir+"/"+reNamedFilename);
		  }
		  catch(Exception e) {
				e.printStackTrace();
			}//파일업로드 끝!
		return "admin/customizingView";
	}

	@RequestMapping("/admin/updateHeader.do")
	public ModelAndView updateHeader(ModelAndView mv, PageInfo p) {
		
		logger.debug(p.toString());
		logger.debug("service가기전");
		int result = service.updateHeader(p);
		logger.debug("service갔다온후");
		String msg="헤더 커스터마이징 완료";
		String loc="/admin/customizing.do";
		if(result<=0) {
			msg = "헤더 커스터마이징 실패";
		}
		else {
			List<Map<String, Object>> mapList = memberService.loadSiteInfo();
			Map<String,Object> map = mapList.get(0);
			mv.addObject("siteInfo", map);
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		
		return mv;
	}

	@RequestMapping("/admin/updateSide.do")
	public ModelAndView updateSide(ModelAndView mv, PageInfo p) {

		int result = service.updateSide(p);
		
		String msg="사이드 커스터마이징 완료";
		String loc="/admin/customizing.do";
		if(result<=0) {
			msg = "사이드 커스터마이징 실패";
		}
		else {
			List<Map<String, Object>> mapList = memberService.loadSiteInfo();
			Map<String,Object> map = mapList.get(0);
			mv.addObject("siteInfo", map);
		}
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	
	@RequestMapping("/admin/warningContent.do")
	public ModelAndView warningContentView(ModelAndView mv) {
		
		mv.setViewName("admin/warningContent");
		return mv;
	}
	
	@RequestMapping("/admin/memberAdministration.do")
	public ModelAndView memberAdministrationView(ModelAndView mv) {
		List<Map<String,String>> mList=memberService.memberList();
		
		mv.addObject("mList",mList);
		mv.setViewName("admin/memberAdmin");
		return mv;
	}
	
	@RequestMapping("/admin/selectAllmember.do")
	@ResponseBody
	public ResponseEntity selectAllmember() throws JsonProcessingException{
		logger.debug("통신시도");
		List<Map<String, String>> mList = memberService.memberList();
		logger.debug("보내기직전");
		String json = new ObjectMapper().writeValueAsString(mList);
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		return new ResponseEntity(json, responseHeaders, HttpStatus.CREATED);
	}
	
	@RequestMapping("/admin/memberLock.do")
	public String memberLock(int memberNo, int inputNo) {
		Map map = new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("inputNo", inputNo);
		int result = service.memberLock(map);
		
		return "admin/memberAdmin";
	}
	
	@RequestMapping("/admin/memberUnlock.do")
	public String memberUnlock(int memberNo) {
		int result = service.memberUnlock(memberNo);
		return "admin/memberAdmin";
	}
	
	@RequestMapping("/admin/unlock.do")
	public String unlock() {
		int result = service.unlock();
		return "admin/memberAdmin";
	}
	
	@RequestMapping("/admin/searchMember.do")
	@ResponseBody
	public ResponseEntity searchMember(String type,String keyword) throws JsonProcessingException{
		Map map = new HashMap<>();
		map.put("type", type);
		map.put("keyword", keyword);
		List<Map<String, String>> mList = memberService.searchList(map);
		logger.debug("보내기직전");
		String json = new ObjectMapper().writeValueAsString(mList);
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		return new ResponseEntity(json, responseHeaders, HttpStatus.CREATED);
	} 
	

	@RequestMapping("/admin/notifyList.do")
	@ResponseBody
	public ResponseEntity notifyList(int cPage) throws JsonProcessingException {
		Map<String,String> map = new HashMap<>();
		int numPerPage=10;
		List<Map<String, String>> mList = service.notifyList(cPage,numPerPage);
		int totalCount = service.selectTotalcount();
		String url = "notifyList.do";
		logger.debug("totalCount : "+totalCount);
		String pageBar = new Page().getPage(cPage, numPerPage, totalCount, url);
		logger.debug("pageBar"+pageBar);
		map.put("pageBar", pageBar);
		mList.add(map);

		String json = new ObjectMapper().writeValueAsString(mList);
	
		logger.debug(json);
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		return new ResponseEntity(json, responseHeaders, HttpStatus.CREATED);
	}

	
	// 용석
	@RequestMapping("/admin/postNotify.do")
	public ModelAndView insertPostNotify(Notify notify,HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		
		String[] arr = req.getHeader("REFERER").split("/");
		String loc = "/"+arr[arr.length-2]+"/"+arr[arr.length-1];
		String msg = "신고가 정상접수되었습니다.";
		logger.debug(loc);
		int result = service.insertPostNotify(notify);
		if(result<=0) {
			msg="신고등록에 실패하였습니다.";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	@RequestMapping("/admin/notifyView.do")
	public ModelAndView notifyView(int nNo,int pNo,ModelAndView mv) {
		Notify n = service.selectNotifyInfo(nNo);
		Post p = service.selectPostInfo(pNo);
		List<Attachment> aList = service.selectAttachInfo(pNo);

		
		mv.addObject("notify", n);
		mv.addObject("post", p);
		mv.addObject("attachmentList", aList);
		mv.setViewName("admin/notifyView");
		return mv;
	}

	@RequestMapping("/admin/deletePost.do")
	public ModelAndView deletePost(int pNo,int nNo,ModelAndView mv) {
		int result = service.deletePost(pNo);
		if(result>0) {
			result = service.deleteNotify(nNo);
		}
		String msg = "신고 접수가 처리되었습니다.";
		String loc = "/admin/warningContent.do";
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/admin/rejectNotify.do")
	public ModelAndView rejectNotify(int nNo,ModelAndView mv) {
		int result = service.rejectNotify(nNo);
		String msg = "신고접수가 반려되었습니다.";
		String loc = "/admin/warningContent.do";
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}
}
