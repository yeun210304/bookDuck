package com.spring.bookduck.scrap.dto;

import java.util.Date;

public class ScrapDto {
	
	private int scrap_no;
	private String scrap_id;
	private int book_isbn;
	private Date scrap_regdate;
	private String book_title;
	
	
	public ScrapDto() {
	}


	public ScrapDto(int scrap_no, String scrap_id, int book_isbn, Date scrap_regdate, String book_title) {
		super();
		this.scrap_no = scrap_no;
		this.scrap_id = scrap_id;
		this.book_isbn = book_isbn;
		this.scrap_regdate = scrap_regdate;
		this.book_title = book_title;
	}


	public int getScrap_no() {
		return scrap_no;
	}


	public void setScrap_no(int scrap_no) {
		this.scrap_no = scrap_no;
	}


	public String getScrap_id() {
		return scrap_id;
	}


	public void setScrap_id(String scrap_id) {
		this.scrap_id = scrap_id;
	}


	public int getBook_isbn() {
		return book_isbn;
	}


	public void setBook_isbn(int book_isbn) {
		this.book_isbn = book_isbn;
	}


	public Date getScrap_regdate() {
		return scrap_regdate;
	}


	public void setScrap_regdate(Date scrap_regdate) {
		this.scrap_regdate = scrap_regdate;
	}


	public String getBook_title() {
		return book_title;
	}


	public void setBook_title(String book_title) {
		this.book_title = book_title;
	}


	@Override
	public String toString() {
		return "ScrapDto [scrap_no=" + scrap_no + ", scrap_id=" + scrap_id + ", book_isbn=" + book_isbn
				+ ", scrap_regdate=" + scrap_regdate + ", book_title=" + book_title + "]";
	}
	
	

}
