package com.spring.bookduck.scrap.dto;

import java.util.Date;

public class ScrapDto {
	
	private int scrap_no;
	private String scrap_id;
	private String book_isbn;
	private Date scrap_regdate;
	private String book_title;
	private String book_coverLargeUrl;
	private String book_author;
	private String book_categoryId;
	
	public ScrapDto() {
	}

	public ScrapDto(int scrap_no, String scrap_id, String book_isbn, Date scrap_regdate, String book_title,
			String book_coverLargeUrl, String book_author, String book_categoryId) {
		super();
		this.scrap_no = scrap_no;
		this.scrap_id = scrap_id;
		this.book_isbn = book_isbn;
		this.scrap_regdate = scrap_regdate;
		this.book_title = book_title;
		this.book_coverLargeUrl = book_coverLargeUrl;
		this.book_author = book_author;
		this.book_categoryId = book_categoryId;
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

	public String getBook_isbn() {
		return book_isbn;
	}

	public void setBook_isbn(String book_isbn) {
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

	public String getBook_coverLargeUrl() {
		return book_coverLargeUrl;
	}

	public void setBook_coverLargeUrl(String book_coverLargeUrl) {
		this.book_coverLargeUrl = book_coverLargeUrl;
	}

	public String getBook_author() {
		return book_author;
	}

	public void setBook_author(String book_author) {
		this.book_author = book_author;
	}

	public String getBook_categoryId() {
		return book_categoryId;
	}

	public void setBook_categoryId(String book_categoryId) {
		this.book_categoryId = book_categoryId;
	}

	@Override
	public String toString() {
		return "ScrapDto [scrap_no=" + scrap_no + ", scrap_id=" + scrap_id + ", book_isbn=" + book_isbn
				+ ", scrap_regdate=" + scrap_regdate + ", book_title=" + book_title + ", book_coverLargeUrl="
				+ book_coverLargeUrl + ", book_author=" + book_author + ", book_categoryId=" + book_categoryId + "]";
	}

	
}