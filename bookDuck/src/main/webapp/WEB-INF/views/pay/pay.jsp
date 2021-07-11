<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<!-- 넘어온 입력값을 c태그로 받아서 아래 스크립트에 넣는다  -->
	<input type="hidden" name="pay_id" value="${pay_id }" />
	<input type="hidden" name="pay_price" value="${pay_price }" />
		<script>
			function iamport() {
				//가맹점 식별코드
				IMP.init('imp37507948');
				IMP.request_pay({
					pg : 'kcp',
					pay_method : 'card',
					merchant_uid : 'merchant_' + new Date().getTime(),
					name : 'BookDuck 회원권', //결제창에서 보여질 이름
					amount : 5000 //실제 결제되는 가격

				}, function(rsp) {
					//결제창이 뜨면 위에 정보들이 적용되고 입력했던 정보가 아래에서 받아서 이프문을통해 성공시 아래 코드가 적용된다.
					if (rsp.success) {
						var msg = '결제가 완료되었습니다.';
						msg += '회원 ID : ' + $("input[name=pay_id]").val();//위에 input에서 value로 받은 pay_id 를 입력 
						msg += '결제 금액 : ' + $("input[name=pay_price]").val();//위에 input에서 value로 받은 pay_price 를 입력
					
						var pay_id = $("input[name=pay_id]").val();
						var pay_price = $("input[name=pay_price]").val();
						//결제가 성공하면 얼럿창으로 로그를 확인하고 
						alert(msg);
						alert('다시 로그인 해주세요.');
						//성공 시 location 으로 정보를 넘기며 컨트롤러에서 코드가 실행된다.
						location.href ='pay.do?pay_id=' + pay_id + '&pay_price=' + pay_price;
						

					} else {
						var msg = '결제에 실패하였습니다.';
						msg += '에러내용 : ' + rsp.error_msg;
						location.href = "payorder.do";
					}

				});
			}
			iamport();
		</script>
</body>
</html>
