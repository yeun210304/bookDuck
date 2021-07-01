package com.spring.bookduck.classify.dto;

public class AiUtilDto {
	
	private String category;
	private String score;
	
	public AiUtilDto() {
	}
	public AiUtilDto(String category, String score) {
		this.category = category;
		this.score = score;
	}

	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	
	

}
