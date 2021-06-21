package com.spring.bookduck.model.dto;

public class ImageDto {

	private int image_no;
	private int post_id;
	private String image_path;
	
	public ImageDto() {}

	public ImageDto(int image_no, int post_id, String image_path) {
		this.image_no = image_no;
		this.post_id = post_id;
		this.image_path = image_path;
	}

	public int getImage_no() {
		return image_no;
	}

	public void setImage_no(int image_no) {
		this.image_no = image_no;
	}

	public int getPost_id() {
		return post_id;
	}

	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}

	public String getImage_path() {
		return image_path;
	}

	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	
}
