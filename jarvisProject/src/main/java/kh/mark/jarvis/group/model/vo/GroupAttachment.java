package kh.mark.jarvis.group.model.vo;

import java.sql.Date;

public class GroupAttachment {
	private int g_attachment_no;
	private int g_post_no;
	private String g_original_filename;
	private String g_renamed_filename;
	private Date g_upload_date;
	
	public GroupAttachment() {}

	public GroupAttachment(int g_attachment_no, int g_post_no, String g_original_filename, String g_renamed_filename,
			Date g_upload_date) {
		super();
		this.g_attachment_no = g_attachment_no;
		this.g_post_no = g_post_no;
		this.g_original_filename = g_original_filename;
		this.g_renamed_filename = g_renamed_filename;
		this.g_upload_date = g_upload_date;
	}

	public int getG_attachment_no() {
		return g_attachment_no;
	}

	public void setG_attachment_no(int g_attachment_no) {
		this.g_attachment_no = g_attachment_no;
	}

	public int getG_post_no() {
		return g_post_no;
	}

	public void setG_post_no(int g_post_no) {
		this.g_post_no = g_post_no;
	}

	public String getG_original_filename() {
		return g_original_filename;
	}

	public void setG_original_filename(String g_original_filename) {
		this.g_original_filename = g_original_filename;
	}

	public String getG_renamed_filename() {
		return g_renamed_filename;
	}

	public void setG_renamed_filename(String g_renamed_filename) {
		this.g_renamed_filename = g_renamed_filename;
	}

	public Date getG_upload_date() {
		return g_upload_date;
	}

	public void setG_upload_date(Date g_upload_date) {
		this.g_upload_date = g_upload_date;
	}

	@Override
	public String toString() {
		return "GroupAttachment [g_attachment_no=" + g_attachment_no + ", g_post_no=" + g_post_no
				+ ", g_original_filename=" + g_original_filename + ", g_renamed_filename=" + g_renamed_filename + "]";
	}
	
	

}
