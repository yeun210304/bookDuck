package com.spring.bookduck.model.dto;

import java.util.Date;

public class PostDto {
	
	private int post_id;
	private int board_id;
	private int post_no;
	private String post_category;
	private String post_writer;
	private String post_title;
	private String post_content;
	private Date post_regdate;
	private int post_hit;
	private int post_comment_count;
	private String post_delflag;
	private String originName;
	private String changeName;

	public PostDto() {
	}

	public PostDto(int post_id, int board_id, int post_no, String post_category, String post_writer, String post_title,
			String post_content, Date post_regdate, int post_hit, int post_comment_count, String post_delflag,
			String originName, String changeName) {
		this.post_id = post_id;
		this.board_id = board_id;
		this.post_no = post_no;
		this.post_category = post_category;
		this.post_writer = post_writer;
		this.post_title = post_title;
		this.post_content = post_content;
		this.post_regdate = post_regdate;
		this.post_hit = post_hit;
		this.post_comment_count = post_comment_count;
		this.post_delflag = post_delflag;
		this.originName = originName;
		this.changeName = changeName;
	}

	public int getPost_id() {
		return post_id;
	}

	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public int getPost_no() {
		return post_no;
	}

	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}

	public String getPost_category() {
		return post_category;
	}

	public void setPost_category(String post_category) {
		this.post_category = post_category;
	}

	public String getPost_writer() {
		return post_writer;
	}

	public void setPost_writer(String post_writer) {
		this.post_writer = post_writer;
	}

	public String getPost_title() {
		return post_title;
	}

	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}

	public String getPost_content() {
		return post_content;
	}

	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}

	public Date getPost_regdate() {
		return post_regdate;
	}

	public void setPost_regdate(Date post_regdate) {
		this.post_regdate = post_regdate;
	}

	public int getPost_hit() {
		return post_hit;
	}

	public void setPost_hit(int post_hit) {
		this.post_hit = post_hit;
	}

	public int getPost_comment_count() {
		return post_comment_count;
	}

	public void setPost_comment_count(int post_comment_count) {
		this.post_comment_count = post_comment_count;
	}

	public String getPost_delflag() {
		return post_delflag;
	}

	public void setPost_delflag(String post_delflag) {
		this.post_delflag = post_delflag;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

}
