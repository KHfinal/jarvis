package kh.mark.jarvis.friend.controller;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.mark.jarvis.friend.model.service.FriendService;
import kh.mark.jarvis.friend.model.vo.Friend;
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
	public ModelAndView selectFriendList(String email,ModelAndView mv){
		Map<String,String> map=new HashMap();
		map.put("title", "F_MEMBER_EMAIL");
		map.put("email", email);
		List<String> friendList=friendService.selectFriendListJson(map);
		map.put("title", "F_FRIEND_EMAIL");
		List<String> friendList1=friendService.selectFriendListJson(map);

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

		mv.addObject("list",friendList);
		mv.setViewName("jsonView");
		
		return mv;
	}
	@RequestMapping("/friend/friednRecommendList.do")
	public ModelAndView friendRecommend(String email,ModelAndView mv) {
		List<String> concernCompareList=new ArrayList();
		
		String concernString = friendService.selectConcernList(email);
		System.out.println("concernString : "+ concernString);
		
		String[] consernArr = concernString.split(",");
		String consern ="";
		for(int i =0; i<consernArr.length;i++) {
			consern = consernArr[i];
			List<Member> memberConcernList = friendService.selectMemberConcernList(consern);
			/*System.out.println("memberConcernList 크기: "+ memberConcernList.size());*/
			
			for(int j=0;i<memberConcernList.size();j++){
				if(j==memberConcernList.size()) {
					break;
				}else {
					if(!(concernCompareList.contains(memberConcernList.get(j).getMemberEmail()))) {
						concernCompareList.add(memberConcernList.get(j).getMemberEmail());
					}
				}
			}
		        
		
		}
		System.out.println("concernCompareList : " + concernCompareList);
		mv.addObject("concernCompareList", concernCompareList);
		mv.setViewName("jsonView");
		
		return mv;
	}
	@RequestMapping("/friend/friendSearch.do")
	public ModelAndView friendSearch(String searchType,String searchKeyword ,ModelAndView mv) {
		System.out.println("searchType : " + searchType);
		System.out.println("searchKeyword : " + searchKeyword);
		Map<String,Object> map=new HashMap();
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		
		List<Map<String,String>> list=friendService.selectSearch2(map);
		System.out.println("list : " + list);
		mv.addObject("list",list);
		mv.setViewName("jsonView");
		return mv;
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
		List<String> requestList=friendService.requestList(map);
		List<String> friendList=friendService.friendList(map);
		map.put("title", "F_FRIEND_EMAIL");
		List<String> requestList1=friendService.requestList(map);
		List<String> friendList1=friendService.friendList(map);
		
		mv.addObject("requestList",requestList);		//본인 이메일이 f_member_email일때
		mv.addObject("requestList1",requestList1);		//본인 이메일이 f_friend_email일때

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
		mv.addObject("list",list);
		//mv.addObject("requestList",requestList);
		mv.addObject("friendList",friendList);
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
	
}
