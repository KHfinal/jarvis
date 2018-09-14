package kh.mark.jarvis.post.model.vo;

import java.util.Date;

public class JarvisComment {
	private int commentNo;
	private String commentWriter;
	private String commentContents;
	private int commentLevel;
	private int postRef;
	private int commentRef;
	private Date commentDate;

	public JarvisComment() {
		
	}

	public JarvisComment(int commentNo, String commentWriter, String commentContents, int commentLevel, int postRef,
			int commentRef, Date commentDate) {
		super();
		this.commentNo = commentNo;
		this.commentWriter = commentWriter;
		this.commentContents = commentContents;
		this.commentLevel = commentLevel;
		this.postRef = postRef;
		this.commentRef = commentRef;
		this.commentDate = commentDate;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public String getCommentWriter() {
		return commentWriter;
	}

	public void setCommentWriter(String commentWriter) {
		this.commentWriter = commentWriter;
	}

	public String getCommentContents() {
		return commentContents;
	}

	public void setCommentContents(String commentContents) {
		this.commentContents = commentContents;
	}

	public int getCommentLevel() {
		return commentLevel;
	}

	public void setCommentLevel(int commentLevel) {
		this.commentLevel = commentLevel;
	}

	public int getPostRef() {
		return postRef;
	}

	public void setPostRef(int postRef) {
		this.postRef = postRef;
	}

	public int getCommentRef() {
		return commentRef;
	}

	public void setCommentRef(int commentRef) {
		this.commentRef = commentRef;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	@Override
	public String toString() {
		return "Jarvis_Comment [commentNo=" + commentNo + ", commentWriter=" + commentWriter + ", commentContents="
				+ commentContents + ", commentLevel=" + commentLevel + ", postRef=" + postRef + ", commentRef="
				+ commentRef + ", commentDate=" + commentDate + "]";
	}
}
