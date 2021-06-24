<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.introduce.dto.IntroduceDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
MemberDto dto1 = (MemberDto) session.getAttribute("Ldto");
%>
<!--SummerNote  -->
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script>
	$(document).ready(function() {
		$('#summernote').summernote();

	});
</script>



<!-- Youtube 검색 -->
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<script>
	//검색창 클릭시 얼럿
	function fnGetList(sGetToken) {
		var $getval = $("#search_box").val();
		if ($getval == "") {
			alert("검색어를 입력하세요.");
			$("#search_box").focus();
			return;
		}
		$("#get_view").empty();
		$("#nav_view").empty();
		//유튜브 API 불러오는부분
		//https://developers.google.com/youtube/v3/docs/search/list
		var order = "relevance";
		var maxResults = "8"; //검색 리스트 개수
		var key = "AIzaSyD5ZALqP1e8SkvfWL65oVDCHTUoibbtJGk";//api key값
		var sTargetUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&order="
				+ order
				+ "&q="
				+ encodeURIComponent($getval)
				+ "&key="
				+ key
				+ "&maxResults=" + maxResults;//검색해서 나온 url

		console.log(sGetToken);
		if (sGetToken != null) {
			sTargetUrl += "&pageToken=" + sGetToken + "";
		}
		console.log(sTargetUrl);
		$.ajax({
			type : "POST",
			url : sTargetUrl,
			dataType : "jsonp",
			success : function(jdata) {
				console.log(jdata);
				$(jdata.items).each(
						function(i) {
							//console.log(this.snippet.channelId);
							$("#get_view").append(
												//검색한 책목록을 ifram api 를 활용해서 영상을 띄운다
											'<iframe width="320" height="180"src="https://www.youtube.com/embed/'+this.id.videoId+'"title="YouTube video player" frameborder="0"allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"allowfullscreen></iframe>'
												);

						}).promise().done(
						function() {//다음 동영상 목록을 열어주는 페이징
							if (jdata.prevPageToken) {
								$("#nav_view").append(
										'<a href="javascript:fnGetList(\''
												+ jdata.prevPageToken
												+ '\');"><이전페이지></a>');
							}
							if (jdata.nextPageToken) {
								$("#nav_view").append(
										'<a href="javascript:fnGetList(\''
												+ jdata.nextPageToken
												+ '\');"><다음페이지></a>');
							}
						});
			},
			error : function(xhr, textStatus) {
				console.log(xhr.responseText);
				alert("에러");
				return;
			}
		});
	}
</script>
</head>
<body>
	<h1>MYPAGE</h1>
	<br/><br/>
	<div>
		<c:choose>
			<c:when test="${Ldto.member_payrole eq 'N'}">
				<div>
					<p>${Ldto.member_id }님은 회원권이 없습니다. </p>
					<a href="payorder.do?">회원 결제하기</a>
				</div>
			</c:when>
			<c:when test="${Ldto.member_payrole eq 'Y'}">
				<p>${Ldto.member_id }님은, 유료회원 입니다.</p>
				<br/><br/>
				<c:choose>
					<c:when test="${empty intdDto.intd_content}">
						<table>
							<tr>
								<td colspan="1" align="center"
									onclick="location.href='intdinsertres.do?member_id=${Ldto.member_id}'">
									자기소개를작성해 주세요</td>
							</tr>
						</table>
						<br/><br/>
						<form name="form1" method="post" onsubmit="return false;">
							<input type="text" id="search_box" placeholder="동영상을 검색하세요">
							<button onclick="fnGetList();">검색</button>
						</form>
						<div id="get_view"></div>
						<div id="nav_view"></div>
						<br/><br/>
						<div>
							<table border="1">
								<col width="50" />
								<col width="100" />
								<col width="50" />
								<tr>
									<th>도서국제번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th>&nbsp;</th>
								</tr>
								<c:choose>
									<c:when test="${empty sclist }">
										<tr>
											<td colspan="5" align="center">------------찜목록이 없습니다.------------</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${sclist }" var="scrapDto">
											<tr>
												<input type="hidden" value="${scrapDto.scrap_no }">
												<td><a href="/">${scrapDto.book_isbn }</a></td>
												<td>${scrapDto.book_title }</td>
												<td>${scrapDto.scrap_regdate }</td>
												<td><a href="scdelete.do?scrap_no=${scrapDto.scrap_no }&member_id=${Ldto.member_id}">삭제</a></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</c:when>
					<c:otherwise>
					<!--///////////////////////////////////  -->
						<table>
							<tr>
								<th>자기소개</th>
								<td id="summernote">${intdDto.intd_content}
								</td>
							</tr>
							<tr>
								<td><input type="button" value="수정"
									onclick="location.href='updateintdres.do?intd_no=${intdDto.intd_no}'">
									<input type="button" value="삭제"
									onclick="location.href='deleteintd.do?intd_no=${intdDto.intd_no}'">
								</td>
							</tr>
						</table>
						<br/><br/>
						<form name="form1" method="post" onsubmit="return false;">
							<input type="text" id="search_box" placeholder="동영상을 검색하세요">
							<button onclick="fnGetList();">검색</button>
						</form>
						<div id="get_view"></div>
						<div id="nav_view"></div>
						<br/><br/>
						<div>
							<table border="1">
								<col width="50" />
								<col width="100" />
								<col width="300" />
								<tr>
									<th>도서국제번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th>&nbsp;</th>
								</tr>
								<c:choose>
									<c:when test="${empty sclist }">
										<tr>
											<td colspan="5" align="center">------------찜목록이 없습니다.------------</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${sclist }" var="scrapDto">
											<tr>
												<input type="hidden" value="${scrapDto.scrap_no }">
												<td><a href="/">${scrapDto.book_isbn }</a></td>
												<td>${scrapDto.book_title }</td>
												<td>${scrapDto.scrap_regdate }</td>
												<td><a href="scdelete.do?scrap_no=${scrapDto.scrap_no }&member_id=${Ldto.member_id}&member_payrole=${Ldto.member_payrole}">삭제</a></td>
												<td><a href="scalldelete.do?scrap_id=${scrapDto.scrap_id }&member_id=${Ldto.member_id}&member_payrole=${Ldto.member_payrole}"></a></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</c:otherwise>
				</c:choose>
			</c:when>
		</c:choose>
		<br/><br/><br/>
		<input type="button" value="Home" onclick="location.href='home.do'" />
	</div>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>




</body>
</html>