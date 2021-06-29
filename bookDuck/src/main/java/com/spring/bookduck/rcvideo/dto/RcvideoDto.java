package com.spring.bookduck.rcvideo.dto;

public class RcvideoDto {
	
	private int rcvideo_no;
	private String rcvideo_content;
	private String book_isbn;
	
	public RcvideoDto() {
	}

	public RcvideoDto(int rcvideo_no, String rcvideo_content, String book_isbn) {
		super();
		this.rcvideo_no = rcvideo_no;
		this.rcvideo_content = rcvideo_content;
		this.book_isbn = book_isbn;
	}

	public int getRcvideo_no() {
		return rcvideo_no;
	}

	public void setRcvideo_no(int rcvideo_no) {
		this.rcvideo_no = rcvideo_no;
	}

	public String getRcvideo_content() {
		return rcvideo_content;
	}

	public void setRcvideo_content(String rcvideo_content) {
		this.rcvideo_content = rcvideo_content;
	}

	public String getBook_isbn() {
		return book_isbn;
	}

	public void setBook_isbn(String book_isbn) {
		this.book_isbn = book_isbn;
	}

	@Override
	public String toString() {
		return "RcvideoDto [rcvideo_no=" + rcvideo_no + ", rcvideo_content=" + rcvideo_content + ", book_isbn="
				+ book_isbn + "]";
	}

	
}
