package kh.mark.jarvis.chatting.controller;

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
		roomMap.put("title", "MY_EMAIL");
		roomMap.put("email", email);
		List<Map<String,Object>> roomList=chattingService.roomList(roomMap);
		/*String last_chat=chattingService.lastChatting(roomMap);*/
		roomMap.put("title", "FRIEND_EMAIL");
		List<Map<String,Object>> roomList1=chattingService.roomList(roomMap);
		/*String last_chat1=chattingService.lastChatting(roomMap);*/
		
		Map<String,String> map=new HashMap();
		map.put("title", "F_MEMBER_EMAIL");
		map.put("email", email);
		List<Map<String,Object>> friendList=friendService.friendList(map);
		map.put("title", "F_FRIEND_EMAIL");
		List<Map<String,Object>> friendList1=friendService.friendList(map);

		model.addAttribute("roomList",roomList);
		model.addAttribute("roomList1",roomList1);
		model.addAttribute("friendList",friendList);
		model.addAttribute("friendList1",friendList1);
		/*model.addAttribute("last_chat",last_chat);*/
		/*model.addAttribute("last_chat1",last_chat1);*/
		
		return "chat/chattingView";
	}
	
	@RequestMapping("/chat/createRoom")
	public String createRoom(Model model, HttpSession hs, HttpServletRequest request, String fEmail)
	{
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		/*친구목록-----------------------------------------------------*/
		Map<String,String> chattingMap=new HashMap();
		chattingMap.put("title", "MY_EMAIL");
		chattingMap.put("email", email);
		List<Map<String,Object>> roomList=chattingService.roomList(chattingMap);
		chattingMap.put("title", "FRIEND_EMAIL");
		List<Map<String,Object>> roomList1=chattingService.roomList(chattingMap);
		
		Map<String,String> map=new HashMap();
		map.put("title", "F_MEMBER_EMAIL");
		map.put("email", email);
		List<Map<String,Object>> friendList=friendService.friendList(map);
		map.put("title", "F_FRIEND_EMAIL");
		List<Map<String,Object>> friendList1=friendService.friendList(map);

		
		/*채팅방찾기-----------------------------------------------------*/
		Map<String,String> roomMap=new HashMap();
		roomMap.put("mytitle", "MY_EMAIL");
		roomMap.put("ftitle", "FRIEND_EMAIL");
		roomMap.put("myEmail", email);
		roomMap.put("fEmail", fEmail);
		ChattingRoom selectRoom=chattingService.selectRoom(roomMap);
		roomMap.put("mytitle", "FRIEND_EMAIL");
		roomMap.put("ftitle", "MY_EMAIL");
		roomMap.put("myEmail", fEmail);
		roomMap.put("fEmail", email);
		ChattingRoom selectRoom1=chattingService.selectRoom(roomMap);
		if(selectRoom==null) {
			selectRoom=selectRoom1;
		}
		
		/*채팅방생성-----------------------------------------------------*/
		if(selectRoom==null)
		{
			roomMap.put("my_email", email);
			roomMap.put("friend_email", fEmail);
			int result=chattingService.createRoom(roomMap);
		}
		
		model.addAttribute("roomList",roomList);
		model.addAttribute("roomList1",roomList1);
		model.addAttribute("selectRoom",selectRoom);
		model.addAttribute("friendList",friendList);
		model.addAttribute("friendList1",friendList1);
		model.addAttribute("chat/friendChatting");
		model.addAttribute("host",request.getRemoteAddr());
		return "chat/friendChatting";
	}
	
}
