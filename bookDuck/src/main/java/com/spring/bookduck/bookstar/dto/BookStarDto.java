package com.spring.bookduck.bookstar.dto;

public class BookStarDto {
	
	private String bookstar_id;
	private String bookstar_title;
	private String bookstar_isbn;
	private int bookstar_star;

	public BookStarDto() {
	}

	public BookStarDto(String bookstar_id, String bookstar_title, String bookstar_isbn,
			 int bookstar_star) {
		this.bookstar_id = bookstar_id;
		this.bookstar_title = bookstar_title;
		this.bookstar_isbn = bookstar_isbn;
		this.bookstar_star = bookstar_star;
	}

	

	public String getBookstar_id() {
		return bookstar_id;
	}

	public void setBookstar_id(String bookstar_id) {
		this.bookstar_id = bookstar_id;
	}

	public String getBookstar_title() {
		return bookstar_title;
	}

	public void setBookstar_title(String bookstar_title) {
		this.bookstar_title = bookstar_title;
	}

	public String getBookstar_isbn() {
		return bookstar_isbn;
	}

	public void setBookstar_isbn(String bookstar_isbn) {
		this.bookstar_isbn = bookstar_isbn;
	}

	public int getBookstar_star() {
		return bookstar_star;
	}

	public void setBookstar_star(int bookstar_star) {
		this.bookstar_star = bookstar_star;
	}

	
	
}
