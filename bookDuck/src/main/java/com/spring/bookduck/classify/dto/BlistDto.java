package com.spring.bookduck.classify.dto;

import java.util.Date;

public class BlistDto {

	private int blacklist_no;
	private String blacklist_from;
	private String blacklist_to;
	private String blacklist_contents;
	private Date blacklist_date;
	
	public BlistDto() {
	}

	public BlistDto(int blacklist_no, String blacklist_from, String blacklist_to, String blacklist_contents,
			Date blacklist_date) {
		super();
		this.blacklist_no = blacklist_no;
		this.blacklist_from = blacklist_from;
		this.blacklist_to = blacklist_to;
		this.blacklist_contents = blacklist_contents;
		this.blacklist_date = blacklist_date;
	}

	public int getBlacklist_no() {
		return blacklist_no;
	}

	public void setBlacklist_no(int blacklist_no) {
		this.blacklist_no = blacklist_no;
	}

	public String getBlacklist_from() {
		return blacklist_from;
	}

	public void setBlacklist_from(String blacklist_from) {
		this.blacklist_from = blacklist_from;
	}

	public String getBlacklist_to() {
		return blacklist_to;
	}

	public void setBlacklist_to(String blacklist_to) {
		this.blacklist_to = blacklist_to;
	}

	public String getBlacklist_contents() {
		return blacklist_contents;
	}

	public void setBlacklist_contents(String blacklist_contents) {
		this.blacklist_contents = blacklist_contents;
	}

	public Date getBlacklist_date() {
		return blacklist_date;
	}

	public void setBlacklist_date(Date blacklist_date) {
		this.blacklist_date = blacklist_date;
	}

	@Override
	public String toString() {
		return "BListDto [blacklist_no=" + blacklist_no + ", blacklist_from=" + blacklist_from + ", blacklist_to="
				+ blacklist_to + ", blacklist_contents=" + blacklist_contents + ", blacklist_date=" + blacklist_date
				+ "]";
	}
	
	
	
	
}
