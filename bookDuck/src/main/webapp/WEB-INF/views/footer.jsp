<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- nanum square regular -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css"> 
</head>
<style>
	/* nanumsquare bold */
	@font-face{
		font-family : 'Nanum Square Bold';
		src: url("font/NanumSquare_acB.ttf");
	}
	/* nanumbarungothic light*/
	@font-face{
		font-family: 'NanumBarun light';
		src: url("font/NanumBarunGothicLight.ttf")
	}
	
    #footer{
        width:80%;
        height:200px;
        margin:auto;
        margin-top:50px;
    }
    #footer-1{
        width:100%;
        height:20%;
        border-top:1px solid lightgray;
        border-bottom:1px solid lightgray;
        text-align: center;
        font-family: 'Nanum Square Bold';
        transform:skew(-0.03deg);
    }
    #footer-2{width:100%;height:80%;}
    #footer-1, #footer-2{padding-left:50px}
    #footer-1 > a{
        text-decoration:none;
        font-weight: 600;
        margin:10px;
        line-height: 40px;
        color: black;
    }
    #footer-2>p{
        margin: 0;
        padding:10px;
        font-size: 13px;
        letter-spacing: 2px;
    }
    #p1{font-family:'NanumBarun light'; font-weight: normal;}
    #p2{text-align:center; font-family: 'NanumSquare'; transform:skew(-0.03deg);}
</style>
<body>

	<div id="footer">
        <div id="footer-1">
            <a href="goHome.do">HOME</a> | 
            <a href="booksearch.do">도서검색</a> | 
            <a href="noticeList.do">공지사항</a> | 
            <a href="qnaList.do">Q & A</a> 
            <c:if test="${empty Ldto }"> |  <a href="joinform.do">회원가입</a></c:if>
        </div>

        <div id="footer-2">
        	<br>
            <p id="p1">
                KH정보교육원 강남지원1관 Q클래스 오전반 3조 파이널프로젝트 <br>
                지 연 소윤정 강성필 박은희 한우빈 이정은 <br>
                지도강사 이동헌 <br>
                주소. 서울 강남구 테헤란로14길 6 남도빌딩 2층, 3층, 4층 
            </p>
            <br>
            <p id="p2">Copyright ⓒ 2021 KH Information Educational Institute All Right Reserved</p>     
        </div>
    </div>
</body>
</html>