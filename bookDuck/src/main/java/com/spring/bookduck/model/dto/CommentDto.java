package com.spring.bookduck.model.dto;

public class CommentDto {
	
	private int comment_id;
	private int post_id;
	private int comment_groupseq;
	private String comment_content;
	private String comment_writer;
	private String comment_regdate;
	private int comment_titletab;
	private String comment_delflag;
	
	public CommentDto() {
	}

	public CommentDto(int comment_id, int post_id, int comment_groupseq, String comment_content,
			String comment_writer, String comment_regdate, int comment_titletab, String comment_delflag) {
		this.comment_id = comment_id;
		this.post_id = post_id;
		this.comment_groupseq = comment_groupseq;
		this.comment_content = comment_content;
		this.comment_writer = comment_writer;
		this.comment_regdate = comment_regdate;
		this.comment_titletab = comment_titletab;
		this.comment_delflag = comment_delflag;
	}

	public int getComment_id() {
		return comment_id;
	}

	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

	public int getPost_id() {
		return post_id;
	}

	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}

	public int getComment_groupseq() {
		return comment_groupseq;
	}

	public void setComment_groupseq(int comment_groupseq) {
		this.comment_groupseq = comment_groupseq;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public String getComment_writer() {
		return comment_writer;
	}

	public void setComment_writer(String comment_writer) {
		this.comment_writer = comment_writer;
	}

	public String getComment_regdate() {
		return comment_regdate;
	}

	public void setComment_regdate(String comment_regdate) {
		this.comment_regdate = comment_regdate;
		//System.out.println(comment_regdate);
	}

	public int getComment_titletab() {
		return comment_titletab;
	}

	public void setComment_titletab(int comment_titletab) {
		this.comment_titletab = comment_titletab;
	}

	public String getComment_delflag() {
		return comment_delflag;
	}

	public void setComment_delflag(String comment_delflag) {
		this.comment_delflag = comment_delflag;
	}
	
}
