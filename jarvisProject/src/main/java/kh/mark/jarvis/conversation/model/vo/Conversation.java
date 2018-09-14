package kh.mark.jarvis.conversation.model.vo;

public class Conversation {
	private String c_memberEmail;
	private String c_content;
	public String getC_memberEmail() {
		return c_memberEmail;
	}
	public void setC_memberEmail(String c_memberEmail) {
		this.c_memberEmail = c_memberEmail;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	@Override
	public String toString() {
		return "Conversation [c_memberEmail=" + c_memberEmail + ", c_content=" + c_content + "]";
	}
	public Conversation() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Conversation(String c_memberEmail, String c_content) {
		super();
		this.c_memberEmail = c_memberEmail;
		this.c_content = c_content;
	}
	
	
}
