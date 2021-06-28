<%@page import="com.spring.bookduck.introduce.dto.IntroduceDto"%>
<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
  <%
  MemberDto dto1 = (MemberDto)session.getAttribute("Ldto");
  %>
 <header>
</header>
	<c:if test="${Ldto != null }"><a href="logout.do">로그아웃</a></c:if>
	
	<c:if test="${Ldto != null }">
		<p>${Ldto.member_id }님 안녕하세요.</p>
		<a href="mypage.do?member_id=${Ldto.member_id}&member_payrole=${Ldto.member_payrole}">MYPAGE</a>
		<a href="updatePwForm.do">비밀번호변경</a>
		<a href="leaveAccountForm.do">회원탈퇴</a>
	</c:if>
	
	<script>
        var naver_id_login = new naver_id_login("Hft3mSmHcCpHqnsB7j3E", "http://localhost:8787/bookduck/login_callback.do"); // 역시 마찬가지로 'localhost'가 포함된 CallBack URL
        
        // 접근 토큰 값 출력
        alert(naver_id_login.oauthParams.access_token);
        
        // 네이버 사용자 프로필 조회
        naver_id_login.get_naver_userprofile("naverSignInCallback()");
        
        // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
        function naverSignInCallback() {
            alert(naver_id_login.getProfileData('email'));
            alert(naver_id_login.getProfileData('nickname'));
            alert(naver_id_login.getProfileData('age'));
        }
    </script>
	
</body>
</html>