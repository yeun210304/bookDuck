<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
request.setCharacterEncoding("UTF-8");

//절대경로 확인
String path = request.getContextPath();

String coverLargeUrl = request.getParameter("coverLargeUrl");
String title = request.getParameter("title");
String isbn = request.getParameter("isbn");
String author = request.getParameter("author");
String categoryId = request.getParameter("categoryId");


if(title == null){
	coverLargeUrl = (String)request.getAttribute("coverLargeUrl");
	title = (String)request.getAttribute("title");
	isbn = (String)request.getAttribute("isbn");
	author = (String)request.getAttribute("author");
	categoryId = (String)request.getAttribute("categoryId");
}

System.out.println("-----------");
System.out.println(coverLargeUrl);
System.out.println(title);
System.out.println(isbn);
System.out.println(author);
System.out.println(categoryId);

%>    
<html>
<head>
<meta charset="UTF-8">
<title>도서추천</title>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.1/css/font-awesome.min.css" />
<script type="text/javascript">

	$(function() {
		// 별점
		$('.make_star svg').click(function() {
			var targetNum = $(this).index() + 1;
			$('.make_star svg').css({
				color : '#000'
			});
			$('.make_star svg:nth-child(-n+' + targetNum + ')').css({
				color : '#F05522'
			});
			console.log(targetNum);
		});

	});
	
	// 한줄 낭독
	var voices = [];
	function setVoiceList() {
		voices = window.speechSynthesis.getVoices();
	}
	
	setVoiceList();
	if (window.speechSynthesis.onvoiceschanged !== undefined) {
		window.speechSynthesis.onvoiceschanged = setVoiceList;
	}
	
	function speech(txt) {
		
		if (!window.speechSynthesis) {
			alert("음성 재생을 지원하지 않는 브라우저입니다. 크롬, 파이어폭스 등의 최신 브라우저를 이용하세요");
			return;
		}
		var lang = 'ko-KR';
		var utterThis = new SpeechSynthesisUtterance(txt);
		utterThis.onend = function(event) {
			console.log('end');
		};
		utterThis.onerror = function(event) {
			console.log('error', event);
		};
		var voiceFound = false;
		for (var i = 0; i < voices.length; i++) {
			if (voices[i].lang.indexOf(lang) >= 0
					|| voices[i].lang.indexOf(lang.replace('-', '_')) >= 0) {
				utterThis.voice = voices[i];
				voiceFound = true;
			}
		}
		if (!voiceFound) {
			alert('voice not found');
			return;
		}
		utterThis.lang = lang;
		utterThis.pitch = 1.0; // 0.4 ~ 1.0
		utterThis.rate = 0.7; //속도
		window.speechSynthesis.speak(utterThis);
	
	}
	/*
	document.addEventListener("click", function(e) {
		var t = e.target;
		var input = t.previousElementSibling;
		speech(input.innerHTML);
	});
	*/
	
	
</script>
</head>
<body>
	<div id="book">
		<h3>책정보</h3>
		<img src="<%=coverLargeUrl %>"><br/><br/>
		<b><%=title %></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=author %><br/>
		
	</div><br/>
	
	<div id="star">
		<h3>별점</h3> 
		<b>당신의 별점은?</b> (평균 :   점)
		<br/>
		
		<div class="make_star">
			<div class="rating" data-rate="3" >
				<i class="fas fa-star fa-2x"></i> <i class="fas fa-star fa-2x"></i> <i
					class="fas fa-star fa-2x"></i> <i class="fas fa-star fa-2x"></i> <i
					class="fas fa-star fa-2x"></i>
			</div>
			<button class='btn btn-default btn-xs'>&#127775;&nbsp;별점등록</button>		
		</div>
		
		
		

	</div><br/>
	
	<div id="tts">
		<h3>한줄낭독</h3>
		<div style="display:none">보이나욤</div>
		
		<div>
			<form action="bookfmInsertRes.do" method="post">
				<input type="hidden" name="coverLargeUrl" value="<%=coverLargeUrl %>">
				<input type="hidden" name="title" value="<%=title %>">
				<input type="hidden" name="author" value="<%=author %>">
				<input type="hidden" name="isbn" value="<%=isbn %>">
				<input type="hidden" name="categoryId" value="<%=categoryId %>">
				
				<table>
					<tr>
						<td><input type="hidden" name="bookfm_isbn" value="<%=isbn %>" readonly ></td>
					</tr>
					<tr>
						<td><input type="hidden" name="bookfm_title" value="<%=title %>" readonly></td>
					</tr>
					<tr>
						<td><input type="hidden" name="bookfm_author" value="<%=author %>" readonly ></td>
					</tr>
					<tr>
						<td colspan="3"><textarea name="bookfm_fm" required></textarea></td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<input type="submit" value="등록">
						</td>
					</tr>
				</table>
			</form>
			
			
			<div style="display: none;">
				<c:choose>
					<c:when test="${empty rowlist}">list값이 없습니다.</c:when>
					<c:otherwise>
						<c:forEach items="${rowlist }" var="dto">
							${dto.bookfm_fm}
						
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<button type="button" class='btn btn-default'>&#128265;&nbsp;SPEAK IT!</button>
			
		</div>
	</div>

</body>
</html>