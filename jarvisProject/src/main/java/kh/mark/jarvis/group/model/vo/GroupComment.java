package kh.mark.jarvis.group.model.vo;

import java.sql.Date;

public class GroupComment {

	private int g_comment_no;
	private String g_comment_writer;
	private String g_comment_contents;
	private int g_comment_level;
	private int g_post_ref;
	private int g_comment_ref;
	private Date g_comment_date;
	
	public GroupComment() {}

	public GroupComment(int g_comment_no, String g_comment_writer, String g_comment_contents, int g_comment_level,
			int g_post_ref, int g_comment_ref, Date g_comment_date) {
		super();
		this.g_comment_no = g_comment_no;
		this.g_comment_writer = g_comment_writer;
		this.g_comment_contents = g_comment_contents;
		this.g_comment_level = g_comment_level;
		this.g_post_ref = g_post_ref;
		this.g_comment_ref = g_comment_ref;
		this.g_comment_date = g_comment_date;
	}

	public int getG_comment_no() {
		return g_comment_no;
	}

	public void setG_comment_no(int g_comment_no) {
		this.g_comment_no = g_comment_no;
	}

	public String getG_comment_writer() {
		return g_comment_writer;
	}

	public void setG_comment_writer(String g_comment_writer) {
		this.g_comment_writer = g_comment_writer;
	}

	public String getG_comment_contents() {
		return g_comment_contents;
	}

	public void setG_comment_contents(String g_comment_contents) {
		this.g_comment_contents = g_comment_contents;
	}

	public int getG_comment_level() {
		return g_comment_level;
	}

	public void setG_comment_level(int g_comment_level) {
		this.g_comment_level = g_comment_level;
	}

	public int getG_post_ref() {
		return g_post_ref;
	}

	public void setG_post_ref(int g_post_ref) {
		this.g_post_ref = g_post_ref;
	}

	public int getG_comment_ref() {
		return g_comment_ref;
	}

	public void setG_comment_ref(int g_comment_ref) {
		this.g_comment_ref = g_comment_ref;
	}

	public Date getG_comment_date() {
		return g_comment_date;
	}

	public void setG_comment_date(Date g_comment_date) {
		this.g_comment_date = g_comment_date;
	}

	@Override
	public String toString() {
		return "GroupComment [g_comment_no=" + g_comment_no + ", g_comment_writer=" + g_comment_writer
				+ ", g_comment_contents=" + g_comment_contents + ", g_comment_level=" + g_comment_level + ", g_post_ref="
				+ g_post_ref + ", g_comment_ref=" + g_comment_ref + ", g_comment_date=" + g_comment_date + "]";
	}
	
	
}
