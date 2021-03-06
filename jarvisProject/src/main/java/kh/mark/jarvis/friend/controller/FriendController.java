package kh.mark.jarvis.friend.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
			System.out.println("친구접속목록 " + a);
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
		
		System.out.println("email : " + email);
		for(int i =0; i<concernArr.length;i++) {
			concern = concernArr[i];
			System.out.println("관심사 : "+ concern);
			List<Member> memberConcernList = friendService.selectMemberConcernList(concern);
			System.out.println("memberConcernList : " + memberConcernList);
			/*System.out.println("memberConcernList 크기: "+ memberConcernList.size());*/
			
			for(int j=0;j<memberConcernList.size();j++){
				
				System.out.println("memberConcernList["+j+"] " + memberConcernList.get(j).getMemberEmail());
				for(int l = 0 ; l<concernCompareList.size();l++) {
					System.out.println("concernCompareList["+l+"] " + concernCompareList.get(l).getMemberEmail());
					if(memberConcernList.get(j).getMemberEmail().equals(concernCompareList.get(l).getMemberEmail())) {
						concernCompareList.remove(l);
						l--;
						continue;
					}
				}
				concernCompareList.add(memberConcernList.get(j));
				
			}
		}
		List<Member> checkFriend = friendService.selectCheckFriend(email);
		
		for(int s = 0; s <checkFriend.size();s++) {
			System.out.println("checkFriend["+s+"] " + checkFriend.get(s).getMemberEmail());
			for(int d=0;d< concernCompareList.size();d++) {
				System.out.println("concernCompareList["+d+"] " + concernCompareList.get(d).getMemberEmail());
				if(checkFriend.get(s).getMemberEmail().equals(concernCompareList.get(d).getMemberEmail())) {
					concernCompareList.remove(d);
					
					d--;
					continue;
				}
				
			}
		};
		for(int q =0; q< concernCompareList.size();q++) {
			if(concernCompareList.get(q).getMemberEmail().equals(email)) {
				concernCompareList.remove(q);
				
				if(concernCompareList.size()<=0) {
					break;
				}
				q--;
						
			}
			
		}
		for(int g =0; g< concernCompareList.size(); g++) {
			System.out.println("최종 concernCompareList["+g+"] : " + concernCompareList.get(g));
		}
		String a = "";
		try {
				a = mapper.writeValueAsString(concernCompareList);
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
		String a = "";
		try {
				a = mapper.writeValueAsString(recognizeList);
		}catch (Exception e) {
			e.getStackTrace();
		}
		return a;
	}
	@RequestMapping("/friend/friendRequestSocial.do")
	public ModelAndView friendRequestSocial(String mail, HttpSession hs) throws UnsupportedEncodingException
	{
		Member m=(Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		ModelAndView mv=new ModelAndView();
		Map<String, String> fr=new HashMap<String, String>();
		fr.put("email", email);
		fr.put("fEmail", mail);
		fr.put("p", "P");
		int result=friendService.friendRequest(fr);
		
		String msg="";
	      
	    if (result>0) 
	    {
	       msg="친구요청 메세지를 보냈습니다.";
	    } 
	    else 
	    {
	       msg="친구요청이 실패했습니다.";
	    }
	    String a = URLEncoder.encode(msg, "UTF-8");
	    mv.addObject("msg",a);
	    mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping("/friend/friendRefuseSocial.do")
	public ModelAndView friendRefuseSocial(HttpSession hs, String mail) throws UnsupportedEncodingException
	{
		ModelAndView mv=new ModelAndView();
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		Map<String, String> fr=new HashMap<String, String>();
		fr.put("email", email);
		fr.put("fEmail", mail);
		int result=friendService.friendRefuse(fr);
	      
		String msg="";
	      
	    if (result>0) 
	    {
	    	msg="친구요청이 취소되었습니다.";
	    } 
	    else 
	    {
	       msg="친구요청 취소를 실패했습니다.";
	    }
	    String a = URLEncoder.encode(msg, "UTF-8");
	    mv.addObject("msg",a);
	    mv.setViewName("jsonView");
		return mv;
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
			 System.out.println(searchKeyword +"로 가져온 값 : "+a);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return a;
	}
	
	//================================================================================================//
	//================================================================================================//
	//================================================================================================//
	//================================================================================================//
	
	@RequestMapping("/friend/friendView.do")
	public ModelAndView friendView(HttpSession hs) {
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		ModelAndView mv=new ModelAndView();
		List<Map<String,String>> list=memberService.memberFriendList(email);
		
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
		System.out.println("friendList : "+friendList);
		System.out.println("requestList : "+requestList);
		mv.addObject("friendList",friendList);
		mv.addObject("friendList1",friendList1);


		// 접속한사람 친구목록 Member로 가져옴
		List<Member> checkFriend = friendService.selectCheckFriend(email);

		mv.addObject("list",list);
		mv.addObject("checkFriend",checkFriend);
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
	public ModelAndView autoFriendList(HttpServletRequest request, HttpSession hs) throws JsonProcessingException, UnsupportedEncodingException
	{
		ModelAndView mv=new ModelAndView();
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		String search = request.getParameter("search");
		Map<String,String> map=new HashMap();
		List<Map<String,Object>> emailList=null;
		List<Map<String,Object>> emailList1=null;
		System.out.println("넘어오냐 검색어"+search);

		map.put("title", "F_MEMBER_EMAIL");
		map.put("search", search);
		map.put("email", email);
		emailList=friendService.autoFriendList(map);
		List<Map<String,String>> memberList=new ArrayList<Map<String,String>>();
		Map<String,String> list=null;
		
		if(emailList.size()>0)
		{
			for(int i=0; i<emailList.size(); i++)
			{
				list=new HashMap<String,String>();
				list.put("F_MEMBER_EMAIL", (String)emailList.get(i).get("F_MEMBER_EMAIL"));
				list.put("F_FRIEND_EMAIL", (String)emailList.get(i).get("F_FRIEND_EMAIL"));
				list.put("F_STATUS", (String)emailList.get(i).get("F_STATUS"));
				list.put("MEMBER_EMAIL", (String)emailList.get(i).get("MEMBER_EMAIL"));
				list.put("MEMBER_NAME", URLEncoder.encode((String)emailList.get(i).get("MEMBER_NAME"), "UTF-8"));
				list.put("MEMBER_NICKNAME", URLEncoder.encode((String)emailList.get(i).get("MEMBER_NICKNAME"), "UTF-8"));
				list.put("MEMBER_PFP", URLEncoder.encode((String)emailList.get(i).get("MEMBER_PFP"), "UTF-8"));
				memberList.add(list);
			}
			System.out.println("memberList : "+memberList);
			
		}
		
		map.put("title", "F_FRIEND_EMAIL");
		emailList1=friendService.autoFriendList(map);
		if(emailList1.size()>0)
		{
			for(int i=0; i<emailList.size(); i++)
			{
				list=new HashMap<String,String>();
				list.put("F_MEMBER_EMAIL", (String)emailList1.get(i).get("F_MEMBER_EMAIL"));
				list.put("F_FRIEND_EMAIL", (String)emailList1.get(i).get("F_FRIEND_EMAIL"));
				list.put("F_STATUS", (String)emailList1.get(i).get("F_STATUS"));
				list.put("MEMBER_EMAIL", (String)emailList1.get(i).get("MEMBER_EMAIL"));
				list.put("MEMBER_NAME", URLEncoder.encode((String)emailList1.get(i).get("MEMBER_NAME"), "UTF-8"));
				list.put("MEMBER_NICKNAME", URLEncoder.encode((String)emailList1.get(i).get("MEMBER_NICKNAME"), "UTF-8"));
				list.put("MEMBER_PFP", URLEncoder.encode((String)emailList.get(i).get("MEMBER_PFP"), "UTF-8"));
				memberList.add(list);
			}
		}
		
		mv.addObject("memberList",  memberList);
		mv.setViewName("jsonView");
		return mv;
	}
	
	
}
