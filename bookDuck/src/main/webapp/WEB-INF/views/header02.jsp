<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#header{
        width:80%;
        height:100px;
        padding-top: 20px;
        margin:auto;
    }
    
    #header>div{width:100%; margin-bottom:10px}
    #header_1{height:40%;}
    #header_2{height:60%;}

    #header_1>div{
        height:100%;
        float:left;
    }
    #header_1_left{width:30%;position:relative;}
    #header_1_center{width:40%;}
    #header_1_right{width:30%;}
    
    #header_2>ul{width:100%; height:100%; list-style-type: none; margin: auto; padding:0;}
    #header_2>ul>li{diplay: inline-block; width:25%; height:100%; line-height: 55px; text-align:center;}
    #header_2>ul>li a{text-decoration: none; color:black; font-size: 18px; font-weight: 900;}
    
    .content{
    	width: 80%;
    	margin: auto;
    }
    .innerOuter{
        width:80%;
        margin:auto;
        padding:5% 10%;
        background:white;
    }
    a{text-decoration: none; color: black;}
</style>
</head>
<body>
	<div id="header">
		<div id="header_1">
			<div id="header_1_left">
				<img src="" alt="">
			</div>
			<div id="header_1_center"></div>
			<div id="header_1_right">
				<c:choose>
					<c:when test="${empty Ldto }">
					<!-- 로그인 전 -->
						<a href="joinform.do">회원가입</a>
						<a href="loginform.do">로그인</a>
					</c:when>
					<c:otherwise>
					<!-- 로그인 후 -->
						${Ldto.member_id }님 안녕하세요.
						<a href="mypage.do?member_id=${Ldto.member_id}&member_payrole=${Ldto.member_payrole}">MYPAGE</a>
						<a href="logout.do">로그아웃</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div id="header_2">
			<ul>
				<li><a href="">추천페이지</a></li>
				<li><a href="noticeList.do">공지사항</a></li>
				<li><a href="qnaList.do">문의사항</a></li>
			</ul>
		</div>
	</div>
</body>
</html>