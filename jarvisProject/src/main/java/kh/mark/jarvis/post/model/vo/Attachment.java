package kh.mark.jarvis.post.model.vo;

import java.util.Date;

public class Attachment {
	private int attachmentNo;
	private int postNo;
	private String originalFileName;
	private String renamedFileName;
	private Date uploadDate;
	
	public Attachment() {
		
	}

	public Attachment(int attachmentNo, int postNo, String originalFileName, String renamedFileName, Date uploadDate) {
		super();
		this.attachmentNo = attachmentNo;
		this.postNo = postNo;
		this.originalFileName = originalFileName;
		this.renamedFileName = renamedFileName;
		this.uploadDate = uploadDate;
	}

	public int getAttachmentNo() {
		return attachmentNo;
	}

	public void setAttachmentNo(int attachmentNo) {
		this.attachmentNo = attachmentNo;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getRenamedFileName() {
		return renamedFileName;
	}

	public void setRenamedFileName(String renamedFileName) {
		this.renamedFileName = renamedFileName;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	@Override
	public String toString() {
		return "Attachment [attachmentNo=" + attachmentNo + ", postNo=" + postNo + ", originalFileName="
				+ originalFileName + ", renamedFileName=" + renamedFileName + ", uploadDate=" + uploadDate + "]";
	}
}
