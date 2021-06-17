package com.spring.bookduck.pay.dto;

import java.sql.Date;

public class PayDto {
	
	private int pay_no;
	private String pay_price;
	private String pay_data;
	private Date pay_date;
	private String pay_id;
	private String member_id;
	public PayDto() {
		// TODO Auto-generated constructor stub
	}
	public PayDto(int pay_no, String pay_price, String pay_data, Date pay_date, String pay_id, String member_id) {
		super();
		this.pay_no = pay_no;
		this.pay_price = pay_price;
		this.pay_data = pay_data;
		this.pay_date = pay_date;
		this.pay_id = pay_id;
		this.member_id = member_id;
	}
	public int getPay_no() {
		return pay_no;
	}
	public void setPay_no(int pay_no) {
		this.pay_no = pay_no;
	}
	public String getPay_price() {
		return pay_price;
	}
	public void setPay_price(String pay_price) {
		this.pay_price = pay_price;
	}
	public String getPay_data() {
		return pay_data;
	}
	public void setPay_data(String pay_data) {
		this.pay_data = pay_data;
	}
	public Date getPay_date() {
		return pay_date;
	}
	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}
	public String getPay_id() {
		return pay_id;
	}
	public void setPay_id(String pay_id) {
		this.pay_id = pay_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	
}