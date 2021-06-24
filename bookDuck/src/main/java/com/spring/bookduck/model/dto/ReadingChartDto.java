package com.spring.bookduck.model.dto;

import java.util.Date;

public class ReadingChartDto {

	private int chartNo;
	private String chartId;
	private String chartTitle;
	private String chartContent;
	private String chartreadingtime;
	private String chartMdate;
	private Date chartRegDate;
	private String chartIsbn;
	
	public ReadingChartDto() {
	}
	public ReadingChartDto(int chartNo, String chartId, String chartTitle, String chartContent, String chartreadingtime,
			String chartMdate, Date chartRegDate, String chartIsbn) {
		super();
		this.chartNo = chartNo;
		this.chartId = chartId;
		this.chartTitle = chartTitle;
		this.chartContent = chartContent;
		this.chartreadingtime = chartreadingtime;
		this.chartMdate = chartMdate;
		this.chartRegDate = chartRegDate;
		this.chartIsbn = chartIsbn;
	}

	public int getChartNo() {
		return chartNo;
	}

	public void setChartNo(int chartNo) {
		this.chartNo = chartNo;
	}

	public String getChartId() {
		return chartId;
	}

	public void setChartId(String chartId) {
		this.chartId = chartId;
	}

	public String getChartTitle() {
		return chartTitle;
	}

	public void setChartTitle(String chartTitle) {
		this.chartTitle = chartTitle;
	}

	public String getChartContent() {
		return chartContent;
	}

	public void setChartContent(String chartContent) {
		this.chartContent = chartContent;
	}

	public String getChartreadingtime() {
		return chartreadingtime;
	}

	public void setChartreadingtime(String chartreadingtime) {
		this.chartreadingtime = chartreadingtime;
	}

	public String getChartMdate() {
		return chartMdate;
	}

	public void setChartMdate(String chartMdate) {
		this.chartMdate = chartMdate;
	}

	public Date getChartRegDate() {
		return chartRegDate;
	}

	public void setChartRegDate(Date chartRegDate) {
		this.chartRegDate = chartRegDate;
	}

	public String getChartIsbn() {
		return chartIsbn;
	}

	public void setChartIsbn(String chartIsbn) {
		this.chartIsbn = chartIsbn;
	}
}
