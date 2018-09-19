package kh.mark.jarvis.chatting.controller;

import java.io.UnsupportedEncodingException;
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

		roomMap.put("title", "FRIEND_EMAIL");
		List<Map<String,Object>> roomList1=chattingService.roomList(roomMap);
	
		/*for(int i=0; i<roomList.size(); i++)
		{
			for(int j=0; j<roomList.size(); j++)
			{
				if(roomList.get(i).get("ROOM_NO")==roomList.get(j).get("ROOM_NO"))
				{
					//roomListReal.add(roomList.get(j));
					listMap.put("ROOM_NO", roomList.get(j).get("ROOM_NO"));
					listMap.put("MY_EMAIL", roomList.get(j).get("MY_EMAIL"));
					listMap.put("FRIEND_EMAIL", roomList.get(j).get("FRIEND_EMAIL"));
					listMap.put("MEMBER_EMAIL", roomList.get(j).get("MEMBER_EMAIL"));
					listMap.put("MEMBER_NAME", roomList.get(j).get("MEMBER_NAME"));
					listMap.put("MEMBER_PFP", roomList.get(j).get("MEMBER_PFP"));
					listMap.put("WRITER", roomList.get(j).get("WRITER"));
					listMap.put("MESSAGE", roomList.get(j).get("MESSAGE"));
					listMap.put("WRITER_DATE", roomList.get(j).get("WRITER_DATE"));
					listMap.put("READ", roomList.get(j).get("READ"));
					System.out.println("이중포문안에 roomList--------"+roomList.get(j));
					roomListReal.add(listMap);
					System.out.println("이중포문안에 roomListReal--------"+roomListReal);
				}
			}
		}*/
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
	public String createRoom(Model model, HttpSession hs, HttpServletRequest request, String fEmail, String roomNo)
	{
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		
		/*채팅방목록-----------------------------------------------------*/
		Map<String,String> chattingMap=new HashMap();
		chattingMap.put("title", "MY_EMAIL");
		chattingMap.put("email", email);
		List<Map<String,Object>> roomList=chattingService.roomList(chattingMap);
		
		chattingMap.put("title", "FRIEND_EMAIL");
		List<Map<String,Object>> roomList1=chattingService.roomList(chattingMap);
		/*채팅방찾기-----------------------------------------------------*/
		Map<String,String> roomMap=new HashMap();
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
		if(selectRoom!=null)
		{
			roomMap.put("mEmail", email);
			roomMap.put("fEmail", fEmail);
			roomMap.put("roomNo", roomNo);
			int readResult=chattingService.readCheck(roomMap);
		}
		
		/*채팅방생성-----------------------------------------------------*/
		int result=0;
		if(selectRoom==null)
		{
			roomMap.put("my_email", email);
			roomMap.put("friend_email", fEmail);
			result=chattingService.createRoom(roomMap);
		}
		
		
		/*채팅내용 가져오기-------------------------------------------------*/
		if(result<1)
		{
			Map<String,String> chatMap=new HashMap();
			int room_no=selectRoom.getRoom_no();
			List<Map<String,Object>> chat_contents=chattingService.contentsList(room_no);
			System.out.println(chat_contents);
			model.addAttribute("chat_contents", chat_contents);
		}
		model.addAttribute("roomList",roomList);
		model.addAttribute("roomList1",roomList1);
		model.addAttribute("selectRoom",selectRoom);
		model.addAttribute("host",request.getRemoteAddr());
		return "chat/friendChatting";
	}
	
	@RequestMapping("/chat/countRead")
	public ModelAndView countRead(HttpSession hs) throws JsonProcessingException, UnsupportedEncodingException
	{
		ModelAndView mv=new ModelAndView();
		Member m = (Member)hs.getAttribute("memberLoggedIn");
		String email = m.getMemberEmail();
		
		int count=chattingService.countRead(email);
		mv.addObject("count",  count);
		mv.setViewName("jsonView");
		return mv;
		
	}
	
}
