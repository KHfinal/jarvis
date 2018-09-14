package kh.mark.jarvis.group.model.vo;

public class GroupLike {

	private int g_like_no;
	private String g_like_member;
	private int g_post_ref;
	private int g_comment_ref;
	private int g_like_check;
	
	public GroupLike() {}

	public GroupLike(int g_like_no, String g_like_member, int g_post_ref, int g_comment_ref, int g_like_check) {
		super();
		this.g_like_no = g_like_no;
		this.g_like_member = g_like_member;
		this.g_post_ref = g_post_ref;
		this.g_comment_ref = g_comment_ref;
		this.g_like_check = g_like_check;
	}

	public int getG_like_no() {
		return g_like_no;
	}

	public void setG_like_no(int g_like_no) {
		this.g_like_no = g_like_no;
	}

	public String getG_like_member() {
		return g_like_member;
	}

	public void setG_like_member(String g_like_member) {
		this.g_like_member = g_like_member;
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

	public int getG_like_check() {
		return g_like_check;
	}

	public void setG_like_check(int g_like_check) {
		this.g_like_check = g_like_check;
	}

	@Override
	public String toString() {
		return "GroupLike [g_like_no=" + g_like_no + ", g_like_member=" + g_like_member + ", g_post_ref=" + g_post_ref
				+ ", g_comment_ref=" + g_comment_ref + ", g_like_check=" + g_like_check + "]";
	}
	
	
}
