package com.spring.bookduck.model.dto;

import java.util.Date;

public class RTNovelDto {

	private int RTNovelNo;
	private String RTNovelId;
	private Date RTNovelRegdate;
	private String RTNovleContent;
	
	public RTNovelDto() {
	}
	public RTNovelDto(int rTNovelNo, String rTNovelId, Date rTNovelRegdate, String rTNovleContent) {
		super();
		RTNovelNo = rTNovelNo;
		RTNovelId = rTNovelId;
		RTNovelRegdate = rTNovelRegdate;
		RTNovleContent = rTNovleContent;
	}
	public int getRTNovelNo() {
		return RTNovelNo;
	}
	public void setRTNovelNo(int rTNovelNo) {
		RTNovelNo = rTNovelNo;
	}
	public String getRTNovelId() {
		return RTNovelId;
	}
	public void setRTNovelId(String rTNovelId) {
		RTNovelId = rTNovelId;
	}
	public Date getRTNovelRegdate() {
		return RTNovelRegdate;
	}
	public void setRTNovelRegdate(Date rTNovelRegdate) {
		RTNovelRegdate = rTNovelRegdate;
	}
	public String getRTNovleContent() {
		return RTNovleContent;
	}
	public void setRTNovleContent(String rTNovleContent) {
		RTNovleContent = rTNovleContent;
	}
}
