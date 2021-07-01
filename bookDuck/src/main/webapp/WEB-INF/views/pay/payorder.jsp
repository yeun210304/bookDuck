<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
MemberDto dto1 = (MemberDto) session.getAttribute("Ldto");
PayDto dto = (PayDto) session.getAttribute("payDto");
%>
<link href="css/pay.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../header02.jsp" />

	<div class="content">
		<div class="innerOuter">
			<div>
				<form action="insertpay.do" method="post" class="payForm">
					<div class="idForm">
						<h1>결제</h1>
					</div>
					<div>
						<div class="passForm">
							<p>구매자</p>
							<input name="pay_id" value="${Ldto.member_id}" />
						</div>
						<div>
							<p>상품가격</p>
							<input name="pay_price" value="5000" />
						</div>
					</div>
					<input type="submit" value="결제" class="bottomText" />
				</form>
			</div>
		</div>
	</div>

	<form action="insertpay.do" method="post">
		<div>
			<h3>ID</h3>
			<span> <input name="pay_id" value="${Ldto.member_id}" />
			</span>
		</div>
		<div>
			<h3>결제 금액</h3>
			<span> <input name="pay_price" value="5000" /> <input
				type="button" value="취소" onclick="location.href='paycancel.do'" />
			</span>
		</div>
		<div>
			<input type="submit" value="결제" />
		</div>
	</form>

</body>
</html>