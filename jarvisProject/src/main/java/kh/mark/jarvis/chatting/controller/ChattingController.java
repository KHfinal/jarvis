package kh.mark.jarvis.chatting.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;

import kh.mark.jarvis.chatting.model.service.ChattingService;
import kh.mark.jarvis.chatting.model.vo.ChattingRoom;
import kh.mark.jarvis.friend.model.service.FriendService;
import kh.mark.jarvis.member.model.vo.Member;

@Controller
public class ChattingController {

	@Autowired
	private FriendService friendService;
	
	@Autowired
	private ChattingService chattingService;
	
	@RequestMapping("/chat/chattingView.do")
	public String chatting(Model model, HttpSession hs, HttpServletRequest request, String fEmail)
	{
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		Map<String,String> roomMap=new HashMap();
		List<Map<String,Object>> roomListReal=new ArrayList<Map<String,Object>>();

		Map<String,Object> listMap=new HashMap<String,Object>(); 
		roomMap.put("title", "MY_EMAIL");
		roomMap.put("email", email);
		List<Map<String,Object>> roomList=chattingService.roomList(roomMap);
		int chat_no=0;
		int chat_no1=0;
		if(roomList.size()>0) {
			for(int i=0; i<roomList.size(); i++)
			{
				Map<String,Object> rMap = new HashMap<>();
				for(int j=0; j<roomList.size(); j++)
				{
					chat_no=Integer.parseInt((String.valueOf(roomList.get(i).get("CHAT_NO"))));
					chat_no1=Integer.parseInt((String.valueOf(roomList.get(j).get("CHAT_NO"))));
					if(roomList.get(i).get("ROOM_NO").equals(roomList.get(j).get("ROOM_NO")))
					{
						rMap.put("ROOM_NO", roomList.get(j).get("ROOM_NO"));
						rMap.put("CHAT_NO", roomList.get(j).get("CHAT_NO"));
						rMap.put("MY_EMAIL", roomList.get(j).get("MY_EMAIL"));
						rMap.put("FRIEND_EMAIL", roomList.get(j).get("FRIEND_EMAIL"));
						rMap.put("MEMBER_EMAIL", roomList.get(j).get("MEMBER_EMAIL"));
						rMap.put("MEMBER_NAME", roomList.get(j).get("MEMBER_NAME"));
						rMap.put("MEMBER_PFP", roomList.get(j).get("MEMBER_PFP"));
						rMap.put("WRITER", roomList.get(j).get("WRITER"));
						rMap.put("MESSAGE", roomList.get(j).get("MESSAGE"));
						rMap.put("WRITER_DATE", roomList.get(j).get("WRITER_DATE"));
						rMap.put("READ", roomList.get(j).get("READ"));
	
						System.out.println("listMap : "+listMap);
						System.out.println("--------------------------");
						
					}
					
				}
				if(roomList.get(i).get("CHAT_NO").equals(rMap.get("CHAT_NO")))
				{
					roomListReal.add(rMap);
					System.out.println("roomListReal : "+roomListReal);
					System.out.println("--------------------------");
					
				}
			}
		}
		roomMap.put("title", "FRIEND_EMAIL");
		List<Map<String,Object>> roomList1=chattingService.roomList(roomMap);
		if(roomList1.size()>0) {
			for(int i=0; i<roomList1.size(); i++)
			{
				Map<String,Object> rMap1 = new HashMap<>();
				for(int j=0; j<roomList1.size(); j++)
				{
					chat_no=Integer.parseInt((String.valueOf(roomList1.get(i).get("CHAT_NO"))));
					chat_no1=Integer.parseInt((String.valueOf(roomList1.get(j).get("CHAT_NO"))));
					if(roomList1.get(i).get("ROOM_NO").equals(roomList1.get(j).get("ROOM_NO")))
					{
						rMap1.put("ROOM_NO", roomList1.get(j).get("ROOM_NO"));
						rMap1.put("CHAT_NO", roomList1.get(j).get("CHAT_NO"));
						rMap1.put("MY_EMAIL", roomList1.get(j).get("MY_EMAIL"));
						rMap1.put("FRIEND_EMAIL", roomList1.get(j).get("FRIEND_EMAIL"));
						rMap1.put("MEMBER_EMAIL", roomList1.get(j).get("MEMBER_EMAIL"));
						rMap1.put("MEMBER_NAME", roomList1.get(j).get("MEMBER_NAME"));
						rMap1.put("MEMBER_PFP", roomList1.get(j).get("MEMBER_PFP"));
						rMap1.put("WRITER", roomList1.get(j).get("WRITER"));
						rMap1.put("MESSAGE", roomList1.get(j).get("MESSAGE"));
						rMap1.put("WRITER_DATE", roomList1.get(j).get("WRITER_DATE"));
						rMap1.put("READ", roomList1.get(j).get("READ"));
	
						System.out.println("listMap : "+listMap);
						System.out.println("--------------------------");
					}
				}
				if(roomList1.get(i).get("CHAT_NO").equals(rMap1.get("CHAT_NO")))
				{
					roomListReal.add(rMap1);
					System.out.println("roomListReal : "+roomListReal);
					System.out.println("--------------------------");
					
				}
			}
		}
		
		System.out.println("roomListReal : "+roomListReal);
		Map<String,String> map=new HashMap();
		map.put("title", "F_MEMBER_EMAIL");
		map.put("email", email);
		List<Map<String,Object>> friendList=friendService.friendList(map);
		map.put("title", "F_FRIEND_EMAIL");
		List<Map<String,Object>> friendList1=friendService.friendList(map);
		model.addAttribute("roomListReal",roomListReal);
		model.addAttribute("friendList",friendList);
		model.addAttribute("friendList1",friendList1);
		
		return "chat/chattingView";
	}
	
	@RequestMapping("/chat/createRoom")
	public String createRoom(Model model, HttpSession hs, HttpServletRequest request, String fEmail)
	{
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		Map<String,String> roomMap=new HashMap();
		
		/*채팅방찾기-----------------------------------------------------*/
		//Map<String,String> roomMap=new HashMap();
		roomMap.put("mytitle", "MY_EMAIL");
		roomMap.put("ftitle", "FRIEND_EMAIL");
		roomMap.put("myEmail", email);
		roomMap.put("fEmail", fEmail);
		ChattingRoom selectRoom=chattingService.selectRoom(roomMap);

		roomMap.put("mytitle", "FRIEND_EMAIL");
		roomMap.put("ftitle", "MY_EMAIL");
		ChattingRoom selectRoom1=chattingService.selectRoom(roomMap);
		if(selectRoom==null) {
			selectRoom=selectRoom1;
		}
		/*if(selectRoom!=null)
		{
			roomMap.put("mEmail", email);
			roomMap.put("fEmail", fEmail);
			roomMap.put("roomNo", roomNo);
			//int readResult=chattingService.readCheck(roomMap);
		}*/
		
		/*채팅방생성-----------------------------------------------------*/
		int result=0;
		if(selectRoom==null)
		{
			roomMap.put("my_email", email);
			roomMap.put("friend_email", fEmail);
			result=chattingService.createRoom(roomMap);
			roomMap.put("mytitle", "MY_EMAIL");
			roomMap.put("ftitle", "FRIEND_EMAIL");
			roomMap.put("myEmail", email);
			roomMap.put("fEmail", fEmail);
			selectRoom=chattingService.selectRoom(roomMap);
		}
		
		/*채팅방목록-----------------------------------------------------*/
		
		List<Map<String,Object>> roomListReal=new ArrayList<Map<String,Object>>();
		
		Map<String,Object> listMap=new HashMap<String,Object>(); 
		roomMap.put("title", "MY_EMAIL");
		roomMap.put("email", email);
		List<Map<String,Object>> roomList=chattingService.roomList(roomMap);
		int chat_no=0;
		int chat_no1=0;
		if(roomList.size()>0) {
			for(int i=0; i<roomList.size(); i++)
			{
				Map<String,Object> rMap = new HashMap<>();
				for(int j=0; j<roomList.size(); j++)
				{
					chat_no=Integer.parseInt((String.valueOf(roomList.get(i).get("CHAT_NO"))));
					chat_no1=Integer.parseInt((String.valueOf(roomList.get(j).get("CHAT_NO"))));
					if(roomList.get(i).get("ROOM_NO").equals(roomList.get(j).get("ROOM_NO")))
					{
						rMap.put("ROOM_NO", roomList.get(j).get("ROOM_NO"));
						rMap.put("CHAT_NO", roomList.get(j).get("CHAT_NO"));
						rMap.put("MY_EMAIL", roomList.get(j).get("MY_EMAIL"));
						rMap.put("FRIEND_EMAIL", roomList.get(j).get("FRIEND_EMAIL"));
						rMap.put("MEMBER_EMAIL", roomList.get(j).get("MEMBER_EMAIL"));
						rMap.put("MEMBER_NAME", roomList.get(j).get("MEMBER_NAME"));
						rMap.put("MEMBER_PFP", roomList.get(j).get("MEMBER_PFP"));
						rMap.put("WRITER", roomList.get(j).get("WRITER"));
						rMap.put("MESSAGE", roomList.get(j).get("MESSAGE"));
						rMap.put("WRITER_DATE", roomList.get(j).get("WRITER_DATE"));
						rMap.put("READ", roomList.get(j).get("READ"));
						
						System.out.println("rMap : "+rMap);
						System.out.println("--------------------------");
					}
				}
				if(roomList.get(i).get("CHAT_NO").equals(rMap.get("CHAT_NO")))
				{
					roomListReal.add(rMap);
					System.out.println("roomListReal : "+roomListReal);
					System.out.println("--------------------------");
					
				}
			}
		}
		roomMap.put("title", "FRIEND_EMAIL");
		List<Map<String,Object>> roomList1=chattingService.roomList(roomMap);
		if(roomList1.size()>0) {
			for(int i=0; i<roomList1.size(); i++)
			{
				Map<String,Object> rMap1 = new HashMap<>();
				for(int j=0; j<roomList1.size(); j++)
				{
					chat_no=Integer.parseInt((String.valueOf(roomList1.get(i).get("CHAT_NO"))));
					chat_no1=Integer.parseInt((String.valueOf(roomList1.get(j).get("CHAT_NO"))));
					if(roomList1.get(i).get("ROOM_NO").equals(roomList1.get(j).get("ROOM_NO")))
					{
						rMap1.put("ROOM_NO", roomList1.get(j).get("ROOM_NO"));
						rMap1.put("CHAT_NO", roomList1.get(j).get("CHAT_NO"));
						rMap1.put("MY_EMAIL", roomList1.get(j).get("MY_EMAIL"));
						rMap1.put("FRIEND_EMAIL", roomList1.get(j).get("FRIEND_EMAIL"));
						rMap1.put("MEMBER_EMAIL", roomList1.get(j).get("MEMBER_EMAIL"));
						rMap1.put("MEMBER_NAME", roomList1.get(j).get("MEMBER_NAME"));
						rMap1.put("MEMBER_PFP", roomList1.get(j).get("MEMBER_PFP"));
						rMap1.put("WRITER", roomList1.get(j).get("WRITER"));
						rMap1.put("MESSAGE", roomList1.get(j).get("MESSAGE"));
						rMap1.put("WRITER_DATE", roomList1.get(j).get("WRITER_DATE"));
						rMap1.put("READ", roomList1.get(j).get("READ"));
						
						System.out.println("listMap : "+rMap1);
						System.out.println("--------------------------");
					}
				}
				if(roomList1.get(i).get("CHAT_NO").equals(rMap1.get("CHAT_NO")))
				{
					roomListReal.add(rMap1);
					System.out.println("roomListReal : "+roomListReal);
					System.out.println("--------------------------");
					
				}
			}
		}
		
		/*채팅내용 가져오기-------------------------------------------------*/
		if(result<1)
		{
			Map<String,String> chatMap=new HashMap();
			int room_no=selectRoom.getRoom_no();
			List<Map<String,Object>> chat_contents=chattingService.contentsList(room_no);
			System.out.println("날짜    :   "+chat_contents);
			model.addAttribute("chat_contents", chat_contents);
		}
		model.addAttribute("selectRoom",selectRoom);
		model.addAttribute("roomListReal",roomListReal);
		model.addAttribute("host",request.getRemoteAddr());
		return "chat/friendChatting";
	}
	
	/*@RequestMapping("/chat/countRead")
	public ModelAndView countRead(HttpSession hs) throws JsonProcessingException, UnsupportedEncodingException
	{
		ModelAndView mv=new ModelAndView();
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		
		int count=chattingService.countRead(email);
		mv.addObject("count",  count);
		mv.setViewName("jsonView");
		return mv;
		
	}*/
	
}
