<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
MemberDto dto1 = (MemberDto) session.getAttribute("Ldto");
PayDto dto = (PayDto) session.getAttribute("payDto");
%>
<link href="css/pay.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../header.jsp" />
	<div class="content">
	
		<div class="innerOuter">
			<div  style="width:200px; height:150px; float:left;">
				<form action="insertpay.do" method="post" class="payForm">
					<div class="idForm">
						<h1>결제</h1>
					</div>
					<div>
						<div class="passForm">
							<input name="pay_id" value="${Ldto.member_id}" class="id" readonly="readonly" />
						</div>
						<div>
							<p>회원권 구매가</p>
							<input name="pay_price" value="5000" class="price" readonly="readonly"/> 
						</div>
					</div>
					<input type="submit" value="결제" class="btn" />
				</form>
			</div>
		</div>
	</div>

</body>
</html>