package kh.mark.jarvis.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sun.mail.util.logging.MailHandler;

import kh.mark.jarvis.member.model.service.MemberService;
import kh.mark.jarvis.member.model.vo.Member;
@SessionAttributes(value= {"memberLoggedIn","siteInfo"})
@Controller
public class MemberController { 
	
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JavaMailSender mailSender;
	//암호화
	@Autowired
	BCryptPasswordEncoder BCPE;
	
	private static List<String> sessionList = new ArrayList<>();
	
	
	// 로그인 정보
	@RequestMapping(value="/member/login.do",method=RequestMethod.POST)
	public ModelAndView memberLogin(String memberEmail, String memberPw) {
		Member m = memberService.selectLogin(memberEmail);  //1.회원의 메일정보를 가지고 service의 selectOne으로 이동
		//2.member.member.xml에 다녀온후 아래로 진행
		ModelAndView mv = new ModelAndView();
		
		
		String msg="";
		String loc="";
		
		//아래는 값이 들어오는지 확인 하는것
		logger.debug("Member : " + m);
		System.out.println("Membercontroller : "+m);
		
		//아이디 존재확인
		if(m==null)
		{
				logger.debug("실패실패");
				msg="존재하지 않는 아이디 입니다.";
		}
		else
		{		
			//비밀번호확인
			if (BCPE.matches(memberPw, m.getMemberPw()))
			{
				if(m.getVerify().equals("Y")) {//인증확인 인증이 된 멤버만 로그인가능
					logger.debug("로그인성공");
					List<Map<String, Object>> mapList = memberService.loadSiteInfo();
					Map<String,Object> map = mapList.get(0);
					logger.debug(map.toString());
					
					msg="로그인 성공";
					mv.addObject("siteInfo", map);
					mv.addObject("memberLoggedIn", m);
					sessionList.add(m.getMemberEmail());
					loc="/post/socialHomeView.do";
				}
				else {//인증되지 않은 회원은 인증을 부탁하는 메세지를 띄어주고 로그인 불가
					msg="이메일 인증 후 로그인해주세요";
					loc="/";
				}
				
			} 
			//비밀번호 오류
			else 
			{
				msg="비밀번호가 일치하지 않습니다.";
				loc="/";
			}
				
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg"); //원래 common/header
		return mv;
	}

	//로그인화면에서 회원가입 페이지로
	@RequestMapping("/member/memberEnroll.do")
	public String memberEnroll() 
	{
			return "member/memberEnroll";
	}
		
	//회원가입 정보를 가지고 데이터베이스에 자료 넣기
	@RequestMapping("memberEnrollEnd.do")
	public String memberEnrollEnd(Member member, Model model,HttpServletRequest req) 
	{
		
		//2.암호화하기
		String oriPw=member.getMemberPw(); //암호화 전
		String enPw=BCPE.encode(oriPw);	   //암호화 후
		System.out.println(enPw);	
		member.setMemberPw(enPw);	//암호화 처리한것을 pw에 저장
				
		int result=memberService.insertMember(member); //회원가입 서비스로 이동
		
		String msg="";
		String loc="/";
		
		if (result>0) 
		{
			msg="회원가입을 성공하였습니다.이메일 인증 후 로그인 해주세요";
			sendMail(member,req);
		} 
		else 
		{
			msg="회원가입에 실패하였습니다.";
			loc="/views/member/memberEnroll.jsp";
		}
		
		
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		
		return "common/msg";
	}
	
	public void sendMail(Member member,HttpServletRequest req) {
		logger.debug(member.getMemberEmail());
		String setfrom = "kkh9180@gmail.com";         
	    String tomail  = member.getMemberEmail();     // 받는 사람 이메일
	    String title   = "Jarvis 이메일인증";      // 제목
	    String content = "<h1>"+member.getMemberName()+"님!<h1>";    // 내용
	    String domain = "localhost";
	    if(!req.getLocalAddr().equals("0:0:0:0:0:0:0:1"))//만약 자기 자신이 주소가 아니면
	    	domain=req.getLocalAddr();//서버의 주소로 링크를 보냅니다.
	    
	    content += "<h2>jarvis 계정 인증 메일입니다.링크를 눌러 인증해주세요<h2>";    // 내용
	    content += "<a href='http://"+domain+":9090/jarvis/member/memberVerify?memberEmail="+member.getMemberEmail()+
	    		"'>jarvis 계정 인증하기</a>";
	    try {
	    	
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(tomail);     // 받는사람 이메일
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	      messageHelper.setText(content,true);  // 메일 내용,true하면 html형식으로 보내진다.
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	    
	}
	
	// mailForm
	  @RequestMapping(value = "/member/memberVerify")
	  public ModelAndView mailForm(String memberEmail,ModelAndView mv) {
		  int result=0;
		  String msg = "메일인증 완료. 해당 계정으로 로그인 해주세요";
		  String loc = "/";
		  
		  Member m = memberService.selectLogin(memberEmail);
		  if(m.getVerify().equals("N")) {
			  result = memberService.memberVerify(memberEmail);
			  if(result<=0) {
				  msg="메일인증 실패 재시도해주세요";
			  }
		  }
		  else {
			msg="이미 인증된 회원입니다. 해당 계정으로 로그인 해주세요.";  
		  }
		  
		  mv.addObject("msg", msg);
		  mv.addObject("loc", loc);
		  mv.setViewName("common/msg");
		  
		  return mv;
	  }
	  
	  @RequestMapping("/member/checkDuplicate.do")
		public void duplicateId(String userEmail, HttpServletResponse response) throws IOException { // Ajax에서 data{key, value}방식으로 전송.
			boolean flag = memberService.selectOne(userEmail) != null ? true : false; // id중복의 true
			response.getWriter().println(flag); // 요청 페이지에 flag값 던져주기
		}
	  
	  @RequestMapping("/member/addInfoUpdate.do")
	  public ModelAndView addInfoUpdate(Member m,ModelAndView mv,MultipartFile profileFile1,HttpServletRequest request) {
		  logger.debug(m.toString());
		  logger.debug(profileFile1.getOriginalFilename());
		  String saveDir=request.getSession().getServletContext().getRealPath("/resources/profileImg");
		  String reNamedFilename=null;
		  File dir = new File(saveDir);
		  if(dir.exists()==false) dir.mkdirs();
		  if(!profileFile1.isEmpty()) {
			  String originalFilename=profileFile1.getOriginalFilename();
			  String ext=originalFilename.substring(originalFilename.lastIndexOf(".")+1);
			  reNamedFilename = m.getMemberEmail()+"_profileImg"+"."+ext;
			  
		  }else {//이미지를 선택 안한다면 기본 이미지를 띄어줘야한다.
			  reNamedFilename="profileDefault.png";
		  }
		  m.setMemberPFP(reNamedFilename);
		  int result = memberService.addInfoUpdate(m);
		  logger.debug("rename 후 멤버객체:"+m.toString());
		  String msg = "추가정보 입력 완료";
		  String loc="/post/socialHomeView.do";
		  if(result>0) {//디비에 업데이트가 되면 파일을 저장한다.
			  try {
				if(!reNamedFilename.equals("profileDefault.png"))//단 프로필이미지를 선택하지 않았을 때는 파일을 저장하지 않는다.
					profileFile1.transferTo(new File(saveDir+"/"+reNamedFilename));
				}catch(Exception e) {
					e.printStackTrace();
				}//파일업로드 끝!
			  
		  }
		  else { 
			  msg="추가정보 입력 오류";
			  //loc로 가서 만약 addinfo가 Y가 아니면 어차피 다시 입력 창으로 돌아온다.
		  }
		  Member member = memberService.selectLogin(m.getMemberEmail());
		  mv.addObject("memberLoggedIn",member);
		  mv.addObject("msg", msg);
		  mv.addObject("loc",loc);
		  mv.setViewName("common/msg");
		  
		  return mv;
		  
		  
	  }
	  
	//이메일 찾기 페이지로 이동
		@RequestMapping("/member/forgotEmail.do")
		public String forget() 
		{
			
			return "member/forgotEmail";
		}
		
		
		//패스워드 찾기 페이지로 이동
		@RequestMapping("/member/forgotPw.do")
		public String forgetPw() 
		{
				return "member/forgotPw";
		}

		
		
		//이메일 찾기시작   //모델엔뷰 방식
		@RequestMapping("/emailSearch.do")
		public ModelAndView emailSearch(Member member) 
		{
			logger.debug("전달 받은 이름:"+member.getMemberName());
			logger.debug("전달 받은 이름:"+member.getPhone());
			ModelAndView mv = new ModelAndView(); 
		
						
			//화면으로 뿌리기 시작 mv.addjoject에 담아
			String email = memberService.emailSearch(member); //이메일 찾기
			
			mv.setViewName("member/forgotEmailEnd");	//jsp이름
			mv.addObject("emailSearch", email);	//뷰에 전송 할 이름에 email을 담아서  
			return mv;
		}
		
		

		//패스워드 찾기 시작 
		@RequestMapping(value="/PwSearch.do")
		public ModelAndView pwSearch(String memberEmail) {
			

				//1.xml까지 보내기
				Member pwSearch=memberService.selectPw(memberEmail); //비밀번호 찾기
				
				//2.xml까지 다녀왔음  아래 진행
				ModelAndView mv = new ModelAndView();
				String msg="";
				String loc="/";
				
				
				
				if (pwSearch == null) 
				{
					msg="등록된 이메일이 없습니다.";
					loc="/member/forgotPw.do";
				} 
				else 
				{
					msg="이메일 발송완료";
					pwSendMail(pwSearch);	//메소드 호출
					
				}
				mv.addObject("msg",msg);
				mv.addObject("loc",loc);
				mv.setViewName("common/msg");
				return mv;
			}
		
		//이메일 보내보자...
		public void pwSendMail(Member member) {
			
				
			logger.debug("이메일 보내기"+member.getMemberEmail());
			
			String setfrom = "rudtjr0601jp@gmail.com";         
		    String tomail  = member.getMemberEmail();     // 받는 사람 이메일
		    String title   = "Jarvis 암호변경메일입니다";      // 제목
		    String content = "<h1>"+member.getMemberName()+"님!<h1>";    // 내용
		    
		    
		    
		    content += "<h2>jarvis 해당 링크를 누르시면 암호변경 페이지로 이동됩니다.<h2>";    // 내용
		    content += "<a href='http://localhost:9090/jarvis/member/pwUpdateView.do?memberEmail="+member.getMemberEmail()+
		    		"'>jarvis password 변경 하기</a>";
		    
		    try {
		    	
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper 
		                        = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
		      messageHelper.setTo(tomail);     // 받는사람 이메일
		      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
		      messageHelper.setText(content,true);  // 메일 내용,true하면 html형식으로 보내진다.
		     
		      mailSender.send(message);
		    } catch(Exception e){
		      System.out.println(e);
		    }
		   
		}
		
	
		
		
		//유저메일에서 - > 패스워드 찾기 페이지로 이동 
		@RequestMapping("/member/pwUpdateView.do")
		public ModelAndView pwUpdateView(Member m) 
		{
			ModelAndView mv = new ModelAndView();
			mv.addObject("memberEmail",m.getMemberEmail());
			System.out.println("페이지 이동후 암호변경하기?"+m.getMemberEmail());
			mv.setViewName("member/pwUpdate");
			
			return mv; //--->폴더이름/jsp명 
		}
		
		
			//비밀번호 변경 시작하기
		  @RequestMapping("/member/pwUpdate.do")
		  public ModelAndView pwUpdate(Member m,HttpServletRequest request) {
			  
			  logger.debug("유저가 이메일 변경 시도 "+m.getMemberEmail());
			 
				//암호화하기
				String oriPw=m.getMemberPw(); //암호화 전
				String enPw=BCPE.encode(oriPw);	   //암호화 후
				System.out.println(enPw);	
				m.setMemberPw(enPw);	//암호화 처리한것을 pw에 저장					
			  
				
			  int result = memberService.pwUpdate(m);
			  logger.debug("rename 후 멤버객체:"+m.toString());
	
			  ModelAndView mv = new ModelAndView();
			  
			  String msg ="";
			  String loc="";
			  
			  if(result>0) {//디비에 업데이트가 되면 파일을 저장한다.
				  
				  msg ="암호 변경 완료!";
				  //로그인 홈으로 돌아가기
			  }
			  else { 
				  msg="암호 변경 실패";
				  //페이지 머물기
			  }
			  
			 /* Member member = memberService.selectLogin(m.getMemberEmail());
			  mv.addObject("memberLoggedIn",member);*/
			  mv.addObject("msg", msg);
			  mv.addObject("loc",loc);
			  mv.setViewName("common/msg");
			  
			  return mv;
			  
			  
		  }
		  
		  @RequestMapping("/member/logout.do")
		  public String logout(SessionStatus ss) {
			  if(!ss.isComplete()) ss.setComplete();
				
			return "redirect:/";
		  }
	  
		//내 정보 보기 - 메인 상단바에서 클릭시 정보보기 페이지로 이동
		//내 정보 보기 - 메인 상단바에서 클릭시 정보보기 페이지로 이동
	        @RequestMapping(value="/myInfoView.do", method=RequestMethod.GET )
	         public ModelAndView myInfoView(String member_email,ModelAndView mv) 
	         {
	            
	        //	System.out.println("********************"+member_email);
	        	//List<Member> m= (List<Member>) memberService.selectLogin(memberEmail); //xml까지 보낸 후 
	        	Member member = memberService.selectLogin(member_email);
	        	
	        	mv.addObject("memberLoggedIn", member);
	        	mv.addObject("member", member);
	            mv.setViewName("member/myInfoView"); //--->폴더이름/jsp명
	            
	            return mv;
	         }

	           //내 정보 수정 - memberinfoview에서 클릭시 
	           @RequestMapping(value="/myInfoUpdateView.do")
	         public ModelAndView myInfoUpdateView(String member_email,ModelAndView mv) 
	         {
	       	   Member member = memberService.selectLogin(member_email);
	           	mv.addObject("member", member);
	        	mv.setViewName("member/myInfoUpdateView"); //jsp로 쏘세요 //--->폴더이름/jsp명 
	            
	        	return mv; 
	         }
	         
	           
	           	//내 정보 수정 시작  - updateview에서 수정 클릭시 
			  	@RequestMapping("/myinfoUpdate.do") 
			  	public ModelAndView myinfoUpdate(Member m, HttpServletRequest request) 
			  	{
			  		
			  		int myInfo = memberService.myInfoUpdate(m);
			  		
			  		
			  		ModelAndView mv = new ModelAndView();
			  		
			  		String msg="정보수정 완료!";
			  		String loc="/myInfoView.do?member_email="+m.getMemberEmail();
			  		if(myInfo<=0) {
			  			msg = "정보수정 실패";
			  		}
			  		
			  		mv.addObject("msg", msg);
			  		mv.addObject("loc",loc);
			  		
			  		mv.setViewName("common/msg");
			  		return mv;
			  	}
			  	
			  	
			  	//myInfoPFP.do
			  	//내 프로필 사진 보기,
			  	@RequestMapping("/myInfoPFP.do")
			  	public ModelAndView myinfoPFP(String member_email,ModelAndView mv)
			  	{
			  		Member member = memberService.selectLogin(member_email);
		           	mv.addObject("member", member);
		        	mv.setViewName("member/myInfoPFP");
		        	return mv;
			  	}
			  	
			  	//프로필사진 업로드 하기
			  	@RequestMapping("/myInfoPFPupdate.do")
			  	public ModelAndView myinfoPFPupdate(Member m,ModelAndView mv, MultipartFile profileFile1,HttpServletRequest request) throws IOException
			  	{
			  		  String saveDir=request.getSession().getServletContext().getRealPath("/resources/profileImg");
					  String reNamedFilename=null;
					  File dir = new File(saveDir);
					  if(dir.exists()==false) dir.mkdirs();
					  if(!profileFile1.isEmpty()) {
						  String originalFilename=profileFile1.getOriginalFilename();
						  String ext=originalFilename.substring(originalFilename.lastIndexOf(".")+1);
						  reNamedFilename = m.getMemberEmail()+"_profileImg"+"."+ext;
					  }else {//이미지를 선택 안한다면 기본 이미지를 띄어줘야한다.
						  reNamedFilename="profileDefault.png";
					  }
					  m.setMemberPFP(reNamedFilename);
					  
			  		  int result = memberService.myPFPupdate(m);	
			  		  String msg="프로필 사진 저장 성공";
			  		  String loc="/myInfoView.do?member_email="+m.getMemberEmail();
			  		  
			  		  if (result>0)
			  		  {
			  			try {
							if(!reNamedFilename.equals("profileDefault.png"))//단 프로필이미지를 선택하지 않았을 때는 파일을 저장하지 않는다.
								profileFile1.transferTo(new File(saveDir+"/"+reNamedFilename)); //파일 저장
						  }catch(Exception e) {
								e.printStackTrace();
						   }//파일업로드 
			  		  } 
			  		  else
			  		  {
			  			msg="사진 업로드 실패";
			  			loc="/member/myInfoPFP.do";
			  		  }
			  		  
			  		mv.addObject("msg", msg);
					mv.addObject("loc",loc);
					mv.setViewName("common/msg");  
		        	return mv;
			  	
			  	}
			  	
			  
			  	//패스워드 변경 페이지로 이동
			  	@RequestMapping("/myinfoPwView.do")
			  	public ModelAndView myinfoPwView(String member_email,ModelAndView mv) 
			  	{
			  		Member member = memberService.selectLogin(member_email);
		           	mv.addObject("member", member);
		        	mv.setViewName("member/myInfoPwView");
		        	return mv;
			  	}
			  	
			  	
			  	
			  	
			  	//패스워드 변경 시작/
			  	@RequestMapping("/myinfoPwUpdate.do")
				  public ModelAndView myinfoPw(Member m,HttpServletRequest request) {
					  
					 // logger.debug("유저가 이메일 변경 시도 "+m.getMemberEmail());
					 
						//암호화하기
						String oriPw=m.getMemberPw(); //암호화 전
						String enPw=BCPE.encode(oriPw);	   //암호화 후
						System.out.println(enPw);	
						m.setMemberPw(enPw);	//암호화 처리한것을 pw에 저장					
					  
						
					  int result = memberService.pwUpdate(m);
					  logger.debug("rename 후 멤버객체:"+m.toString());
			
					  ModelAndView mv = new ModelAndView();
					  
					  String msg ="";
					  String loc="/myInfoView.do?member_email="+m.getMemberEmail();
					  
					  if(result>0) {//디비에 업데이트가 되면 파일을 저장한다.
						  
						  msg ="암호 변경 완료";
						  
					  }
					  else { 
						  msg="암호 변경 실패";
						  //페이지 머물기
					  }
					  
					 /* Member member = memberService.selectLogin(m.getMemberEmail());
					  mv.addObject("memberLoggedIn",member);*/
					  mv.addObject("msg", msg);
					  mv.addObject("loc",loc);
					  mv.setViewName("common/msg");
					  
					  return mv;
					  
					  
				  }
				  
			  	
           
           
           
           
}
