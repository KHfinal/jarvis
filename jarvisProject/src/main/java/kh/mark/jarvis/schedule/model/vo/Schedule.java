package kh.mark.jarvis.schedule.model.vo;

import java.sql.Date;

public class Schedule {

	private int sNo;
	private String userEmail;
	private String title;
	private Date startDate;
	private Date endDate;
	private String content;
	private String color;
	
	public Schedule() {}

	public Schedule(int sNo, String userEmail, String title, Date startDate, Date endDate, String content,
			String color) {
		super();
		this.sNo = sNo;
		this.userEmail = userEmail;
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.content = content;
		this.color = color;
	}

	public int getsNo() {
		return sNo;
	}

	public void setsNo(int sNo) {
		this.sNo = sNo;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	@Override
	public String toString() {
		return "Schedule [sNo=" + sNo + ", userEmail=" + userEmail + ", title=" + title + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", content=" + content + ", color=" + color + "]";
	}
	
	

	
	
	
}
