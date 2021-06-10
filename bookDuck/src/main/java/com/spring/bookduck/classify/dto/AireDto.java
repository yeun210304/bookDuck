package com.spring.bookduck.classify.dto;

import java.util.Date;

public class AireDto {
	
	private int recommend_no;
	private String recommend_id;
	private int recommend_age;
	private String recommend_genre;
	private String recommend_favor;
	private Date recommend_date;
	
	public AireDto() {		
	}

	public AireDto(int recommend_no, String recommend_id, int recommend_age, String recommend_genre,
			String recommend_favor, Date recommend_date) {	
		this.recommend_no = recommend_no;
		this.recommend_id = recommend_id;
		this.recommend_age = recommend_age;
		this.recommend_genre = recommend_genre;
		this.recommend_favor = recommend_favor;
		this.recommend_date = recommend_date;
	}

	public int getRecommend_no() {
		return recommend_no;
	}

	public void setRecommend_no(int recommend_no) {
		this.recommend_no = recommend_no;
	}

	public String getRecommend_id() {
		return recommend_id;
	}

	public void setRecommend_id(String recommend_id) {
		this.recommend_id = recommend_id;
	}

	public int getRecommend_age() {
		return recommend_age;
	}

	public void setRecommend_age(int recommend_age) {
		this.recommend_age = recommend_age;
	}

	public String getRecommend_genre() {
		return recommend_genre;
	}

	public void setRecommend_genre(String recommend_genre) {
		this.recommend_genre = recommend_genre;
	}

	public String getRecommend_favor() {
		return recommend_favor;
	}

	public void setRecommend_favor(String recommend_favor) {
		this.recommend_favor = recommend_favor;
	}

	public Date getRecommend_date() {
		return recommend_date;
	}

	public void setRecommend_date(Date recommend_date) {
		this.recommend_date = recommend_date;
	}

	@Override
	public String toString() {
		return "AIReDto [recommend_no=" + recommend_no + ", recommend_id=" + recommend_id + ", recommend_age="
				+ recommend_age + ", recommend_genre=" + recommend_genre + ", recommend_favor=" + recommend_favor
				+ ", recommend_date=" + recommend_date + "]";
	}
	
	

}
