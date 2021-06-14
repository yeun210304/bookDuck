package com.spring.bookduck.model.dto;

public class MemberDto {
	
	private int member_no;
	private String member_id;
	private String member_pw;
	private int member_age;
	private String member_gender;
	private String member_email;
	private String member_enabled;
	private String member_payrole;
	private String member_role;
	private String member_type;
	private String member_blist;
	
	
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public int getMember_age() {
		return member_age;
	}
	public void setMember_age(int member_age) {
		this.member_age = member_age;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_enabled() {
		return member_enabled;
	}
	public void setMember_enabled(String member_enabled) {
		this.member_enabled = member_enabled;
	}
	public String getMember_payrole() {
		return member_payrole;
	}
	public void setMember_payrole(String member_payrole) {
		this.member_payrole = member_payrole;
	}
	public String getMember_role() {
		return member_role;
	}
	public void setMember_role(String member_role) {
		this.member_role = member_role;
	}
	public String getMember_type() {
		return member_type;
	}
	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}
	public String getMember_blist() {
		return member_blist;
	}
	public void setMember_blist(String member_blist) {
		this.member_blist = member_blist;
	}
	
	@Override
	public String toString() {
		return "MemberDto [member_no=" + member_no + ", member_id=" + member_id + ", member_pw=" + member_pw
				+ ", member_age=" + member_age + ", member_gender=" + member_gender + ", member_email=" + member_email
				+ ", member_enabled=" + member_enabled + ", member_payrole=" + member_payrole + ", member_role="
				+ member_role + ", member_type=" + member_type + ", member_blist=" + member_blist + "]";
	}
	public MemberDto() {
		super();
	}

}
