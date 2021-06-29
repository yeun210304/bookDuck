package com.spring.bookduck.bookfm.dto;

public class BookFMDto {

	private int bookfm_seq;
	private String bookfm_title;
	private String bookfm_isbn;
	private String bookfm_author;
	private String bookfm_fm;
	
	public BookFMDto() {
	}

	public BookFMDto(int bookfm_seq, String bookfm_title, String bookfm_isbn, String bookfm_author,
			String bookfm_fm) {
		this.bookfm_seq = bookfm_seq;
		this.bookfm_title = bookfm_title;
		this.bookfm_isbn = bookfm_isbn;
		this.bookfm_author = bookfm_author;
		this.bookfm_fm = bookfm_fm;
	}

	public int getBookfm_seq() {
		return bookfm_seq;
	}

	public void setBookfm_seq(int bookfm_seq) {
		this.bookfm_seq = bookfm_seq;
	}

	public String getBookfm_title() {
		return bookfm_title;
	}

	public void setBookfm_title(String bookfm_title) {
		this.bookfm_title = bookfm_title;
	}

	public String getBookfm_isbn() {
		return bookfm_isbn;
	}

	public void setBookfm_isbn(String bookfm_isbn) {
		this.bookfm_isbn = bookfm_isbn;
	}

	public String getBookfm_author() {
		return bookfm_author;
	}

	public void setBookfm_author(String bookfm_author) {
		this.bookfm_author = bookfm_author;
	}

	public String getBookfm_fm() {
		return bookfm_fm;
	}

	public void setBookfm_fm(String bookfm_fm) {
		this.bookfm_fm = bookfm_fm;
	}
	
	
	
	
	
	
	
	
	
	
	

	
}
