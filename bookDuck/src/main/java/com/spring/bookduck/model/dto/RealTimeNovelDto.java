package com.spring.bookduck.model.dto;

import java.util.Date;

public class RealTimeNovelDto {

	private int novel_no;
	private String novel_id;
	private Date novel_regdate;
	private String novel_content;

	public RealTimeNovelDto() {
	}
	public RealTimeNovelDto(int novel_no, String novel_id, Date novel_regdate, String novel_content) {
		super();
		this.novel_no = novel_no;
		this.novel_id = novel_id;
		this.novel_regdate = novel_regdate;
		this.novel_content = novel_content;
	}
	public int getNovel_no() {
		return novel_no;
	}
	public void setNovel_no(int novel_no) {
		this.novel_no = novel_no;
	}
	public String getNovel_id() {
		return novel_id;
	}
	public void setNovel_id(String novel_id) {
		this.novel_id = novel_id;
	}
	public Date getNovel_regdate() {
		return novel_regdate;
	}
	public void setNovel_regdate(Date novel_regdate) {
		this.novel_regdate = novel_regdate;
	}
	public String getNovel_content() {
		return novel_content;
	}
	public void setNovel_content(String novel_content) {
		this.novel_content = novel_content;
	}
}
