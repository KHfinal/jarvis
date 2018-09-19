package kh.mark.jarvis.admin.model.vo;

import java.util.Date;

public class Notify {
	private int notifyNo;
	private int postNo;
	private String postWriter;
	private String notifyWriter;
	private String notifyReason;
	private Date notifyDate;
	private String status;
	
	public Notify() {}

	public Notify(int notifyNo, int postNo, String postWriter, String notifyWriter, String notifyReason,
			Date notifyDate, String status) {
		super();
		this.notifyNo = notifyNo;
		this.postNo = postNo;
		this.postWriter = postWriter;
		this.notifyWriter = notifyWriter;
		this.notifyReason = notifyReason;
		this.notifyDate = notifyDate;
		this.status = status;
	}

	public int getNotifyNo() {
		return notifyNo;
	}

	public void setNotifyNo(int notifyNo) {
		this.notifyNo = notifyNo;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getPostWriter() {
		return postWriter;
	}

	public void setPostWriter(String postWriter) {
		this.postWriter = postWriter;
	}

	public String getNotifyWriter() {
		return notifyWriter;
	}

	public void setNotifyWriter(String notifyWriter) {
		this.notifyWriter = notifyWriter;
	}

	public String getNotifyReason() {
		return notifyReason;
	}

	public void setNotifyReason(String notifyReason) {
		this.notifyReason = notifyReason;
	}

	public Date getNotifyDate() {
		return notifyDate;
	}

	public void setNotifyDate(Date notifyDate) {
		this.notifyDate = notifyDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Notify [notifyNo=" + notifyNo + ", postNo=" + postNo + ", postWriter=" + postWriter + ", notifyWriter="
				+ notifyWriter + ", notifyReason=" + notifyReason + ", notifyDate=" + notifyDate + ", status=" + status
				+ "]";
	}
	
	
}
