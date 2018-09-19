package kh.mark.jarvis.chatting.model.vo;

import java.util.Date;

public class ChattingContents {

	private int chat_no;
	private int room_no;
	private String writer;
	private String message;
	private Date write_date;
	private String read;
	
	public ChattingContents() {}

	public ChattingContents(int chat_no, int room_no, String writer, String message, Date write_date, String read) {
		super();
		this.chat_no = chat_no;
		this.room_no = room_no;
		this.writer = writer;
		this.message = message;
		this.write_date = write_date;
		this.read = read;
	}

	public int getChat_no() {
		return chat_no;
	}

	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}

	public int getRoom_no() {
		return room_no;
	}

	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public String getRead() {
		return read;
	}

	public void setRead(String read) {
		this.read = read;
	}

	@Override
	public String toString() {
		return "ChattingContents [chat_no=" + chat_no + ", room_no=" + room_no + ", writer=" + writer + ", message="
				+ message + ", write_date=" + write_date + ", read=" + read + "]";
	}

	
	
}
