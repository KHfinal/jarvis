package kh.mark.jarvis.friend.controller;

import java.io.UnsupportedEncodingException;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kh.mark.jarvis.friend.model.service.FriendService;
import kh.mark.jarvis.member.model.service.MemberService;
import kh.mark.jarvis.member.model.vo.Member;

@Controller
public class FriendController{
	private Logger logger = LoggerFactory.getLogger(FriendController.class);
	
	@Autowired
	private FriendService friendService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/friend/selectFriendListJson.do")
	public @ResponseBody String selectFriendList(String email,ModelAndView mv){
		Map<String,String> map=new HashMap();
		map.put("title", "F_MEMBER_EMAIL");
		map.put("email", email);
		List<Member> friendList=friendService.selectFriendListJson(map);
		map.put("title", "F_FRIEND_EMAIL");
		List<Member> friendList1=friendService.selectFriendListJson(map);
		ObjectMapper mapper=new ObjectMapper();
		if(friendList.size()>0) {
			for(int i=0;i<friendList1.size();i++)
			{
				if(!friendList.contains(friendList1.get(i)))
				{
					friendList.add(friendList1.get(i));	
				}
			}
		}
		else
		{
			friendList=friendList1;
		}
		//mv.addObject("requestList",requestList);
		String a ="";
		try {
			a = mapper.writeValueAsString(friendList);
			System.out.println("a : " + a);
		}catch (Exception e) {
		}
		
		
		return a;
	}
	@RequestMapping("/friend/concernRecommendList.do")
	public @ResponseBody String concernRecommend(String email,ModelAndView mv) {
		List<Member> concernCompareList=new ArrayList();
		ObjectMapper mapper=new ObjectMapper();
		String concernString = friendService.selectConcernList(email);
		String[] concernArr = concernString.split(",");
		
		String concern ="";
		
		for(int i =0; i<concernArr.length;i++) {
			concern = concernArr[i];
			List<Member> memberConcernList = friendService.selectMemberConcernList(concern);
			System.out.println("memberConcernList : " + memberConcernList);
			/*System.out.println("memberConcernList 크기: "+ memberConcernList.size());*/
			
			for(int j=0;i<memberConcernList.size();j++){
				if(j==memberConcernList.size()) {
					break;
				}else {
					if(!(concernCompareList.contains(memberConcernList.get(j)))) {
						
						concernCompareList.add(memberConcernList.get(j));
					}
				}
			}
		}
		String a = "";
		try {
			a = mapper.writeValueAsString(concernCompareList);
			System.out.println("a : " + a);
		}catch (Exception e) {
			e.getMessage();
		}
		
		return a;
	}
	@RequestMapping("/friend/recognizableRecommendList.do")
	public @ResponseBody String recognizableRecommend(String email,ModelAndView mv) {
		List<Member> concernCompareList=new ArrayList();
		ObjectMapper mapper=new ObjectMapper();
		
		List<Member> recognizeList = friendService.selectRecognizableList(email);
		System.out.println("recognizeList : " + recognizeList);
			
			
		/*for(int j=0;i<memberConcernList.size();j++){
			if(j==memberConcernList.size()) {
				break;
			}else {
				if(!(concernCompareList.contains(memberConcernList.get(j)))) {
					
					concernCompareList.add(memberConcernList.get(j));
				}
			}
		}
	*/
		String a = "";
		try {
			a = mapper.writeValueAsString(recognizeList);
			System.out.println("a : " + a);
		}catch (Exception e) {
		}
		
		return a;
	}
	
	@RequestMapping("/friend/friendSearch.do")
	public @ResponseBody String friendSearch(String searchType,String searchKeyword) {
		System.out.println("searchType : " + searchType);
		System.out.println("searchKeyword : " + searchKeyword);
		ObjectMapper mapper=new ObjectMapper();
		Map<String,String> map=new HashMap<String,String>();
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		List<Member> list= friendService.selectSearch2(map);
		String a ="";
		 try {
			 a = mapper.writeValueAsString(list);
			 logger.debug(a);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		
		return a;
	}
	
	
	@RequestMapping("/friend/friendView.do")
	public ModelAndView friendView(HttpSession hs) {
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		ModelAndView mv=new ModelAndView();
		List<Map<String,String>> list=memberService.memberList();
		
		Map<String,String> map=new HashMap();
		map.put("title", "F_MEMBER_EMAIL");
		map.put("email", email);
		List<Map<String,Object>> requestList=friendService.requestList(map);
		List<Map<String,Object>> friendList=friendService.friendList(map);
		map.put("title", "F_FRIEND_EMAIL");
		List<Map<String,Object>> requestList1=friendService.requestList(map);
		List<Map<String,Object>> friendList1=friendService.friendList(map);
		
		mv.addObject("requestList",requestList);		//본인 이메일이 f_member_email일때
		mv.addObject("requestList1",requestList1);		//본인 이메일이 f_friend_email일때

		mv.addObject("friendList",friendList);
		mv.addObject("friendList1",friendList1);
		/*if(friendList.size()>0) {
			for(int i=0;i<friendList1.size();i++)
			{
				if(!friendList.contains(friendList1.get(i)))
				{
					friendList.add(friendList1.get(i));	
				}
			}
		}
		else
		{
			friendList=friendList1;
		}*/
		System.out.println("asdasdasdasdasdasdasdasda"+friendList);
		mv.addObject("list",list);
		mv.setViewName("friend/friendSearch");
		
		return mv;
	}
	
	@RequestMapping("/friend/chattingFriend.do")
	public ModelAndView chattingFriend(HttpSession hs) {
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		ModelAndView mv=new ModelAndView();
		//List<Map<String,String>> friendList=friendService.friendList(email);
		//mv.addObject("friendList",friendList);
		mv.setViewName("chat/chattingView");
		
		return mv;
	}	
	@RequestMapping("/friend/friendRequest.do")
	public ModelAndView friendRequest(String fEmail, HttpSession hs)
	{
		Member m=(Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		System.out.println("----------------------"+fEmail);
		System.out.println(email);
		ModelAndView mv=new ModelAndView();
		Map<String, String> fr=new HashMap<String, String>();
		fr.put("email", email);
		fr.put("fEmail", fEmail);
		fr.put("p", "P");
		System.out.println("-------------"+fr.get(1));
		int result=friendService.friendRequest(fr);
		
		String msg="";
	    String loc="/";
	      
	    if (result>0) 
	    {
	       msg="친구요청 메세지를 보냈습니다.";
	       loc="/friend/friendView.do";
	    } 
	    else 
	    {
	       msg="친구요청이 실패했습니다.";
	       loc="/friend/friendView.do";
	    }
	    mv.addObject("email",email);
	    mv.addObject("msg",msg);
	    mv.addObject("loc",loc);
	    mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/friend/friendAgree.do")
	public ModelAndView friendAgree(HttpSession hs, String mEmail)
	{
		ModelAndView mv=new ModelAndView();
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		Map<String, String> fr=new HashMap<String, String>();
		fr.put("email", email);
		fr.put("mEmail", mEmail);
		fr.put("y", "Y");
		System.out.println("들어가?"+fr);
		int result=friendService.friendAgree(fr);
		System.out.println(result);
		String msg="";
	    String loc="/";
	      
	    if (result>0) 
	    {
	       msg="친구요청이 수락되었습니다.";
	       loc="/friend/friendView.do";
	    } 
	    else 
	    {
	       msg="친구요청이 실패했습니다.";
	       loc="/friend/friendView.do";
	    }
	    mv.addObject("msg",msg);
	    mv.addObject("loc",loc);
	    mv.setViewName("common/msg");
		return mv;
	}
		
	@RequestMapping("/friend/friendRefuse.do")
	public ModelAndView friendRefuse(HttpSession hs, String mEmail)
	{
		ModelAndView mv=new ModelAndView();
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		Map<String, String> fr=new HashMap<String, String>();
		fr.put("email", email);
		fr.put("fEmail", mEmail);
		int result=friendService.friendRefuse(fr);
		String msg="";
	    String loc="/";
	      
	    if (result>0) 
	    {
	       msg="친구요청이 취소되었습니다.";
	       loc="/friend/friendView.do";
	    } 
	    else 
	    {
	       msg="취소를 실패했습니다.";
	       loc="/friend/friendView.do";
	    }
	    mv.addObject("msg",msg);
	    mv.addObject("loc",loc);
	    mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/friend/autoFriendList")
	public ModelAndView autoFriendList(HttpServletRequest request, HttpSession hs)
	{
		ModelAndView mv=new ModelAndView();
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		String search = request.getParameter("search");
		Map<String,String> map=new HashMap();
		List<Map<String,Object>> emailList=null;
		List<Map<String,Object>> emailList1=null;
		System.out.println("넘어오냐 검색어"+search);
		/*List<Map<String,Object>> friendList=null;
		List<Map<String,Object>> friendList1=null;
		if(!search.trim().isEmpty())
		{*/
			map.put("title", "F_MEMBER_EMAIL");
			map.put("search", search);
			map.put("email", email);
			emailList=friendService.autoFriendList(map);
			map.put("title", "F_FRIEND_EMAIL");
			emailList1=friendService.autoFriendList(map);
		/*}
		else
		{
			map.put("title", "F_MEMBER_EMAIL");
			map.put("email", email);
			friendList=friendService.friendList(map);
			map.put("title", "F_FRIEND_EMAIL");
			friendList1=friendService.friendList(map);
		}*/
		mv.addObject("emailList", emailList);
		mv.addObject("emailList1", emailList1);
		/*mv.addObject("friendList", friendList);
		mv.addObject("friendList1", friendList1);*/
		mv.setViewName("jsonView");
		return mv;
	}
}
