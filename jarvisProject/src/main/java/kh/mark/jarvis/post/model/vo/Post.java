package kh.mark.jarvis.post.model.vo;

import java.util.Date;

public class Post {
	private int postNo;
	private String postWriter;
	private String postContents;
	private String privacyBound;
	private Date postDate;
	public Post() {
		
	}

	public Post(int postNo, String postWriter, String postContents, String privacyBound, Date postDate) {
		super();
		this.postNo = postNo;
		this.postWriter = postWriter;
		this.postContents = postContents;
		this.privacyBound = privacyBound;
		this.postDate = postDate;
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

	public String getPostContents() {
		return postContents;
	}

	public void setPostContents(String postContents) {
		this.postContents = postContents;
	}

	public String getPrivacyBound() {
		return privacyBound;
	}

	public void setPrivacyBound(String privacyBound) {
		this.privacyBound = privacyBound;
	}

	public Date getPostDate() {
		return postDate;
	}

	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}

	@Override
	public String toString() {
		return "Post [postNo=" + postNo + ", postWriter=" + postWriter + ", postContents=" + postContents
				+ ", privacyBound=" + privacyBound + ", postDate=" + postDate + "]";
	}
	
}
