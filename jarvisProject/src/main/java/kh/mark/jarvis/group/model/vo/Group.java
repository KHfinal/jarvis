package kh.mark.jarvis.group.model.vo;

import java.sql.Date;
import java.util.Arrays;

public class Group {

	private int g_no;
	private String g_name;
	private String g_master;
	private String g_intro;
	private Date g_date;
	private String g_originalFilename;
	private String g_renamedFilename;
	
	public Group() {
		
	}

	public Group(int g_no, String g_name, String g_master, String g_intro, Date g_date, String g_originalFilename,
			String g_renamedFilename) {
		super();
		this.g_no = g_no;
		this.g_name = g_name;
		this.g_master = g_master;
		this.g_intro = g_intro;
		this.g_date = g_date;
		this.g_originalFilename = g_originalFilename;
		this.g_renamedFilename = g_renamedFilename;
	}

	public int getG_no() {
		return g_no;
	}

	public void setG_no(int g_no) {
		this.g_no = g_no;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String g_name) {
		this.g_name = g_name;
	}

	public String getG_master() {
		return g_master;
	}

	public void setG_master(String g_master) {
		this.g_master = g_master;
	}

	public String getG_intro() {
		return g_intro;
	}

	public void setG_intro(String g_intro) {
		this.g_intro = g_intro;
	}

	public Date getG_date() {
		return g_date;
	}

	public void setG_date(Date g_date) {
		this.g_date = g_date;
	}

	public String getG_originalFilename() {
		return g_originalFilename;
	}

	public void setG_originalFilename(String g_originalFilename) {
		this.g_originalFilename = g_originalFilename;
	}

	public String getG_renamedFilename() {
		return g_renamedFilename;
	}

	public void setG_renamedFilename(String g_renamedFilename) {
		this.g_renamedFilename = g_renamedFilename;
	}

	@Override
	public String toString() {
		return "Group [g_no=" + g_no + ", g_name=" + g_name + ", g_master=" + g_master + ", g_intro=" + g_intro
				+ ", g_date=" + g_date + ", g_originalFilename=" + g_originalFilename + ", g_renamedFilename="
				+ g_renamedFilename + "]";
	}

	

	

	
}
