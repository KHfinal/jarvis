package kh.mark.jarvis.admin.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.server.authentication.HttpBasicServerAuthenticationEntryPoint;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kh.mark.jarvis.admin.model.service.AdminService;
import kh.mark.jarvis.admin.model.service.AdminServiceImpl;
import kh.mark.jarvis.admin.model.vo.PageInfo;
import kh.mark.jarvis.member.model.vo.Member;
import kh.mark.jarvis.schedule.controller.ScheduleController;

@Controller
public class AdminController {
	
	private Logger logger = LoggerFactory.getLogger(ScheduleController.class);
	
	@Autowired
	private AdminService service;
	
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
		int result = service.updateHeader(p);
		
		String msg="헤더 커스터마이징 완료";
		String loc="/admin/customizing.do";
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		
		return mv;
	}

	
	@RequestMapping("/admin/warningContent.do")
	public ModelAndView warningContentView(ModelAndView mv) {
		return mv;
	}
	
	@RequestMapping("/admin/memberAdministration.do")
	public ModelAndView memberAdministrationView(ModelAndView mv) {
		return mv;
	}
	
}
