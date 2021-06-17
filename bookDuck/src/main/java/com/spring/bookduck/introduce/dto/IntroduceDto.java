package com.spring.bookduck.introduce.dto;

public class IntroduceDto {
	
	private int intd_no;
	private String intd_id;
	private String intd_content;

	
	public IntroduceDto() {
	}


	public IntroduceDto(int intd_no, String intd_id, String intd_content) {
		super();
		this.intd_no = intd_no;
		this.intd_id = intd_id;
		this.intd_content = intd_content;
	}


	public int getIntd_no() {
		return intd_no;
	}


	public void setIntd_no(int intd_no) {
		this.intd_no = intd_no;
	}


	public String getIntd_id() {
		return intd_id;
	}


	public void setIntd_id(String intd_id) {
		this.intd_id = intd_id;
	}


	public String getIntd_content() {
		return intd_content;
	}


	public void setIntd_content(String intd_content) {
		this.intd_content = intd_content;
	}

	

}