package com.spring.bookduck.rcimg.dto;

public class RcimgDto {

	
	private int rcimg_no ;
	private String rcimg_content;
	private String book_isbn;
	
	public RcimgDto() {
	}

	public RcimgDto(int rcimg_no, String rcimg_content, String book_isbn) {
		super();
		this.rcimg_no = rcimg_no;
		this.rcimg_content = rcimg_content;
		this.book_isbn = book_isbn;
	}

	public int getRcimg_no() {
		return rcimg_no;
	}

	public void setRcimg_no(int rcimg_no) {
		this.rcimg_no = rcimg_no;
	}

	public String getRcimg_content() {
		return rcimg_content;
	}

	public void setRcimg_content(String rcimg_content) {
		this.rcimg_content = rcimg_content;
	}

	public String getBook_isbn() {
		return book_isbn;
	}

	public void setBook_isbn(String book_isbn) {
		this.book_isbn = book_isbn;
	}

	@Override
	public String toString() {
		return "RcimgDto [rcimg_no=" + rcimg_no + ", rcimg_content=" + rcimg_content + ", book_isbn=" + book_isbn + "]";
	}
	
	
}
