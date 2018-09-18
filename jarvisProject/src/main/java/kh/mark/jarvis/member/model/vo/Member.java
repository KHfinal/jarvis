package kh.mark.jarvis.member.model.vo;

import java.sql.Date;
import java.util.Arrays;


public class Member {

	private int memberNo;
	private String memberEmail;  //이메일
	private String memberPw;	//패스워드
	private String memberName;	//이름
	private String memberNickname;	//닉네임
	private String phone;			//연락처
	private Date reg_date;			//가입일
	private String memberPFP; //프로필사진
	private String[] memberConcern; //관심분야
	private String memberGender;  //성별
	private Date memberBirthday;	//생일
	private String addr1;			//주소
	private String addr2;			//주소
	private String addr3;			//주소
	private String addInfo;         //추가정보입력여부
	private String verify;	//이메일인증여부
	private Date blockDate;
	public Member() {
		super();
	}

	public Member(String memberEmail, String memberPw, String memberName, String memberNickname, String phone,
			Date reg_date, String memberPFP, String[] memberConcern, String memberGender, Date memberBirthday,
			String addr1, String addr2, String addr3, String addInfo, String verify) {
		super();
		this.memberEmail = memberEmail;
		this.memberPw = memberPw;
		this.memberName = memberName;
		this.memberNickname = memberNickname;
		this.phone = phone;
		this.reg_date = reg_date;
		this.memberPFP = memberPFP;
		this.memberConcern = memberConcern;
		this.memberGender = memberGender;
		this.memberBirthday = memberBirthday;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.addr3 = addr3;
		this.addInfo = addInfo;
		this.verify = verify;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public String getMemberPFP() {
		return memberPFP;
	}

	public void setMemberPFP(String memberPFP) {
		this.memberPFP = memberPFP;
	}

	public String[] getMemberConcern() {
		return memberConcern;
	}

	public void setMemberConcern(String[] memberConcern) {
		this.memberConcern = memberConcern;
	}

	public String getMemberGender() {
		return memberGender;
	}

	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}

	public Date getMemberBirthday() {
		return memberBirthday;
	}

	public void setMemberBirthday(Date memberBirthday) {
		this.memberBirthday = memberBirthday;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getAddr3() {
		return addr3;
	}

	public void setAddr3(String addr3) {
		this.addr3 = addr3;
	}

	public String getAddInfo() {
		return addInfo;
	}

	public void setAddInfo(String addInfo) {
		this.addInfo = addInfo;
	}

	public String getVerify() {
		return verify;
	}

	public void setVerify(String verify) {
		this.verify = verify;
	}

	@Override
	public String toString() {
		return "Member [memberEmail=" + memberEmail + ", memberPw=" + memberPw + ", memberName=" + memberName
				+ ", memberNickname=" + memberNickname + ", phone=" + phone + ", reg_date=" + reg_date + ", memberPFP="
				+ memberPFP + ", memberConcern=" + Arrays.toString(memberConcern) + ", memberGender=" + memberGender
				+ ", memberBirthday=" + memberBirthday + ", addr1=" + addr1 + ", addr2=" + addr2 + ", addr3=" + addr3
				+ ", addInfo=" + addInfo + ", verify=" + verify + "]";
	}

	public Date getBlockDate() {
		return blockDate;
	}

	public void setBlockDate(Date blockDate) {
		this.blockDate = blockDate;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	
	
	
}
