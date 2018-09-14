package kh.mark.jarvis.group.model.vo;

import java.sql.Date;

public class GroupPost {

	private int g_post_no;
	private String g_post_contents;
	private String g_no;
	private String g_post_writer;
	private Date g_post_date;
	
	public GroupPost() {}

	public GroupPost(int g_post_no, String g_post_contents, String g_post_bound, String g_no, String g_post_writer,
			Date g_post_date) {
		super();
		this.g_post_no = g_post_no;
		this.g_post_contents = g_post_contents;
		this.g_no = g_no;
		this.g_post_writer = g_post_writer;
		this.g_post_date = g_post_date;
	}

	public int getG_post_no() {
		return g_post_no;
	}

	public void setG_post_no(int g_post_no) {
		this.g_post_no = g_post_no;
	}

	public String getG_post_contents() {
		return g_post_contents;
	}

	public void setG_post_contents(String g_post_contents) {
		this.g_post_contents = g_post_contents;
	}

	public String getG_no() {
		return g_no;
	}

	public void setG_no(String g_no) {
		this.g_no = g_no;
	}

	public String getG_post_writer() {
		return g_post_writer;
	}

	public void setG_post_writer(String g_post_writer) {
		this.g_post_writer = g_post_writer;
	}

	public Date getG_post_date() {
		return g_post_date;
	}

	public void setG_post_date(Date g_post_date) {
		this.g_post_date = g_post_date;
	}

	@Override
	public String toString() {
		return "GroupPost [g_post_no=" + g_post_no + ", g_post_contents=" + g_post_contents
				+ ", g_no=" + g_no + ", g_post_writer=" + g_post_writer + ", g_post_date=" + g_post_date
				+ "]";
	}
	
	
}
