package com.spring.bookduck.pay.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.model.dto.MemberDto;
import com.spring.bookduck.pay.biz.PayBiz;
import com.spring.bookduck.pay.dto.PayDto;

@Controller
public class PayController {

	private Logger logger = LoggerFactory.getLogger(PayController.class);

	@Autowired
	private PayBiz biz;

	@RequestMapping("payorder.do")
	public String payorder(Model model) {
		logger.info("[Controller]  payorder.do ");
		return "pay/payorder";
	}

	@RequestMapping("insertpay.do")
	public String insertpay(PayDto dto, Model model) {

		
		logger.info("[Controller]  payinsertpay.do ");
		model.addAttribute("pay_id", dto.getPay_id());//결제 아이디
		model.addAttribute("pay_price", dto.getPay_price());//결제 금액

		return "pay/pay";
	}

	@RequestMapping("pay.do")
	public String pay(PayDto dto, HttpServletRequest request) {
		logger.info("[Controller]  pay.do ");
		String pay_id = request.getParameter("pay_id");
		String pay_price = request.getParameter("pay_price");	
		//입력받은 데이터를 받아서 결제후에 아래의 객체들을 if 문을통해서 변경후 성공시 홈으로 이동
		dto.setPay_id(pay_id);
		dto.setPay_price(pay_price);
		dto.setMember_id(pay_id);
		//아래는 결제 정보 입력 로그
		int payInsertRes = biz.insertPay(dto);
		//아래는 결제시 회원정보 수정 로그
		int memberUpdateRes = biz.updatememberrole(pay_id);
		
		if (payInsertRes > 0 && memberUpdateRes > 0) {
			logger.info("[Controller]  success ");
			//성공시 success.do 통해서 홈
			return "redirect:paysuccess.do";
		}
		//실패해도 홈
		return "home";
	}
	//성공시 홈
	@RequestMapping("paysuccess.do")
	public String paysuccess(HttpSession session) {
		session.invalidate();
		logger.info("[Controller]  paysuccess.do ");
		
		return "home";
	}
	//결제취소시
	@RequestMapping("paycancel.do")
	public String paycancel() {
		logger.info("[Controller]  paycancel.do ");

		return "home";
	}


	
}
