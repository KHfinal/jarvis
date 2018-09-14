package kh.mark.jarvis.chatting.model.vo;

public class ChattingRoom {

	private int room_no;
	private String room_title;
	private String my_email;
	private String friend_email;
	
	public ChattingRoom() {}

	public ChattingRoom(int room_no, String room_title, String my_email, String friend_email) {
		super();
		this.room_no = room_no;
		this.room_title = room_title;
		this.my_email = my_email;
		this.friend_email = friend_email;
	}

	public int getRoom_no() {
		return room_no;
	}

	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}

	public String getRoom_title() {
		return room_title;
	}

	public void setRoom_title(String room_title) {
		this.room_title = room_title;
	}

	public String getMy_email() {
		return my_email;
	}

	public void setMy_email(String my_email) {
		this.my_email = my_email;
	}

	public String getFriend_email() {
		return friend_email;
	}

	public void setFriend_email(String friend_email) {
		this.friend_email = friend_email;
	}

	@Override
	public String toString() {
		return "ChattingRoom [room_no=" + room_no + ", room_title=" + room_title + ", my_email=" + my_email
				+ ", friend_email=" + friend_email + "]";
	}
	
}
